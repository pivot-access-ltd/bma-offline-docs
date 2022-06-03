<!-- "About creating packer images" -->

<a href="#heading--about-creating-packer-images-for-maas"><h2 id="heading--about-creating-packer-images-for-maas">About creating packer images for MAAS</h2></a>

<a href="#heading--about-packer"><h3 id="heading--about-packer">About packer</h3></a>

The packer code itself: what it does, how it works, and what it provides.

Packer is an open source tool that enables you to create identical machine images for multiple platforms from a single source template. A common use case is creating "golden images" that teams across an organization can use in cloud infrastructure.

Packer is a tool for building identical machine images for multiple platforms from a single source configuration.

Packer is lightweight, runs on every major operating system, and is highly performant, creating machine images for multiple platforms in parallel. Packer comes out of the box with support for many platforms, the full list of which can be found at https://www.packer.io/docs/builders.

Support for other platforms can be added via plugins.

The images that Packer creates can easily be turned into Vagrant boxes.

There are a handful of terms used throughout the Packer documentation where the meaning may not be immediately obvious if you haven't used Packer before. Luckily, there are relatively few. This page documents all the terminology required to understand and use Packer. The terminology is in alphabetical order for quick referencing.

    Artifacts are the results of a single build, and are usually a set of IDs or files to represent a machine image. Every builder produces a single artifact. As an example, in the case of the Amazon EC2 builder, the artifact is a set of AMI IDs (one per region). For the VMware builder, the artifact is a directory of files comprising the created virtual machine.

    Builds are a single task that eventually produces an image for a single platform. Multiple builds run in parallel. Example usage in a sentence: "The Packer build produced an AMI to run our web application." Or: "Packer is running the builds now for VMware, AWS, and VirtualBox."

    Builders are components of Packer that are able to create a machine image for a single platform. Builders read in some configuration and use that to run and generate a machine image. A builder is invoked as part of a build in order to create the actual resulting images. Example builders include VirtualBox, VMware, and Amazon EC2.

    Commands are sub-commands for the packer program that perform some job. An example command is "build", which is invoked as packer build. Packer ships with a set of commands out of the box in order to define its command-line interface.

    Data Sources are components of Packer that fetch data from outside Packer and make it available to use within the template. Example of data sources include Amazon AMI, and Amazon Secrets Manager.

    Post-processors are components of Packer that take the result of a builder or another post-processor and process that to create a new artifact. Examples of post-processors are compress to compress artifacts, upload to upload artifacts, etc.

    Provisioners are components of Packer that install and configure software within a running machine prior to that machine being turned into a static image. They perform the major work of making the image contain useful software. Example provisioners include shell scripts, Chef, Puppet, etc.

    Templates are either HCL or JSON files which define one or more builds by configuring the various components of Packer. Packer is able to read a template and use that information to create multiple machine images in parallel.
    
<a href="#heading--about-packer-dependencies"><h3 id="heading--about-packer-dependencies">About packer dependencies</h3></a>

The four main packer dependencies, and what they do.

<a href="#heading--About the qemu-About the qemu-utils-package"><h3 id="heading--About the qemu-About the qemu-utils-package">utils package</h3></a>

What functionality is provided by the qemu-utils package?

<a href="#heading--About the qemu-About the qemu-system-package"><h3 id="heading--About the qemu-About the qemu-system-package">system package</h3></a>

What functionality is provided by the qemu-system package?

<a href="#heading--about-the-ovmf-packages"><h3 id="heading--about-the-ovmf-packages">About the ovmf packages</h3></a>

What functionality is provided by the ovmf packages?

<a href="#heading--About the cloud-image-About the cloud-image-utils-package"><h3 id="heading--About the cloud-image-About the cloud-image-utils-package">utils package</h3></a>

What functionality is provided by the cloud-image-utils package?

<a href="#heading--about-packer-templates"><h3 id="heading--about-packer-templates">About packer templates</h3></a>

The structure and components of a packer template, and how each part contributes to the building of a packer image.

Packer's behavior is determined by the Packer template, which consists of a series of declarations and commands for Packer to follow. This template tells Packer what plugins (builders, provisioners, post-processors) to use, how to configure each of those plugins, and what order to run them in.

The template contains flexible variable injection tools, as well as built-in functions to help you customize your builds.

Historically, Packer has used a JSON template for its configuration, but Packer is transitioning to a new template configuration format that uses HCL2 -- the same configuration language used by Terraform and HashiCorp's other products. This format is more flexible, more modular, and more concise than the original JSON template format. While the JSON format is still supported, certain new features in the Packer core will only be implemented for the newer HCL format. Please use the side bar to find documentation for the different template formats.

JSON Templates

These Packer templates are JSON files that configure the various components of Packer in order to create one or more machine images. Templates are portable, static, and readable and writable by both humans and computers.

Templates are given to commands such as packer build, which will take the template and actually run the builds within it, producing any resulting machine images.
»JSON Template Structure

The template is a JSON object that has a set of keys configuring various components of Packer. The available keys within a template are listed below. Along with each key, it is noted whether it is required or not.

    builders (required) is an array of one or more objects that defines the builders that will be used to create machine images for this template, and configures each of those builders. For more information on how to define and configure a builder, read the sub-section on configuring builders in templates.

    description (optional) is a string providing a description of what the template does. This output is used only in the inspect command.

    min_packer_version (optional) is a string that has a minimum Packer version that is required to parse the template. This can be used to ensure that proper versions of Packer are used with the template. A max version can't be specified because Packer retains backwards compatibility with packer fix.

    post-processors (optional) is an array of one or more objects that defines the various post-processing steps to take with the built images. If not specified, then no post-processing will be done. For more information on what post-processors do and how they're defined, read the sub-section on configuring post-processors in templates.

    provisioners (optional) is an array of one or more objects that defines the provisioners that will be used to install and configure software for the machines created by each of the builders. If it is not specified, then no provisioners will be run. For more information on how to define and configure a provisioner, read the sub-section on configuring provisioners in templates.

    variables (optional) is an object of one or more key/value strings that defines user variables contained in the template. If it is not specified, then no variables are defined. For more information on how to define and use user variables, read the sub-section on user variables in templates.

»Comments

JSON doesn't support comments and Packer reports unknown keys as validation errors. If you'd like to comment your template, you can prefix a root level key with an underscore. Example:

{
  "_comment": "This is a comment",
  "builders": [{}]
}

Important: Only root level keys can be underscore prefixed. Keys within builders, provisioners, etc. will still result in validation errors.

Note: Packer supports HCL2 from version 1.6.0. The Hashicorp Configuration Language does support comments anywhere in template files. If comments are important to you, consider upgrading your JSON template to HCL2 using the packer hcl2_upgrade command.

One workaround if you are not ready to upgrade to HCL is to use jq to strip unsupported comments from a Packer template before you run packer build.

For example, here is a file named commented_template.json:

{
  "_comment": ["this is", "a multi-line", "comment"],
  "builders": [
    {
      "_comment": "this is a comment inside a builder",
      "type": "null",
      "communicator": "none"
    }
  ],
  "_comment": "this is a root level comment",
  "provisioners": [
    {
      "_comment": "this is a different comment",
      "type": "shell",
      "_comment": "this is yet another comment",
      "inline": ["echo hellooooo"]
    }
  ]
}

If you use the following jq command:

$ jq 'walk(if type == "object" then del(._comment) else . end)' commented_template.json > uncommented_template.json

The tool will produce a new file containing:

{
  "builders": [
    {
      "type": "null",
      "communicator": "none"
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "inline": ["echo hellooooo"]
    }
  ]
}

Once you've got your uncommented file, you can call packer build on it like you normally would.

If your install of jq does not have the walk function and you get an error like

jq: error: walk/1 is not defined at <top-level>,

You can create a file ~/.jq and add the walk function to it by hand.

Template Builders

Within the template, the builders section contains an array of all the builders that Packer should use to generate machine images for the template.

Builders are responsible for creating machines and generating images from them for various platforms. For example, there are separate builders for EC2, VMware, VirtualBox, etc. Packer comes with many builders by default, and can also be extended to add new builders.

This documentation page will cover how to configure a builder in a template. The specific configuration options available for each builder, however, must be referenced from the documentation for that specific builder.

Within a template, a section of builder definitions looks like this:

{
  "builders": [
    // ... one or more builder definitions here
  ]
}

»Builder Definition

A single builder definition maps to exactly one build. A builder definition is a JSON object that requires at least a type key. The type is the name of the builder that will be used to create a machine image for the build.

In addition to the type, other keys configure the builder itself. For example, the AWS builder requires an access_key, secret_key, and some other settings. These are placed directly within the builder definition.

An example builder definition is shown below, in this case configuring the AWS builder:

{
  "type": "amazon-ebs",
  "access_key": "...",
  "secret_key": "..."
}

»Named Builds

Each build in Packer has a name. By default, the name is just the name of the builder being used. In general, this is good enough. Names only serve as an indicator in the output of what is happening. If you want, however, you can specify a custom name using the name key within the builder definition.

This is particularly useful if you have multiple builds defined that use the same underlying builder. In this case, you must specify a name for at least one of them since the names must be unique.
»Communicators

Every build is associated with a single communicator. Communicators are used to establish a connection for provisioning a remote machine (such as an AWS instance or local virtual machine).

All the examples for the various builders show some communicator (usually SSH), but the communicators are highly customizable so we recommend reading the communicator documentation.

Template Communicators

Communicators are the mechanism Packer uses to upload files, execute scripts, etc. with the machine being created.

Communicators are configured within the builder section.

All communicators have the following options:

    communicator (string) - Packer currently supports three kinds of communicators:

        none - No communicator will be used. If this is set, most provisioners also can't be used.

        ssh - An SSH connection will be established to the machine. This is usually the default.

        winrm - A WinRM connection will be established.

    In addition to the above, some builders have custom communicators they can use. For example, the Docker builder has a "docker" communicator that uses docker exec and docker cp to execute scripts and copy files.

    pause_before_connecting (duration string | ex: "1h5m2s") - We recommend that you enable SSH or WinRM as the very last step in your guest's bootstrap script, but sometimes you may have a race condition where you need Packer to wait before attempting to connect to your guest.

    If you end up in this situation, you can use the template option pause_before_connecting. By default, there is no pause. For example if you set pause_before_connecting to 10m Packer will check whether it can connect, as normal. But once a connection attempt is successful, it will disconnect and then wait 10 minutes before connecting to the guest and beginning provisioning.

»Getting Ready to Use the Communicator

Depending on your builder, your communicator may not have all it needs in order to work "out of the box".

If you are building from a cloud image (for example, building on Amazon), there is a good chance that your cloud provider has already preconfigured SSH on the image for you, meaning that all you have to do is configure the communicator in the Packer template.

However, if you are building from a brand-new and unconfigured operating system image, you will almost always have to perform some extra work to configure SSH on the guest machine. For most operating system distributions, this work will be performed by a boot_command that references a file which provides answers to the normally-interactive questions you get asked when installing an operating system. The name of this file varies by operating system; some common examples are the "preseed" file required by Debian, the "kickstart" file required by CentOS or the "answer file", also known as the Autounattend.xml file, required by Windows. For simplicity's sake, we'll refer to this file as the "preseed" file in the rest of the documentation.

If you are unfamiliar with how to use a preseed file for automatic bootstrapping of an image, please either take a look at our quick guides to image bootstrapping, or research automatic configuration for your specific guest operating system. Knowing how to automatically initalize your operating system is critical for being able to successfully use Packer.
»Communicator-Specific Options

For more details on how to use each communicator, visit the communicators page.

Template Engine

All strings within templates are processed by a common Packer templating engine, where variables and functions can be used to modify the value of a configuration parameter at runtime.

The syntax of templates uses the following conventions:

    Anything template related happens within double-braces: {{ }}.
    Functions are specified directly within the braces, such as {{timestamp}}.
    Template variables are prefixed with a period and capitalized, such as {{.Variable}}.

»Functions

Functions perform operations on and within strings, for example the {{timestamp}} function can be used in any string to generate the current timestamp. This is useful for configurations that require unique keys, such as AMI names. By setting the AMI name to something like My Packer AMI {{timestamp}}, the AMI name will be unique down to the second. If you need greater than one second granularity, you should use {{uuid}}, for example when you have multiple builders in the same template.

Here is a full list of the available functions for reference.

    build_name - The name of the build being run.

    build_type - The type of the builder being used currently.

    clean_resource_name - Image names can only contain certain characters and have a maximum length, eg 63 on GCE & 80 on Azure. clean_resource_name will convert upper cases to lower cases and replace illegal characters with a "-" character. Example:

    "mybuild-{{isotime | clean_resource_name}}" will become mybuild-2017-10-18t02-06-30z.

    Note: Valid Azure image names must match the regex ^[^_\\W][\\w-._)]{0,79}$

    Note: Valid GCE image names must match the regex (?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)

    This engine does not guarantee that the final image name will match the regex; it will not truncate your name if it exceeds the maximum number of allowed characters, and it will not validate that the beginning and end of the engine's output are valid. For example, "image_name": {{isotime | clean_resource_name}}" will cause your build to fail because the image name will start with a number, which is why in the above example we prepend the isotime with "mybuild". Exact behavior of clean_resource_name will depend on which builder it is being applied to; refer to build-specific docs below for more detail on how each function will behave.

    env - Returns environment variables. See example in using home variable

    build - This engine will allow you to access, from provisioners and post-processors, special variables that provide connection information and basic instance state information. Usage example:

    {
      "type": "shell-local",
      "environment_vars": ["TESTVAR={{ build `PackerRunUUID`}}"],
      "inline": ["echo $TESTVAR"]
    }

Valid variables to request are:

    ID: Represents the vm being provisioned. For example, in Amazon it is the instance id; in digitalocean, it is the droplet id; in Vmware, it is the vm name.

    Host, Port, User and Password: The host, port, user, and password that Packer uses to access the machine. Useful for using the shell local provisioner to run Ansible or Inspec against the provisioned instance.

    ConnType: Type of communicator being used. For example, for SSH communicator this will be "ssh".

    PackerRunUUID: Current build's unique id. Can be used to specify build artifacts. An example of that, is when multiple builds runs at the same time producing the same artifact. It's possible to differentiate these artifacts by naming them with the builds' unique ids.

    PackerHTTPIP, PackerHTTPPort, and PackerHTTPAddr: HTTP IP, port, and address of the file server Packer creates to serve items in the "http" dir to the vm. The HTTP address is displayed in the format IP:PORT.

    SSHPublicKey and SSHPrivateKey: The public and private key that Packer uses to connect to the instance. These are unique to the SSH communicator and are unset when using other communicators. SSHPublicKey and SSHPrivateKey can have escape sequences and special characters so their output should be single quoted to avoid surprises. For example:

    { ... "provisioners": [{
      "type": "shell",
      "inline": [ "echo '{{ build `SSHPrivateKey`}}' > /tmp/packer-session.pem" ]
      }]
    }

    For backwards compatibility, WinRMPassword is also available through this engine, though it is no different than using the more general Password.

    This function is only for use within specific options inside of provisioners -- these options will be listed as being template engines in the provisioner documentation.

    For builder-specific builder variables, please also refer to the builder docs:
        Amazon EC2: chroot, EBS Volume, EBS, EBS Surrogate, Instance.

    This engine is in beta; please report any issues or requests on the Packer issue tracker on GitHub.

    isotime [FORMAT] - UTC time, which can be formatted. See more examples below in the isotime format reference. strftime FORMAT - UTC time, formated using the ISO C standard format FORMAT. See jehiah/go-strftime for a list of available format specifiers.

    Please note that if you are using a large number of builders, provisioners or post-processors, using the isotime engine directly in the plugin configuration may cause the timestamp to be slightly diffferent for each plugin. This is because the timestamp is generated when each plugin is launched rather than in the initial Packer process. In order to avoid this and make sure the timestamp is consistent across all plugins, set it as a user variable and then access the user variable within your plugins.

    lower - Lowercases the string.

    packer_version - Returns Packer version.

    pwd - The working directory while executing Packer.

    replace - ( old, new string, n int, s ) Replace returns a copy of the string s with the first n non-overlapping instances of old replaced by new.

    replace_all - ( old, new string, s ) ReplaceAll returns a copy of the string s with all non-overlapping instances of old replaced by new.

    split - Split an input string using separator and return the requested substring.

    template_dir - The directory to the template for the build.

    timestamp - The Unix timestamp in UTC when the Packer process was launched. Please note that if you are using a large number of builders, provisioners or post-processors, the timestamp may be slightly different for each one because it is from when the plugin is launched not the initial Packer process. In order to avoid this and make the timestamp consistent across all plugins, set it as a user variable and then access the user variable within your plugins.

    uuid - Returns a random UUID.

    upper - Uppercases the string.

    user - Specifies a user variable.

»Specific to Amazon builders:

    clean_resource_name - AMI names can only contain certain characters. This function will replace illegal characters with a '-" character. Example usage since ":" is not a legal AMI name is: {{isotime | clean_resource_name}}.

»Specific to Google Compute builders:

    clean_resource_name - GCE image names can only contain certain characters and the maximum length is
        This function will convert upper cases to lower cases and replace illegal characters with a "-" character. Example:

    "mybuild-{{isotime | clean_resource_name}}" will become mybuild-2017-10-18t02-06-30z.

    Note: Valid GCE image names must match the regex (?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)

    This engine does not guarantee that the final image name will match the regex; it will not truncate your name if it exceeds 63 characters, and it will not validate that the beginning and end of the engine's output are valid. For example, "image_name": {{isotime | clean_resource_name}}" will cause your build to fail because the image name will start with a number, which is why in the above example we prepend the isotime with "mybuild".

»Specific to Azure builders:

    clean_resource_name - Azure managed image names can only contain certain characters and the maximum length is 80. This function will replace illegal characters with a "-" character. Example:

    "mybuild-{{isotime | clean_resource_name}}" will become mybuild-2017-10-18t02-06-30z.

    Note: Valid Azure image names must match the regex ^[^_\\W][\\w-._)]{0,79}$

    This engine does not guarantee that the final image name will match the regex; it will not truncate your name if it exceeds 80 characters, and it will not validate that the beginning and end of the engine's output are valid. It will truncate invalid characters from the end of the name when converting illegal characters. For example, "managed_image_name: "My-Name::" will be converted to "managed_image_name: "My-Name"

»Template variables

Template variables are special variables automatically set by Packer at build time. Some builders, provisioners and other components have template variables that are available only for that component. Template variables are recognizable because they're prefixed by a period, such as {{ .Name }}. For example, when using the shell builder template variables are available to customize the execute_command parameter used to determine how Packer will run the shell command.

{
  "provisioners": [
    {
      "type": "shell",
      "execute_command": "{{.Vars}} sudo -E -S bash '{{.Path}}'",
      "scripts": ["scripts/bootstrap.sh"]
    }
  ]
}

The {{ .Vars }} and {{ .Path }} template variables will be replaced with the list of the environment variables and the path to the script to be executed respectively.

Note: In addition to template variables, you can specify your own user variables. See the user variable documentation for more information on user variables.
»isotime Function Format Reference

The isotime template engine uses golang to generate timestamps. If you're unfamiliar with golang, then the way you format the timestamp is going to feel a bit unusual compared to how you may be used to formatting datetime strings.

Full docs and examples for the golang time formatting function can be found here

However, the formatting basics are worth describing here. From the golang docs:

    These are predefined layouts for use in Time.Format and time.Parse. The reference time used in the layouts is the specific time:

    Mon Jan 2 15:04:05 MST 2006

    which is Unix time 1136239445. Since MST is GMT-0700, the reference time can be thought of as

    01/02 03:04:05PM '06 -0700

    To define your own format, write down what the reference time would look like formatted your way; see the values of constants like ANSIC, StampMicro or Kitchen for examples. The model is to demonstrate what the reference time looks like so that the Format and Parse methods can apply the same transformation to a general time value.

So what does that look like in a Packer template function? Here's an example of how you'd declare a variable using the isotime function.

"variables": {
  "myvar": "packer-{{isotime `2006-01-02 03:04:05`}}"
}

You can try and modify the following examples in a packer template or in packer console to get an idea of how to set different timestamps:
Input	Output
"packer-{{isotime `2006-01-02`}}"	"packer-2021-05-17"
"packer-{{isotime `Jan-_2-15:04:05.000`}}"	"packer-May-17-23:40:16.786"
"packer-{{isotime `3:04PM`}}"	"packer-11:40PM"
"{{ isotime }}"	"June 7, 7:22:43pm 2014"
"{{isotime `2006-01-02`}}"	"2014-06-07"
"{{isotime `Mon 1504`}}"	"Sat 1922"
"{{isotime `02-Jan-06 03\_04\_05`}}"	"07-Jun-2014 07_22_43"
"{{isotime `Hour15Year200603`}}"	"Hour19Year201407"

Formatting for the function isotime uses the magic reference date Mon Jan 2 15:04:05 -0700 MST 2006, which breaks down to the following:
	Day of Week	Month	Date	Hour	Minute	Second	Year	Timezone
Numeric	-	01	02	03 (15)	04	05	06	-0700
Textual	Monday (Mon)	January (Jan)	-	-	-	-	-	MST

The values in parentheses are the abbreviated, or 24-hour clock values

Note that "-0700" is always formatted into "+0000" because isotime is always UTC time.
»split Function Format Reference

The function split takes an input string, a seperator string, and a numeric component value and returns the requested substring.

Please note that you cannot use the split function on user variables, because we can't nest the functions currently. This function is indended to be used on builder variables like build_name. If you need a split user variable, the best way to do it is to create a separate variable.

Here are some examples using the above options:

build_name = foo-bar-provider

{{split build_name "-" 0}} = foo
{{split "fixed-string" "-" 1}} = string

Please note that double quote characters need escaping inside of templates (in this case, on the fixed-string value):

{
  "post-processors": [
    [
      {
        "type": "vagrant",
        "compression_level": 9,
        "keep_input_artifact": false,
        "vagrantfile_template": "tpl/{{split build_name \"-\" 1}}.rb",
        "output": "output/{{build_name}}.box",
        "only": ["org-name-provider"]
      }
    ]
  ]
}

»replace Function Format Reference

Here are some examples using the replace options:

build_name = foo-bar-provider

{{ replace_all "-" "/" build_name }}  = foo/bar/provider
{{ build_name | replace "-" "/" 1 }} = foo/bar-provider

Template Post-Processors

The post-processor section within a template configures any post-processing that will be done to images built by the builders. Examples of post-processing would be compressing files, uploading artifacts, etc.

Post-processors are optional. If no post-processors are defined within a template, then no post-processing will be done to the image. The resulting artifact of a build is just the image outputted by the builder.

This documentation page will cover how to configure a post-processor in a template. The specific configuration options available for each post-processor, however, must be referenced from the documentation for that specific post-processor.

Within a template, a section of post-processor definitions looks like this:

{
  "post-processors": [
    // ... one or more post-processor definitions here
  ]
}

For each post-processor definition, Packer will take the result of each of the defined builders and send it through the post-processors. This means that if you have one post-processor defined and two builders defined in a template, the post-processor will run twice (once for each builder), by default. There are ways, which will be covered later, to control what builders post-processors apply to, if you wish. It is also possible to prevent a post-processor from running.
»Post-Processor Definition

Within the post-processors array in a template, there are three ways to define a post-processor. There are simple definitions, detailed definitions, and sequence definitions. Another way to think about this is that the "simple" and "detailed" definitions are shortcuts for the "sequence" definition.

A simple definition is just a string; the name of the post-processor. An example is shown below. Simple definitions are used when no additional configuration is needed for the post-processor.

{
  "post-processors": ["compress"]
}

A detailed definition is a JSON object. It is very similar to a builder or provisioner definition. It contains a type field to denote the type of the post-processor, but may also contain additional configuration for the post-processor. A detailed definition is used when additional configuration is needed beyond simply the type for the post-processor. An example is shown below.

{
  "post-processors": [
    {
      "type": "compress",
      "format": "tar.gz"
    }
  ]
}

A sequence definition is a JSON array comprised of other simple or detailed definitions. The post-processors defined in the array are run in order, with the artifact of each feeding into the next, and any intermediary artifacts being discarded. A sequence definition may not contain another sequence definition. Sequence definitions are used to chain together multiple post-processors. An example is shown below, where the artifact of a build is compressed then uploaded, but the compressed result is not kept.

It is very important that any post processors that need to be run in order, be sequenced!

{
  "post-processors": [
    ["compress", { "type": "upload", "endpoint": "http://example.com" }]
  ]
}

As you may be able to imagine, the simple and detailed definitions are simply shortcuts for a sequence definition of only one element.
»Input Artifacts

When using post-processors, the input artifact (coming from a builder or another post-processor) is discarded by default after the post-processor runs. This is because generally, you don't want the intermediary artifacts on the way to the final artifact created.

In some cases, however, you may want to keep the intermediary artifacts. You can tell Packer to keep these artifacts by setting the keep_input_artifact configuration to true. An example is shown below:

{
  "post-processors": [
    {
      "type": "compress",
      "keep_input_artifact": true
    }
  ]
}

This setting will only keep the input artifact to that specific post-processor. If you're specifying a sequence of post-processors, then all intermediaries are discarded by default except for the input artifacts to post-processors that explicitly state to keep the input artifact.

Note: The intuitive reader may be wondering what happens if multiple post-processors are specified (not in a sequence). Does Packer require the configuration to keep the input artifact on all the post-processors? The answer is no, of course not. Packer is smart enough to figure out that at least one post-processor requested that the input be kept, so it will keep it around.
»Run on Specific Builds

You can use the only or except fields to run a post-processor only with specific builds. These two fields do what you expect: only will only run the post-processor on the specified builds and except will run the post-processor on anything other than the specified builds. A sequence of post-processors will execute until a skipped post-processor.

An example of only being used is shown below, but the usage of except is effectively the same. only and except can only be specified on "detailed" fields. If you have a sequence of post-processors to run, only and except will affect that post-processor and stop the sequence.

The -except option can specifically skip a named post processor. The -only option ignores post-processors.

([
  {
    "name": "vbox",
    "type": "vagrant",
    "only": ["virtualbox-iso"]
  },
  {
    "type": "compress"
  }
],
[
  "compress",
  {
    "type": "upload",
    "endpoint": "http://example.com"
  }
])

The values within only or except are build names, not builder types. Name is a required block label in HCL, but in legacy JSON, build names default to the types of their builders (e.g. docker or amazon-ebs or virtualbox-iso), unless a specific name attribute is specified within the configuration.

Template Provisioners

Within the template, the provisioners section contains an array of all the provisioners that Packer should use to install and configure software within running machines prior to turning them into machine images.

Provisioners are optional. If no provisioners are defined within a template, then no software other than the defaults will be installed within the resulting machine images. This is not typical, however, since much of the value of Packer is to produce multiple identical images of pre-configured software.

This documentation page will cover how to configure a provisioner in a template. The specific configuration options available for each provisioner, however, must be referenced from the documentation for that specific provisioner.

Within a template, a section of provisioner definitions looks like this:

{
  "provisioners": [
    // ... one or more provisioner definitions here
  ]
}

For each of the definitions, Packer will run the provisioner for each of the configured builds. The provisioners will be run in the order they are defined within the template.
»Provisioner Definition

A provisioner definition is a JSON object that must contain at least the type key. This key specifies the name of the provisioner to use. Additional keys within the object are used to configure the provisioner, with the exception of a handful of special keys, covered later.

As an example, the "shell" provisioner requires a key such as script which specifies a path to a shell script to execute within the machines being created.

An example provisioner definition is shown below, configuring the shell provisioner to run a local script within the machines:

{
  "type": "shell",
  "script": "script.sh"
}

»Run on Specific Builds

You can use the only or except configurations to run a provisioner only with specific builds. These two configurations do what you expect: only will only run the provisioner on the specified builds and except will run the provisioner on anything other than the specified builds.

An example of only being used is shown below, but the usage of except is effectively the same:

{
  "type": "shell",
  "script": "script.sh",
  "only": ["virtualbox-iso"]
}

The values within only or except are build names, not builder types. If you recall, build names by default are just their builder type, but if you specify a custom name parameter, then you should use that as the value instead of the type. Values within except could also be a post-processor name.
»On Error Provisioner

You can optionally create a single specialized provisioner field called an error-cleanup-provisioner. This provisioner will not run unless the normal provisioning run fails. If the normal provisioning run does fail, this special error provisioner will run before the instance is shut down. This allows you to make last minute changes and clean up behaviors that Packer may not be able to clean up on its own.

For examples, users may use this provisioner to make sure that the instance is properly unsubscribed from any services that it connected to during the build run.

Toy usage example for the error cleanup script:

{
  "builders": [
    {
      "type": "null",
      "communicator": "none"
    }
  ],
  "provisioners": [
    {
      "type": "shell-local",
      "inline": ["exit 2"]
    }
  ],
  "error-cleanup-provisioner": {
    "type": "shell-local",
    "inline": ["echo 'rubber ducky'> ducky.txt"]
  }
}

»Build-Specific Overrides

While the goal of Packer is to produce identical machine images, it sometimes requires periods of time where the machines are different before they eventually converge to be identical. In these cases, different configurations for provisioners may be necessary depending on the build. This can be done using build-specific overrides.

An example of where this might be necessary is when building both an EC2 AMI and a VMware machine. The source EC2 AMI may setup a user with administrative privileges by default, whereas the VMware machine doesn't have these privileges. In this case, the shell script may need to be executed differently. Of course, the goal is that hopefully the shell script converges these two images to be identical. However, they may initially need to be run differently.

This example is shown below:

{
  "type": "shell",
  "script": "script.sh",
  "override": {
    "vmware-iso": {
      "execute_command": "echo 'password' | sudo -S bash {{.Path}}"
    }
  }
}

As you can see, the override key is used. The value of this key is another JSON object where the key is the name of a builder definition. The value of this is in turn another JSON object. This JSON object simply contains the provisioner configuration as normal. This configuration is merged into the default provisioner configuration.
»Pausing Before Running

With certain provisioners it is sometimes desirable to pause for some period of time before running it. Specifically, in cases where a provisioner reboots the machine, you may want to wait for some period of time before starting the next provisioner.

Every provisioner definition in a Packer template can take a special configuration pause_before that is the amount of time to pause before running that provisioner. By default, there is no pause. An example is shown below:

{
  "type": "shell",
  "script": "script.sh",
  "pause_before": "10s"
}

For the above provisioner, Packer will wait 10 seconds before uploading and executing the shell script.
»Retry on error

With certain provisioners it is sometimes desirable to retry when it fails. Specifically, in cases where the provisioner depends on external processes that are not done yet.

Every provisioner definition in a Packer template can take a special configuration max_retries that is the maximum number of times a provisioner will retry on error. By default, there max_retries is zero and there is no retry on error. An example is shown below:

{
  "type": "shell",
  "script": "script.sh",
  "max_retries": 5
}

For the above provisioner, Packer will retry maximum five times until stops failing. If after five retries the provisioner still fails, then the complete build will fail.
»Timeout

Sometimes a command can take much more time than expected

Every provisioner definition in a Packer template can take a special configuration timeout that is the amount of time to wait before considering that the provisioner failed. By default, there is no timeout. An example is shown below:

{
  "type": "shell",
  "script": "script.sh",
  "timeout": "5m"
}

For the above provisioner, Packer will cancel the script if it takes more than 5 minutes.

Timeout has no effect in debug mode.

Template User Variables

User variables allow your templates to be further configured with variables from the command-line, environment variables, Vault, or files. This lets you parameterize your templates so that you can keep secret tokens, environment-specific data, and other types of information out of your templates. This maximizes the portability of the template.

Using user variables expects you to know how configuration templates work. If you don't know how configuration templates work yet, please read that page first.
»Usage

In order to set a user variable, you must define it either within the variables section within your template, or using the command-line -var or -var-file flags.

Even if you want a user variable to default to an empty string, it is best to explicitly define it. This explicitness helps reduce the time it takes for newcomers to understand what can be modified using variables in your template.

The variables section is a key/value mapping of the user variable name to a default value. A default value can be the empty string. An example is shown below:

{
  "variables": {
    "aws_access_key": "",
    "aws_secret_key": ""
  },

  "builders": [
    {
      "type": "amazon-ebs",
      "access_key": "{{user `aws_access_key`}}",
      "secret_key": "{{user `aws_secret_key`}}"
      // ...
    }
  ]
}

In the above example, the template defines two user variables: aws_access_key and aws_secret_key. They default to empty values. Later, the variables are used within the builder we defined in order to configure the actual keys for the Amazon builder.

If the default value is null, then the user variable will be required. This means that the user must specify a value for this variable or template validation will fail.

User variables are used by calling the {{user}} function in the form of {{user 'variable'}}. This function can be used in any value but type within the template: in builders, provisioners, anywhere outside the variables section. User variables are available globally within the rest of the template.
»Environment Variables

Environment variables can be used within your template using user variables. The env function is available only within the default value of a user variable, allowing you to default a user variable to an environment variable. An example is shown below:

{
  "variables": {
    "my_secret": "{{env `MY_SECRET`}}"
  }
}

This will default "my_secret" to be the value of the "MY_SECRET" environment variable (or an empty string if it does not exist).

Why can't I use environment variables elsewhere? User variables are the single source of configurable input to a template. We felt that having environment variables used anywhere in a template would confuse the user about the possible inputs to a template. By allowing environment variables only within default values for user variables, user variables remain as the single source of input to a template that a user can easily discover using packer inspect.

Why can't I use ~ for home variable? ~ is an special variable that is evaluated by shell during a variable expansion. As Packer doesn't run inside a shell, it won't expand ~.
»Consul keys

Consul keys can be used within your template using the consul_key function. This function is available only within the default value of a user variable, for reasons similar to environment variables above.

{
  "variables": {
    "soft_versions": "{{ consul_key `my_image/softs_versions/next` }}"
  }
}

This will default soft_versions to the value of the key my_image/softs_versions/next in consul.

The configuration for consul (address, tokens, ...) must be specified as environment variables, as specified in the Documentation.
»Vault Variables

Secrets can be read from Vault and used within your template as user variables. the vault function is available only within the default value of a user variable, allowing you to default a user variable to a vault secret.

An example of using a v2 kv engine:

If you store a value in vault using vault kv put secret/hello foo=world, you can access it using the following template engine:

{
  "variables": {
    "my_secret": "{{ vault `/secret/data/hello` `foo`}}"
  }
}

which will assign "my_secret": "world"

An example of using a v1 kv engine:

If you store a value in vault using:

vault secrets enable -version=1 -path=secrets kv
vault kv put secrets/hello foo=world

You can access it using the following template engine:

{
  "variables": {
    "VAULT_SECRETY_SECRET": "{{ vault `secrets/hello` `foo`}}"
  }
}

This example accesses the Vault path secret/data/foo and returns the value stored at the key bar, storing it as "my_secret".

In order for this to work, you must set the environment variables VAULT_TOKEN and VAULT_ADDR to valid values.

The api tool we use allows for more custom configuration of the Vault client via environment variables.

The full list of available environment variables is:

"VAULT_ADDR"
"VAULT_AGENT_ADDR"
"VAULT_CACERT"
"VAULT_CAPATH"
"VAULT_CLIENT_CERT"
"VAULT_CLIENT_KEY"
"VAULT_CLIENT_TIMEOUT"
"VAULT_SKIP_VERIFY"
"VAULT_NAMESPACE"
"VAULT_TLS_SERVER_NAME"
"VAULT_WRAP_TTL"
"VAULT_MAX_RETRIES"
"VAULT_TOKEN"
"VAULT_MFA"
"VAULT_RATE_LIMIT"

and detailed documentation for usage of each of those variables can be found here.
»AWS Secrets Manager Variables

Secrets can be read from AWS Secrets Manager and used within your template as user variables. The aws_secretsmanager function is available only within the default value of a user variable, allowing you to default a user variable to an AWS Secrets Manager secret.
»Plaintext Secrets

{
  "variables": {
    "password": "{{ aws_secretsmanager `globalpassword` }}"
  }
}

In the example above it is assumed that the secret globalpassword is not stored as a key pair but as a single non-JSON string value. Which the aws_secretsmanager function will return as a raw string.
»Single Key Secrets

{
  "variables": {
    "password": "{{ aws_secretsmanager `sample/app/password` }}"
  }
}

In the example above it is assumed that only one key is stored in sample/app/password if there are multiple keys stored in it then you need to indicate the specific key you want to fetch as shown below.
»Multiple Key Secrets

{
  "variables": {
    "db_password": "{{ aws_secretsmanager `sample/app/passwords` `db` }}",
    "api_key": "{{ aws_secretsmanager `sample/app/passwords` `api_key` }}"
  }
}

In order to use this function you have to configure valid AWS credentials using one of the following methods:

    Environment Variables
    CLI Configuration Files
    Container Credentials
    Instance Profile Credentials

»Using array values

Some templates call for array values. You can use template variables for these, too. For example, the amazon-ebs builder has a configuration parameter called ami_regions, which takes an array of regions that it will copy the AMI to. You can parameterize this by using a variable that is a list of regions, joined by a ,. For example:

{
  "variables": {
    "destination_regions": "us-west-1,us-west-2"
  },
  "builders": [
    {
      "ami_name": "packer-qs-{{timestamp}}",
      "instance_type": "t2.micro",
      "region": "us-east-1",
      "source_ami_filter": {
        "filters": {
          "name": "*ubuntu-xenial-16.04-amd64-server-*",
          "root-device-type": "ebs",
          "virtualization-type": "hvm"
        },
        "most_recent": true,
        "owners": ["099720109477"]
      },
      "ami_regions": "{{user `destination_regions`}}",
      "ssh_username": "ubuntu",
      "type": "amazon-ebs"
    }
  ]
}

»Setting Variables

Now that we covered how to define and use user variables within a template, the next important point is how to actually set these variables. Packer exposes two methods for setting user variables: from the command line or from a file.
»From the Command Line

To set user variables from the command line, the -var flag is used as a parameter to packer build (and some other commands). Continuing our example above, we could build our template using the command below. The command is split across multiple lines for readability, but can of course be a single line.

$ packer build \
    -var 'aws_access_key=foo' \
    -var 'aws_secret_key=bar' \
    template.json

As you can see, the -var flag can be specified multiple times in order to set multiple variables. Also, variables set later on the command-line override any earlier set variable of the same name.

warning If you are calling Packer from cmd.exe, you should double-quote your variables rather than single-quoting them. For example:

packer build -var "aws_secret_key=foo" template.json
»From a File

Variables can also be set from an external JSON file. The -var-file flag reads a file containing a key/value mapping of variables to values and sets those variables. An example JSON file may look like this:

{
  "aws_access_key": "foo",
  "aws_secret_key": "bar"
}

It is a single JSON object where the keys are variables and the values are the variable values. Assuming this file is in variables.json, we can build our template using the following command:

On Linux :
$ packer build -var-file=variables.json template.json
On Windows :
packer build -var-file variables.json template.json

The -var-file flag can be specified multiple times and variables from multiple files will be read and applied. As you'd expect, variables read from files specified later override a variable set earlier.

Combining the -var and -var-file flags together also works how you'd expect. Variables set later in the command override variables set earlier. So, for example, in the following command with the above variables.json file:

$ packer build \
    -var 'aws_access_key=bar' \
    -var-file=variables.json \
    -var 'aws_secret_key=baz' \
    template.json

Results in the following variables:
Variable	Value
aws_access_key	foo
aws_secret_key	baz
»Sensitive Variables

If you use the environment to set a variable that is sensitive, you probably don't want that variable printed to the Packer logs. You can make sure that sensitive variables won't get printed to the logs by adding them to the "sensitive-variables" list within the Packer template:

{
  "variables": {
    "my_secret": "{{env `MY_SECRET`}}",
    "not_a_secret": "plaintext",
    "foo": "bar"
  },

  "sensitive-variables": ["my_secret", "foo"],
  ...
}

The above snippet of code will function exactly the same as if you did not set "sensitive-variables", except that the Packer UI and logs will replace all instances of "bar" and of whatever the value of "my_secret" is with <sensitive>. This allows you to be confident that you are not printing secrets in plaintext to our logs by accident.
»Recipes
»Making a provisioner step conditional on the value of a variable

There is no specific syntax in Packer templates for making a provisioner step conditional, depending on the value of a variable. However, you may be able to do this by referencing the variable within a command that you execute. For example, here is how to make a shell-local provisioner only run if the do_nexpose_scan variable is non-empty.

{
  "type": "shell-local",
  "command": "if [ ! -z \"{{user `do_nexpose_scan`}}\" ]; then python -u trigger_nexpose_scan.py; fi"
}

»Using HOME Variable

In order to use $HOME variable, you can create a home variable in Packer:

{
  "variables": {
    "home": "{{env `HOME`}}"
  }
}

And this will be available to be used in the rest of the template, i.e.:

{
  "builders": [
    {
      "type": "google",
      "account_file": "{{ user `home` }}/.secrets/gcp-{{ user `env` }}.json"
    }
  ]
}

<a href="#heading--about-the-image-creation-and-installation-process"><h3 id="heading--about-the-image-creation-and-installation-process">About the image creation and installation process</h3></a>

A thumbnail flow of the image creation and installation process, in both words and graphics.

Communicators are the mechanism Packer uses to upload files, execute scripts, etc. with the machine being created.

Communicators are configured within the builder section. Packer currently supports three kinds of communicators:

    none - No communicator will be used. If this is set, most provisioners also can't be used.

    ssh - An SSH connection will be established to the machine. This is usually the default.

    winrm - A WinRM connection will be established.

In addition to the above, some builders have custom communicators they can use. For example, the Docker builder has a "docker" communicator that uses docker exec and docker cp to execute scripts and copy files.

For more details on how to use each communicator, click the links above to be taken to each communicator's page.

SSH Communicator

Communicators are the mechanism Packer uses to upload files, execute scripts, etc. on the machine being created, and are configured within the builder section.

The SSH communicator does this by using the SSH protocol. It is the default communicator for a majority of builders.

If you have an SSH agent configured on the host running Packer, and SSH agent authentication is enabled in the communicator config, Packer will automatically forward the SSH agent to the remote host.
»Getting Ready to Use the SSH Communicator

The SSH communicator is the default communicator for a majority of builders, but depending on your builder it may not work "out of the box".

If you are building from a cloud image (for example, building on Amazon), there is a good chance that your cloud provider has already preconfigured SSH on the image for you, meaning that all you have to do is configure the communicator in the Packer template.

However, if you are building from a brand-new and unconfigured operating system image, you will almost always have to perform some extra work to configure SSH on the guest machine. For most operating system distributions, this work will be performed by a boot command that references a file which provides answers to the normally-interactive questions you get asked when installing an operating system. The name of this file varies by operating system; some common examples are the "preseed" file required by Debian, the "kickstart" file required by CentOS or the "answer file", also known as the Autounattend.xml file, required by Windows. For simplicity's sake, we'll refer to this file as the "preseed" file in the rest of the documentation.

If you are unfamiliar with how to use a preseed file for automatic bootstrapping of an image, please either take a look at our quick guides to image bootstrapping, or research automatic configuration for your specific guest operating system. Knowing how to automatically initalize your operating system is critical for being able to successfully use Packer.
»SSH Communicator

The SSH communicator connects to the host via SSH. If you have an SSH agent configured on the host running Packer, and SSH agent authentication is enabled in the communicator config, Packer will automatically forward the SSH agent to the remote host.

The SSH communicator has the following options:

    ssh_host (string) - The address to SSH to. This usually is automatically configured by the builder.

    ssh_port (int) - The port to connect to SSH. This defaults to 22.

    ssh_username (string) - The username to connect to SSH with. Required if using SSH.

    ssh_password (string) - A plaintext password to use to authenticate with SSH.

    ssh_ciphers ([]string) - This overrides the value of ciphers supported by default by golang. The default value is [ "aes128-gcm@openssh.com", "chacha20-poly1305@openssh.com", "aes128-ctr", "aes192-ctr", "aes256-ctr", ]

    Valid options for ciphers include: "aes128-ctr", "aes192-ctr", "aes256-ctr", "aes128-gcm@openssh.com", "chacha20-poly1305@openssh.com", "arcfour256", "arcfour128", "arcfour", "aes128-cbc", "3des-cbc",

    ssh_clear_authorized_keys (bool) - If true, Packer will attempt to remove its temporary key from ~/.ssh/authorized_keys and /root/.ssh/authorized_keys. This is a mostly cosmetic option, since Packer will delete the temporary private key from the host system regardless of whether this is set to true (unless the user has set the -debug flag). Defaults to "false"; currently only works on guests with sed installed.

    ssh_key_exchange_algorithms ([]string) - If set, Packer will override the value of key exchange (kex) altorighms supported by default by golang. Acceptable values include: "curve25519-sha256@libssh.org", "ecdh-sha2-nistp256", "ecdh-sha2-nistp384", "ecdh-sha2-nistp521", "diffie-hellman-group14-sha1", and "diffie-hellman-group1-sha1".

    ssh_certificate_file (string) - Path to user certificate used to authenticate with SSH. The ~ can be used in path and will be expanded to the home directory of current user.

    ssh_pty (bool) - If true, a PTY will be requested for the SSH connection. This defaults to false.

    ssh_timeout (duration string | ex: "1h5m2s") - The time to wait for SSH to become available. Packer uses this to determine when the machine has booted so this is usually quite long. Example value: 10m.

    ssh_disable_agent_forwarding (bool) - If true, SSH agent forwarding will be disabled. Defaults to false.

    ssh_handshake_attempts (int) - The number of handshakes to attempt with SSH once it can connect. This defaults to 10.

    ssh_bastion_host (string) - A bastion host to use for the actual SSH connection.

    ssh_bastion_port (int) - The port of the bastion host. Defaults to 22.

    ssh_bastion_agent_auth (bool) - If true, the local SSH agent will be used to authenticate with the bastion host. Defaults to false.

    ssh_bastion_username (string) - The username to connect to the bastion host.

    ssh_bastion_password (string) - The password to use to authenticate with the bastion host.

    ssh_bastion_interactive (bool) - If true, the keyboard-interactive used to authenticate with bastion host.

    ssh_bastion_private_key_file (string) - Path to a PEM encoded private key file to use to authenticate with the bastion host. The ~ can be used in path and will be expanded to the home directory of current user.

    ssh_bastion_certificate_file (string) - Path to user certificate used to authenticate with bastion host. The ~ can be used in path and will be expanded to the home directory of current user.

    ssh_file_transfer_method (string) - scp or sftp - How to transfer files, Secure copy (default) or SSH File Transfer Protocol.

    ssh_proxy_host (string) - A SOCKS proxy host to use for SSH connection

    ssh_proxy_port (int) - A port of the SOCKS proxy. Defaults to 1080.

    ssh_proxy_username (string) - The optional username to authenticate with the proxy server.

    ssh_proxy_password (string) - The optional password to use to authenticate with the proxy server.

    ssh_keep_alive_interval (duration string | ex: "1h5m2s") - How often to send "keep alive" messages to the server. Set to a negative value (-1s) to disable. Example value: 10s. Defaults to 5s.

    ssh_read_write_timeout (duration string | ex: "1h5m2s") - The amount of time to wait for a remote command to end. This might be useful if, for example, packer hangs on a connection after a reboot. Example: 5m. Disabled by default.

    ssh_remote_tunnels ([]string) -

    ssh_local_tunnels ([]string) - 

Note: SSH communicator options: ssh_keypair_name, ssh_agent_auth, temporary_key_pair_name and ssh_private_key_file are also supported by the communicator. But they may not be supported for every builder. Please check the builder specific documentation for additional SSH supported options.
»SSH Communicator Details

Packer will only use one authentication method, either publickey or if ssh_password is used packer will offer password and keyboard-interactive both sending the password. In other words Packer will not work with sshd configured with more than one configured authentication method using AuthenticationMethods.

Packer supports the following MACs:

    hmac-sha1
    hmac-sha1-96
    hmac-sha2-256
    hmac-sha2-256-etm@openssh.com

For more information on the ciphers that Packer supports, check the docs for the ssh_ciphers template option.

Builders

Builders create machines and generate images from those machines for various platforms. Packer also has some builders that perform helper tasks, like running provisioners.

Packer has the following types of builders:

    Plugin: Each plugin has its own associated set of builders. For example, there are separate builders for EC2, VMware, VirtualBox, etc.
    File: The file builder creates an artifact from a file.
    Null: The null builder sets up an SSH connection and runs the provisioners.
    Custom: You can write new builders for new or existing platforms.
    Community-Supported: The Packer community develops and maintains builders for several additional platforms.

Refer to the source block documentation to learn more about configuring builders in the Packer templating language.

File Builder

Type: file Artifact BuilderId: packer.file

The file Packer builder is not really a builder, it just creates an artifact from a file. It can be used to debug post-processors without incurring high wait times.
»Basic Example

Below is a fully functioning example. It create a file at target with the specified content.

{
  "type": "file",
  "content": "Lorem ipsum dolor sit amet",
  "target": "dummy_artifact"
}

»Configuration Reference

Configuration options are organized below into two categories: required and optional. Within each category, the available options are alphabetized and described.

Any communicator defined is ignored.
»Required:

    target (string) - The path for the artifact file that will be created. If the path contains directories that don't exist, Packer will create them, too.

»Optional:

You can only define one of source or content. If none of them is defined the artifact will be empty.

    source (string) - The path for a file which will be copied as the artifact.

    content (string) - The content that will be put into the artifact.

Null Builder

Type: null

The null Packer builder is not really a builder, it just sets up an SSH connection and runs the provisioners. It can be used to debug provisioners without incurring high wait times. It does not create any kind of image or artifact.
»Basic Example

Below is a fully functioning example. It doesn't do anything useful, since no provisioners are defined, but it will connect to the specified host via ssh.

{
  "type": "null",
  "ssh_host": "127.0.0.1",
  "ssh_username": "foo",
  "ssh_password": "bar"
}

»Configuration Reference

The null builder has no configuration parameters other than the communicator settings.

Custom Builder

Packer is extensible, allowing you to write new builders without having to modify the core source code of Packer itself. Documentation for creating new builders is covered in the custom builders page of the Packer plugin section.

Community Builders

The following builders are developed and maintained by various members of the Packer community, not by HashiCorp. For more information on how to use community builders, see our docs on extending Packer.
»Community Builders

    ARM builders
        packer-plugin-arm-image - simple builder lets you extend on existing system images.
        packer-builder-arm - flexible builder lets you extend or build images from scratch with variety of options (ie. custom partition table).

    Exoscale builder - A builder to create Exoscale custom templates based on a Compute instance snapshot.

    Huawei Cloud ECS builder - Plugin for creating Huawei Cloud ECS images.

    Citrix XenServer/Citrix Hypervisor - Plugin for creating Citrix XenServer/Citrix Hypervisor images from an iso image or from an existing template.

    XCP-NG/Citrix XenServer/Citrix Hypervisor/Updated Fork - Plugin for creating XCP-NG/Citrix XenServer/Citrix Hypervisor images from an iso image or from an existing template. This is a fork of the orginal, and reccomended by the developers of XCP-NG.

Data Sources

Data sources allow data to be fetched for use in Packer configuration. Use of data sources allows a build to use information defined outside of Packer.

See the data block documentation to learn more about working with data sources. For information on an individual data source, choose it from the sidebar.

Note: Data sources is a feature exclusively available to HCL2 templates included in Packer v1.7.0 (and newer).

Http Data Source

Type: http

The http data source makes an HTTP GET request to the given URL and exports information about the response.
»Basic Example

data "http" "example" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}

»Configuration Reference

Configuration options are organized below into two categories: required and optional. Within each category, the available options are alphabetized and described.
»Required:

    url (string) - The URL to request data from. This URL must respond with a 200 OK response and a text/* or application/json Content-Type.

»Not Required:

    request_headers (map[string]string) - A map of strings representing additional HTTP headers to include in the request.

»Datasource outputs

The outputs for this datasource are as follows:

    url (string) - The URL the data was requested from.

    body (string) - The raw body of the HTTP response.

    request_headers (map[string]string) - A map of strings representing the response HTTP headers. Duplicate headers are concatenated with, according to RFC2616.

Provisioners

Provisioners use builtin and third-party software to install and configure the machine image after booting. Provisioners prepare the system for use, so common use cases for provisioners include:

    installing packages
    patching the kernel
    creating users
    downloading application code

See the provisioner block documentation to learn more about working with provisioners. For information on an individual provisioner, choose it from the sidebar.

Breakpoint Provisioner

Type: breakpoint

The breakpoint provisioner will pause until the user presses "enter" to resume the build. This is intended for debugging purposes, and allows you to halt at a particular part of the provisioning process.

This is independent of the -debug flag, which will instead halt at every step and between every provisioner.
»Basic Example

{
  "builders": [
    {
      "type": "null",
      "communicator": "none"
    }
  ],
  "provisioners": [
    {
      "type": "shell-local",
      "inline": "echo hi"
    },
    {
      "type": "breakpoint",
      "disable": false,
      "note": "this is a breakpoint"
    },
    {
      "type": "shell-local",
      "inline": "echo hi 2"
    }
  ]
}

»Configuration Reference
»Optional

    disable (boolean) - If true, skip the breakpoint. Useful for when you have set multiple breakpoints and want to toggle them off or on. Default: false

    note (string) - a string to include explaining the purpose or location of the breakpoint. For example, you may find it useful to number your breakpoints or label them with information about where in the build they occur

Parameters common to all provisioners:

    pause_before (duration) - Sleep for duration before execution.

    max_retries (int) - Max times the provisioner will retry in case of failure. Defaults to zero (0). Zero means an error will not be retried.

    only (array of string) - Only run the provisioner for listed builder(s) by name.

    override (object) - Override the builder with different settings for a specific builder, eg :

    In HCL2:

    source "null" "example1" {
      communicator = "none"
    }

    source "null" "example2" {
      communicator = "none"
    }

    build {
      sources = ["source.null.example1", "source.null.example2"]
      provisioner "shell-local" {
        inline = ["echo not overridden"]
        override = {
          example1 = {
            inline = ["echo yes overridden"]
          }
        }
      }
    }

In JSON:

{
  "builders": [
    {
      "type": "null",
      "name": "example1",
      "communicator": "none"
    },
    {
      "type": "null",
      "name": "example2",
      "communicator": "none"
    }
  ],
  "provisioners": [
    {
      "type": "shell-local",
      "inline": ["echo not overridden"],
      "override": {
        "example1": {
          "inline": ["echo yes overridden"]
        }
      }
    }
  ]
}

    timeout (duration) - If the provisioner takes more than for example 1h10m1s or 10m to finish, the provisioner will timeout and fail.

»Usage

Insert this provisioner wherever you want the build to pause. You'll see ui output prompting you to press "enter" to continue the build when you are ready.

For example:

==> docker: Pausing at breakpoint provisioner with note "foo bar baz".
==> docker: Press enter to continue.

Once you press enter, the build will resume and run normally until it either completes or errors.

File Provisioner

Type: file

The file Packer provisioner uploads files to machines built by Packer. The recommended usage of the file provisioner is to use it to upload files, and then use shell provisioner to move them to the proper place, set permissions, etc.

Warning: You can only upload files to locations that the provisioning user (generally not root) has permission to access. Creating files in /tmp and using a shell provisioner to move them into the final location is the only way to upload files to root owned locations.

The file provisioner can upload both single files and complete directories.
»Basic Example

{
  "type": "file",
  "source": "app.tar.gz",
  "destination": "/tmp/app.tar.gz"
}

»Configuration Reference

The available configuration options are listed below.
»Configuration Reference

Required Parameters:

    content (string) - This is the content to copy to destination. If destination is a file, content will be written to that file, in case of a directory a file named pkr-file-content is created. It's recommended to use a file as the destination. A template_file might be referenced in here, or any interpolation syntax. This attribute cannot be specified with source or sources.

    source (string) - The path to a local file or directory to upload to the machine. The path can be absolute or relative. If it is relative, it is relative to the working directory when Packer is executed. If this is a directory, the existence of a trailing slash is important. Read below on uploading directories. Mandatory unless sources is set.

    destination (string) - The path where the file will be uploaded to in the machine. This value must be a writable location and any parent directories must already exist. If the provisioning user (generally not root) cannot write to this directory, you will receive a "Permission Denied" error. If the source is a file, it's a good idea to make the destination a file as well, but if you set your destination as a directory, at least make sure that the destination ends in a trailing slash so that Packer knows to use the source's basename in the final upload path. Failure to do so may cause Packer to fail on file uploads. If the destination file already exists, it will be overwritten.

Optional Parameters:

    sources ([]string) - A list of sources to upload. This can be used in place of the source option if you have several files that you want to upload to the same place. Note that the destination must be a directory with a trailing slash, and that all files listed in sources will be uploaded to the same directory with their file names preserved.

    direction (string) - The direction of the file transfer. This defaults to "upload". If it is set to "download" then the file "source" in the machine will be downloaded locally to "destination"

    generated (bool) - For advanced users only. If true, check the file existence only before uploading, rather than upon pre-build validation. This allows users to upload files created on-the-fly. This defaults to false. We don't recommend using this feature, since it can cause Packer to become dependent on system state. We would prefer you generate your files before the Packer run, but realize that there are situations where this may be unavoidable.

Parameters common to all provisioners:

    pause_before (duration) - Sleep for duration before execution.

    max_retries (int) - Max times the provisioner will retry in case of failure. Defaults to zero (0). Zero means an error will not be retried.

    only (array of string) - Only run the provisioner for listed builder(s) by name.

    override (object) - Override the builder with different settings for a specific builder, eg :

    In HCL2:

    source "null" "example1" {
      communicator = "none"
    }

    source "null" "example2" {
      communicator = "none"
    }

    build {
      sources = ["source.null.example1", "source.null.example2"]
      provisioner "shell-local" {
        inline = ["echo not overridden"]
        override = {
          example1 = {
            inline = ["echo yes overridden"]
          }
        }
      }
    }

In JSON:

{
  "builders": [
    {
      "type": "null",
      "name": "example1",
      "communicator": "none"
    },
    {
      "type": "null",
      "name": "example2",
      "communicator": "none"
    }
  ],
  "provisioners": [
    {
      "type": "shell-local",
      "inline": ["echo not overridden"],
      "override": {
        "example1": {
          "inline": ["echo yes overridden"]
        }
      }
    }
  ]
}

    timeout (duration) - If the provisioner takes more than for example 1h10m1s or 10m to finish, the provisioner will timeout and fail.

»Directory Uploads

The file provisioner is also able to upload a complete directory to the remote machine. When uploading a directory, there are a few important things you should know.

First, the destination directory must already exist. If you need to create it, use a shell provisioner just prior to the file provisioner in order to create the directory. If the destination directory does not exist, the file provisioner may succeed, but it will have undefined results.

Next, the existence of a trailing slash on the source path will determine whether the directory name will be embedded within the destination, or whether the destination will be created. An example explains this best:

If the source is /foo (no trailing slash), and the destination is /tmp, then the contents of /foo on the local machine will be uploaded to /tmp/foo on the remote machine. The foo directory on the remote machine will be created by Packer.

If the source, however, is /foo/ (a trailing slash is present), and the destination is /tmp, then the contents of /foo will be uploaded into /tmp directly.

This behavior was adopted from the standard behavior of rsync. Note that under the covers, rsync may or may not be used.
»Uploading files that don't exist before Packer starts

In general, local files used as the source must exist before Packer is run. This is great for catching typos and ensuring that once a build is started, that it will succeed. However, this also means that you can't generate a file during your build and then upload it using the file provisioner later. A convenient workaround is to upload a directory instead of a file. The directory still must exist, but its contents don't. You can write your generated file to the directory during the Packer run, and have it be uploaded later.
»Symbolic link uploads

The behavior when uploading symbolic links depends on the communicator. The Docker communicator will preserve symlinks, but all other communicators will treat local symlinks as regular files. If you wish to preserve symlinks when uploading, it's recommended that you use tar. Below is an example of what that might look like:

$ ls -l files
total 16
drwxr-xr-x  3 mwhooker  staff  102 Jan 27 17:10 a
lrwxr-xr-x  1 mwhooker  staff    1 Jan 27 17:10 b -> a
-rw-r--r--  1 mwhooker  staff    0 Jan 27 17:10 file1
lrwxr-xr-x  1 mwhooker  staff    5 Jan 27 17:10 file1link -> file1
$ ls -l toupload
total 0
-rw-r--r--  1 mwhooker  staff    0 Jan 27 17:10 files.tar

{
  "provisioners": [
    {
      "type": "shell-local",
      "command": "tar cf toupload/files.tar files"
    },
    {
      "destination": "/tmp/",
      "source": "./toupload",
      "type": "file"
    },
    {
      "inline": [
        "cd /tmp && tar xf toupload/files.tar",
        "rm toupload/files.tar"
      ],
      "type": "shell"
    }
  ]
}

»Slowness when transferring large files over WinRM.

Because of the way our WinRM transfers works, it can take a very long time to upload and download even moderately sized files. If you're experiencing slowness using the file provisioner on Windows, it's suggested that you set up an SSH server and use the ssh communicator. If you only want to transfer files to your guest, and if your builder supports it, you may also use the http_directory or http_content directives. This will cause that directory to be available to the guest over http, and set the environment variable PACKER_HTTP_ADDR to the address.

Shell Provisioner

Type: shell

The shell Packer provisioner provisions machines built by Packer using shell scripts. Shell provisioning is the easiest way to get software installed and configured on a machine.

Building Windows images? You probably want to use the PowerShell or Windows Shell provisioners.
»Basic Example

The example below is fully functional.

provisioner "shell" {
    inline = ["echo foo"]
}

»Configuration Reference

The reference of available configuration options is listed below. The only required element is either "inline" or "script". Every other option is optional.

Exactly one of the following is required:

    inline (array of strings) - This is an array of commands to execute. The commands are concatenated by newlines and turned into a single file, so they are all executed within the same context. This allows you to change directories in one command and use something in the directory in the next and so on. Inline scripts are the easiest way to pull off simple tasks within the machine.

    script (string) - The path to a script to upload and execute in the machine. This path can be absolute or relative. If it is relative, it is relative to the working directory when Packer is executed.

    scripts (array of strings) - An array of scripts to execute. The scripts will be uploaded and executed in the order specified. Each script is executed in isolation, so state such as variables from one script won't carry on to the next.

Optional parameters:

    binary (boolean) - If true, specifies that the script(s) are binary files, and Packer should therefore not convert Windows line endings to Unix line endings (if there are any). By default this is false.

    valid_exit_codes (list of ints) - Valid exit codes for the script. By default this is just 0.

    env (map of strings) - A map of key/value pairs to inject prior to the execute_command. Packer injects some environmental variables by default into the environment, as well, which are covered in the section below. Duplicate env settings override environment_vars settings.

    environment_vars (array of strings) - An array of key/value pairs to inject prior to the execute_command. The format should be key=value. Packer injects some environmental variables by default into the environment, as well, which are covered in the section below.

    env_var_format (string) - When we parse the environment_vars that you provide, this gives us a string template to use in order to make sure that we are setting the environment vars correctly. By default it is "%s='%s' ". When used in conjunction with use_env_var_file the default is "export %s='%s'\n"

    use_env_var_file (boolean) - If true, Packer will write your environment variables to a tempfile and source them from that file, rather than declaring them inline in our execute_command. The default execute_command will be chmod +x {{.Path}}; . {{.EnvVarFile}} && {{.Path}}. This option is unnecessary for most cases, but if you have extra quoting in your custom execute_command, then this may be required for proper script execution. Default: false.

    execute_command (string) - The command to use to execute the script. By default this is chmod +x {{ .Path }}; {{ .Vars }} {{ .Path }}, unless the user has set "use_env_var_file": true -- in that case, the default execute_command is chmod +x {{.Path}}; . {{.EnvVarFile}} && {{.Path}}. This is a template engine. Therefore, you may use user variables and template functions in this field. In addition, there are three available extra variables:
        Path is the path to the script to run
        Vars is the list of environment_vars, if configured.
        EnvVarFile is the path to the file containing env vars, if use_env_var_file is true.

    expect_disconnect (boolean) - Defaults to false. When true, allow the server to disconnect from Packer without throwing an error. A disconnect might happen if you restart the SSH server or reboot the host.

    inline_shebang (string) - The shebang value to use when running commands specified by inline. By default, this is /bin/sh -e. If you're not using inline, then this configuration has no effect. Important: If you customize this, be sure to include something like the -e flag, otherwise individual steps failing won't fail the provisioner.

    remote_folder (string) - The folder where the uploaded script will reside on the machine. This defaults to /tmp.

    remote_file (string) - The filename the uploaded script will have on the machine. This defaults to script_nnn.sh.

    remote_path (string) - The full path to the uploaded script will have on the machine. By default this is remote_folder/remote_file, if set this option will override both remote_folder and remote_file.

    skip_clean (boolean) - If true, specifies that the helper scripts uploaded to the system will not be removed by Packer. This defaults to false (clean scripts from the system).

    start_retry_timeout (string) - The amount of time to attempt to start the remote process. By default this is 5m or 5 minutes. This setting exists in order to deal with times when SSH may restart, such as a system reboot. Set this to a higher value if reboots take a longer amount of time.

    pause_after (string) - Wait the amount of time after provisioning a shell script, this pause be taken if all previous steps were successful.

Parameters common to all provisioners:

    pause_before (duration) - Sleep for duration before execution.

    max_retries (int) - Max times the provisioner will retry in case of failure. Defaults to zero (0). Zero means an error will not be retried.

    only (array of string) - Only run the provisioner for listed builder(s) by name.

    override (object) - Override the builder with different settings for a specific builder, eg :

    In HCL2:

    source "null" "example1" {
      communicator = "none"
    }

    source "null" "example2" {
      communicator = "none"
    }

    build {
      sources = ["source.null.example1", "source.null.example2"]
      provisioner "shell-local" {
        inline = ["echo not overridden"]
        override = {
          example1 = {
            inline = ["echo yes overridden"]
          }
        }
      }
    }

In JSON:

{
  "builders": [
    {
      "type": "null",
      "name": "example1",
      "communicator": "none"
    },
    {
      "type": "null",
      "name": "example2",
      "communicator": "none"
    }
  ],
  "provisioners": [
    {
      "type": "shell-local",
      "inline": ["echo not overridden"],
      "override": {
        "example1": {
          "inline": ["echo yes overridden"]
        }
      }
    }
  ]
}

    timeout (duration) - If the provisioner takes more than for example 1h10m1s or 10m to finish, the provisioner will timeout and fail.

»Execute Command Example

To many new users, the execute_command is puzzling. However, it provides an important function: customization of how the command is executed. The most common use case for this is dealing with sudo password prompts. You may also need to customize this if you use a non-POSIX shell, such as tcsh on FreeBSD.
»Sudo Example

Some operating systems default to a non-root user. For example if you login as ubuntu and can sudo using the password packer, then you'll want to change execute_command to be:

"echo 'packer' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"

The -S flag tells sudo to read the password from stdin, which in this case is being piped in with the value of packer.

The above example won't work if your environment vars contain spaces or single quotes; in these cases try removing the single quotes:

"echo 'packer' | sudo -S env {{ .Vars }} {{ .Path }}"

By setting the execute_command to this, your script(s) can run with root privileges without worrying about password prompts.
»FreeBSD Example

FreeBSD's default shell is tcsh, which deviates from POSIX semantics. In order for packer to pass environment variables you will need to change the execute_command to:

chmod +x {{ .Path }}; env {{ .Vars }} {{ .Path }}

Note the addition of env before {{ .Vars }}.
»Default Environmental Variables

In addition to being able to specify custom environmental variables using the environment_vars configuration, the provisioner automatically defines certain commonly useful environmental variables:

    PACKER_BUILD_NAME is set to the name of the build that Packer is running. This is most useful when Packer is making multiple builds and you want to distinguish them slightly from a common provisioning script.

    PACKER_BUILDER_TYPE is the type of the builder that was used to create the machine that the script is running on. This is useful if you want to run only certain parts of the script on systems built with certain builders.

    PACKER_HTTP_ADDR If using a builder that provides an HTTP server for file transfer (such as hyperv, parallels, qemu, virtualbox, and vmware), this will be set to the address. You can use this address in your provisioner to download large files over HTTP. This may be useful if you're experiencing slower speeds using the default file provisioner. A file provisioner using the winrm communicator may experience these types of difficulties.

»Handling Reboots

Provisioning sometimes involves restarts, usually when updating the operating system. Packer is able to tolerate restarts via the shell provisioner.

Packer handles this by retrying to start scripts for a period of time before failing. This allows time for the machine to start up and be ready to run scripts. The amount of time the provisioner will wait is configured using start_retry_timeout, which defaults to a few minutes.

Sometimes, when executing a command like reboot, the shell script will return and Packer will start executing the next one before SSH actually quits and the machine restarts. For this, use pause_before to make Packer wait before executing the next script:

provisioner "shell" {
  script       = "script.sh"
  pause_before = "10s"
  timeout      = "10s"
}

Some OS configurations don't properly kill all network connections on reboot, causing the provisioner to hang despite a reboot occurring. In this case, make sure you shut down the network interfaces on reboot or in your shell script. For example, on Gentoo:

/etc/init.d/net.eth0 stop

»SSH Agent Forwarding

Some provisioning requires connecting to remote SSH servers from within the packer instance. The below example is for pulling code from a private git repository utilizing openssh on the client. Make sure you are running ssh-agent and add your git repo SSH keys into it using ssh-add /path/to/key. When the Packer instance needs access to the SSH keys the agent will forward the request back to your ssh-agent.

Note: when provisioning via git you should add the git server keys into the ~/.ssh/known_hosts file otherwise the git command could hang awaiting input. This can be done by copying the file in via the file provisioner (more secure) or using ssh-keyscan to populate the file (less secure). An example of the latter accessing github would be:

provisioner "shell" {
  inline = [
    "sudo apt-get install -y git",
    "ssh-keyscan github.com >> ~/.ssh/known_hosts",
    "git clone git@github.com:exampleorg/myprivaterepo.git"
  ]
}

»Troubleshooting

My shell script doesn't work correctly on Ubuntu

    On Ubuntu, the /bin/sh shell is dash. If your script has bash-specific commands in it, then put #!/bin/bash -e at the top of your script. Differences between dash and bash can be found on the DashAsBinSh Ubuntu wiki page.

My shell works when I login but fails with the shell provisioner

    See the above tip. More than likely, your login shell is using /bin/bash while the provisioner is using /bin/sh.

My installs hang when using apt-get or yum

    Make sure you add a -y to the command to prevent it from requiring user input before proceeding.

How do I tell what my shell script is doing?

    Adding a -x flag to the shebang at the top of the script (#!/bin/sh -x) will echo the script statements as it is executing.

My builds don't always work the same

    Some distributions start the SSH daemon before other core services which can create race conditions. Your first provisioner can tell the machine to wait until it completely boots.

provisioner "shell" {
  inline = ["sleep 10"]
}

»Quoting Environment Variables

Packer manages quoting for you, so you shouldn't have to worry about it. Below is an example of Packer template inputs and what you should expect to get out:

provisioner "shell" {
  environment_vars = [
    "FOO=foo",
    "BAR=bar's",
    "BAZ=baz=baz",
    "QUX==qux",
    "FOOBAR=foo bar",
    "FOOBARBAZ='foo bar baz'",
    "QUX2=\"qux\""
  ]
  inline = [
    "echo \"FOO is $FOO\"",
    "echo \"BAR is $BAR\"",
    "echo \"BAZ is $BAZ\"",
    "echo \"QUX is $QUX\"",
    "echo \"FOOBAR is $FOOBAR\"",
    "echo \"FOOBARBAZ is $FOOBARBAZ\"",
    "echo \"QUX2 is $QUX2\""
  ]
}

Output:

docker: FOO is foo
docker: BAR is bar's
docker: BAZ is baz=baz
docker: QUX is =qux
docker: FOOBAR is foo bar
docker: FOOBARBAZ is 'foo bar baz'
docker: QUX2 is "qux"

Post-Processors

Post-processors run after the image is built by the builder and provisioned by the provisioner(s). Post-processors are optional, and they can be used to upload artifacts, re-package, or more. For more information about post-processors, please choose an option from the sidebar.

See post-processor and post-processors blocks documentations to learn more about working with post-processors.

Artifice Post-Processor

Type: artifice Artifact BuilderId: packer.post-processor.artifice

The artifice post-processor overrides the artifact list from an upstream builder or post-processor. All downstream post-processors will see the new artifacts you specify.

After overriding the artifact with artifice, you can use it with other post-processors, including most of the core post-processors and third-party post-processors.

A major benefit of this is that you can modify builder artifacts using shell-local and pass those modified artifacts into post-processors that may not have worked with the original builder. For example, maybe you want to export a docker container from an amazon-ebs builder and then use Docker-push to put that Docker container into your Docker Hub account.

Artifice allows you to use the familiar packer workflow to create a fresh, stateless build environment for each build on the infrastructure of your choosing. You can use this to build just about anything: buildpacks, containers, jars, binaries, tarballs, msi installers, and more.

Please note that the artifice post-processor will not delete your old artifact files, even if it removes them from the artifact. If you want to delete the old artifact files, you can use the shell-local post-processor to do so.
»Workflow

Artifice helps you tie together a few other packer features:

    A builder, which spins up a VM (or container) to build your artifact
    A provisioner, which performs the steps to create your artifact
    A file provisioner, which downloads the artifact from the VM
    The artifice post-processor, which identifies which files have been downloaded from the VM
    Additional post-processors, which push the artifact to Docker hub, etc.

You will want to perform as much work as possible inside the VM. Ideally the only other post-processor you need after artifice is one that uploads your artifact to the appropriate repository.
»Configuration

The configuration allows you to specify which files comprise your artifact.
»Required:

    files (array of strings) - A list of files that comprise your artifact. These files must exist on your local disk after the provisioning phase of packer is complete. These will replace any of the builder's original artifacts (such as a VM snapshot).

»Optional:

    keep_input_artifact (boolean) - if true, do not delete the original artifact files after creating your new artifact. Defaults to true.

»Example Configuration

This minimal example:

    Spins up a cloned VMware virtual machine
    Installs a consul release
    Downloads the consul binary
    Packages it into a .tar.gz file
    Uploads it to S3.

VMX is a fast way to build and test locally, but you can easily substitute another builder.

{
  "builders": [
    {
      "type": "vmware-vmx",
      "source_path": "/opt/ubuntu-1404-vmware.vmx",
      "ssh_username": "vagrant",
      "ssh_password": "vagrant",
      "shutdown_command": "sudo shutdown -h now",
      "headless": "true",
      "skip_compaction": "true"
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "inline": [
        "sudo apt-get install -y python-pip",
        "sudo pip install ifs",
        "sudo ifs install consul --version=0.5.2"
      ]
    },
    {
      "type": "file",
      "source": "/usr/local/bin/consul",
      "destination": "consul",
      "direction": "download"
    }
  ],
  "post-processors": [
    [
      {
        "type": "artifice",
        "files": ["consul"]
      },
      {
        "type": "compress",
        "output": "consul-0.5.2.tar.gz"
      },
      {
        "type": "shell-local",
        "inline": [
          "/usr/local/bin/aws s3 cp consul-0.5.2.tar.gz s3://<s3 path>"
        ]
      }
    ]
  ]
}

Notice that there are two sets of square brackets in the post-processor section. This creates a post-processor chain, where the output of the proceeding artifact is passed to subsequent post-processors. If you use only one set of square braces the post-processors will run individually against the build artifact (the vmx file in this case) and it will not have the desired result.

{
  "post-processors": [
    [       // <--- Start post-processor chain
      {
        "type": "artifice",
        "files": ["consul"]
      },
      {
        "type": "compress",
        ...
      }
    ],      // <--- End post-processor chain
    {
      "type":"compress"  // <-- Standalone post-processor
    }
  ]
}

You can create multiple post-processor chains to handle multiple builders (for example, building linux and windows binaries during the same build).

Compress Post-Processor

Type: compress Artifact BuilderId: packer.post-processor.compress

The Packer compress post-processor takes an artifact with files (such as from VMware or VirtualBox) and compresses the artifact into a single archive.
»Configuration
»Optional:

By default, packer will build archives in .tar.gz format with the following filename: packer_{{.BuildName}}_{{.BuilderType}}. If you want to change this you will need to specify the output option.

    output (string) - The path to save the compressed archive. The archive format is inferred from the filename. E.g. .tar.gz will be a gzipped tarball. .zip will be a zip file. If the extension can't be detected packer defaults to .tar.gz behavior but will not change the filename.

    This is treated as a template engine. Therefore, you may use user variables and template functions in this field. The following special variables are also available to use in the output template:
        {{.BuildName}}
        {{.BuilderType}}

    If you are executing multiple builders in parallel you should make sure output is unique for each one. For example packer_{{.BuildName}}.zip.

    format (string) - Disable archive format autodetection and use provided string.

    compression_level (number) - Specify the compression level, for algorithms that support it, from 1 through 9 inclusive. Typically higher compression levels take longer but produce smaller files. Defaults to 6

    keep_input_artifact (boolean) - if true, keep both the source files and the compressed file; if false, discard the source files. Defaults to false

»Supported Formats

Supported file extensions include .zip, .tar, .gz, .tar.gz, .lz4 and .tar.lz4. Note that .gz and .lz4 will fail if you have multiple files to compress.
»Examples

Some minimal examples are shown below, showing only the post-processor configuration:

{
  "type": "compress",
  "output": "archive.tar.lz4"
}

{
  "type": "compress",
  "output": "{{.BuildName}}_bundle.zip"
}

{
  "type": "compress",
  "output": "log_{{.BuildName}}.gz",
  "compression_level": 9
}

Checksum Post-Processor

Type: checksum Artifact BuilderId: packer.post-processor.checksum

The checksum post-processor computes specified checksum for the artifact list from an upstream builder or post-processor. All downstream post-processors will see the new artifacts. The primary use-case is compute checksum for artifact to verify it later.

After computes checksum for artifacts, you can use new artifacts with other post-processors like artifice, compress, docker-push, or a third-party post-processor.
»Basic example

{
  "type": "checksum",
  "checksum_types": ["sha1", "sha256"],
  "output": "packer_{{.BuildName}}_{{.ChecksumType}}.checksum"
}

»Configuration Reference

Optional parameters:

    checksum_types (array of strings) - An array of strings of checksum types to compute. If empty, Defaults to md5. Allowed values are:
        md5
        sha1
        sha224
        sha256
        sha384
        sha512

    output (string) - Specify filename to store checksums. This defaults to packer_{{.BuildName}}_{{.BuilderType}}_{{.ChecksumType}}.checksum. For example, if you had a builder named database, you might see the file written as packer_database_docker_md5.checksum. This is treated as a template engine. Therefore, you may use user variables and template functions in this field. The following special variables are also available to use in the output template:
        BuildName: The name of the builder that produced the artifact.
        BuilderType: The type of builder used to produce the artifact.
        ChecksumType: The type of checksums the file contains. This should be used if you have more than one value in checksum_types.

Manifest Post-Processor

Type: manifest Artifact BuilderId: packer.post-processor.manifest

The manifest post-processor writes a JSON file with a list of all of the artifacts packer produces during a run. If your Packer template includes multiple builds, this helps you keep track of which output artifacts (files, AMI IDs, docker containers, etc.) correspond to each build.

The manifest post-processor is invoked each time a build completes and updates data in the manifest file. Builds are identified by name and type, and include their build time, artifact ID, and file list.

If packer is run with the -force flag the manifest file will be truncated automatically during each packer run. Otherwise, subsequent builds will be added to the file. You can use the timestamps to see which is the latest artifact.

You can specify manifest more than once and write each build to its own file, or write all builds to the same file. For simple builds manifest only needs to be specified once (see below) but you can also chain it together with other post-processors such as Docker and Artifice.
»Configuration
»Optional:

    output (string) - The manifest will be written to this file. This defaults to packer-manifest.json.

    strip_path (bool) - Write only filename without the path to the manifest file. This defaults to false.

    strip_time (bool) - Don't write the build_time field from the output.

    custom_data (map[string]string) - Arbitrary data to add to the manifest. This is a template engine. Therefore, you may use user variables and template functions in this field.

Note: Unlike most other post-processors, the keep_input_artifact option doesn't apply for the manifest post-processor. We will always retain the input artifact for manifest, since deleting the files we just recorded is not a behavior anyone should ever expect.
»Example Configuration

The minimal way to use the manifest post-processor is by just writing its definition, like:

{
  "post-processors": [
    {
      "type": "manifest"
    }
  ]
}

A more complete example:

{
  "post-processors": [
    {
      "type": "manifest",
      "output": "manifest.json",
      "strip_path": true,
      "custom_data": {
        "my_custom_data": "example"
      }
    }
  ]
}

An example manifest file looks like:

{
  "builds": [
    {
      "name": "docker",
      "builder_type": "docker",
      "build_time": 1507245986,
      "files": [
        {
          "name": "packer_example",
          "size": 102219776
        }
      ],
      "artifact_id": "Container",
      "packer_run_uuid": "6d5d3185-fa95-44e1-8775-9e64fe2e2d8f",
      "custom_data": {
        "my_custom_data": "example"
      }
    }
  ],
  "last_run_uuid": "6d5d3185-fa95-44e1-8775-9e64fe2e2d8f"
}

If the build is run again, the new build artifacts will be added to the manifest file rather than replacing it. It is possible to grab specific build artifacts from the manifest by using packer_run_uuid.

The above manifest was generated with the following template:

{
  "builders": [
    {
      "type": "docker",
      "image": "ubuntu:latest",
      "export_path": "packer_example",
      "run_command": ["-d", "-i", "-t", "--entrypoint=/bin/bash", "{{.Image}}"]
    }
  ],
  "post-processors": [
    {
      "type": "manifest",
      "output": "manifest.json",
      "strip_path": true,
      "custom_data": {
        "my_custom_data": "example"
      }
    }
  ]
}

Example usage:

The manifest can be very useful for cleaning up old artifacts, or printing important values to logs. The following example uses jq, a command-line tool for parsing json output, to find and echo the AWS ami-id of an ami created by a build.


#!/bin/bash

AMI_ID=$(jq -r '.builds[-1].artifact_id' manifest.json | cut -d ":" -f2)
echo $AMI_ID

Local Shell Post Processor

Type: shell-local

The local shell post processor executes scripts locally during the post processing stage. Shell local provides a convenient way to automate executing some task with packer outputs and variables.
»Basic example

The example below is a fully functional self-contained build.

source "file" "example" {
    content = "example content"
}

build {
  source "source.file.example" {
    target = "./test_artifact.txt"
  }

  post-processor "shell-local" {
    inline = ["echo foo"]
  }
}

»Configuration Reference

The reference of available configuration options is listed below. The only required element is either "inline" or "script". Every other option is optional.

Exactly one of the following is required:

    command (string) - This is a single command to execute. It will be written to a temporary file and run using the execute_command call below.

    inline (array of strings) - This is an array of commands to execute. The commands are concatenated by newlines and turned into a single file, so they are all executed within the same context. This allows you to change directories in one command and use something in the directory in the next and so on. Inline scripts are the easiest way to pull off simple tasks within the machine.

    script (string) - The path to a script to execute. This path can be absolute or relative. If it is relative, it is relative to the working directory when Packer is executed.

    scripts (array of strings) - An array of scripts to execute. The scripts will be executed in the order specified. Each script is executed in isolation, so state such as variables from one script won't carry on to the next.

Optional parameters:

    env (map of strings) - A map of key/value pairs to inject prior to the execute_command. Packer injects some environmental variables by default into the environment, as well, which are covered in the section below. Duplicate env settings override environment_vars settings.

    environment_vars (array of strings) - An array of key/value pairs to inject prior to the execute_command. The format should be key=value. Packer injects some environmental variables by default into the environment, as well, which are covered in the section below.

    env_var_format (string) - When we parse the environment_vars that you provide, this gives us a string template to use in order to make sure that we are setting the environment vars correctly. By default on Windows hosts this format is set %s=%s && and on Unix, it is %s='%s'. You probably won't need to change this format, but you can see usage examples for where it is necessary below.

    execute_command (array of strings) - The command used to execute the script. By default, on *nix systems this is:

    ["/bin/sh", "-c", "{{.Vars}} {{.Script}}"]

While on Windows, execute_command defaults to:

["cmd", "/V", "/C", "{{.Vars}}", "call", "{{.Script}}"]

    This is treated as a template engine. There are several available variables: Script, which is the path to the script to run, and Vars, which is the list of environment_vars, if configured. In addition, you may access any of the variables stored in the generated data using the build template function. If you choose to set this option, make sure that the first element in the array is the shell program you want to use (for example, "sh" or "/usr/local/bin/zsh" or even "powershell.exe" although anything other than a flavor of the shell command language is not explicitly supported and may be broken by assumptions made within Packer). It's worth noting that if you choose to try to use shell-local for Powershell or other Windows commands, the environment variables will not be set properly for your environment.

    For backwards compatibility, execute_command will accept a string instead of an array of strings. If a single string or an array of strings with only one element is provided, Packer will replicate past behavior by appending your execute_command to the array of strings ["sh", "-c"]. For example, if you set "execute_command": "foo bar", the final execute_command that Packer runs will be ["sh", "-c", "foo bar"]. If you set "execute_command": ["foo", "bar"], the final execute_command will remain ["foo", "bar"].

    Again, the above is only provided as a backwards compatibility fix; we strongly recommend that you set execute_command as an array of strings.

    inline_shebang (string) - The shebang value to use when running commands specified by inline. By default, this is /bin/sh -e. If you're not using inline, then this configuration has no effect. Important: If you customize this, be sure to include something like the -e flag, otherwise individual steps failing won't fail the provisioner.

    keep_input_artifact (boolean) - Unlike most other post-processors, the keep_input_artifact option will have no effect for the shell-local post-processor. Packer will always retain the input artifact for shell-local, since the shell-local post-processor merely passes forward the artifact it receives. If your shell-local post-processor produces a file or files which you would like to have replace the input artifact, you may overwrite the input artifact using the artifice post-processor after your shell-local processor has run.

    only_on (array of strings) - This is an array of runtime operating systems where shell-local will execute. This allows you to execute shell-local only on specific operating systems. By default, shell-local will always run if only_on is not set."

    use_linux_pathing (bool) - This is only relevant to windows hosts. If you are running Packer in a Windows environment with the Windows Subsystem for Linux feature enabled, and would like to invoke a bash script rather than invoking a Cmd script, you'll need to set this flag to true; it tells Packer to use the linux subsystem path for your script rather than the Windows path. (e.g. /mnt/c/path/to/your/file instead of C:/path/to/your/file). Please see the example below for more guidance on how to use this feature. If you are not on a Windows host, or you do not intend to use the shell-local post-processor to run a bash script, please ignore this option. If you set this flag to true, you still need to provide the standard windows path to the script when providing a script. This is a beta feature.

    valid_exit_codes (list of ints) - Valid exit codes for the script. By default this is 0.

»Execute Command

To many new users, the execute_command is puzzling. However, it provides an important function: customization of how the command is executed. The most common use case for this is dealing with sudo password prompts. You may also need to customize this if you use a non-POSIX shell, such as tcsh on FreeBSD.
»The Windows Linux Subsystem

The shell-local post-processor was designed with the idea of allowing you to run commands in your local operating system's native shell. For Windows, we've assumed in our defaults that this is Cmd. However, it is possible to run a bash script as part of the Windows Linux Subsystem from the shell-local post-processor, by modifying the execute_command and the use_linux_pathing options in the post-processor config.

The example below is a fully functional test config.

One limitation of this offering is that "inline" and "command" options are not available to you; please limit yourself to using the "script" or "scripts" options instead.

Please note that this feature is still in beta, as the underlying WSL is also still in beta. There will be some limitations as a result. For example, it will likely not work unless both Packer and the scripts you want to run are both on the C drive.

source "null" "example" {
    communicator = "none"
}

build {
    sources = [
        "source.null.example"
    ]

    post-processor "shell-local"{
        environment_vars  = ["PROVISIONERTEST=ProvisionerTest1"]
        execute_command   = ["bash", "-c", "{{.Vars}} {{.Script}}"]
        use_linux_pathing = true
        scripts           = ["C:/Users/me/scripts/example_bash.sh"]
    }
    post-processor "shell-local"{
        environment_vars  = ["PROVISIONERTEST=ProvisionerTest2"]
        execute_command   = ["bash", "-c", "{{.Vars}} {{.Script}}"]
        use_linux_pathing = true
        script            = "C:/Users/me/scripts/example_bash.sh"
    }
}

»Default Environmental Variables

In addition to being able to specify custom environmental variables using the environment_vars configuration, the provisioner automatically defines certain commonly useful environmental variables:

    PACKER_BUILD_NAME is set to the name of the build that Packer is running. This is most useful when Packer is making multiple builds and you want to distinguish them slightly from a common provisioning script.

    PACKER_BUILDER_TYPE is the type of the builder that was used to create the machine that the script is running on. This is useful if you want to run only certain parts of the script on systems built with certain builders.

»Safely Writing A Script

Whether you use the inline option, or pass it a direct script or scripts, it is important to understand a few things about how the shell-local post-processor works to run it safely and easily. This understanding will save you much time in the process.
»Once Per Builder

The shell-local script(s) you pass are run once per builder. This means that if you have an amazon-ebs builder and a docker builder, your script will be run twice. If you have 3 builders, it will run 3 times, once for each builder.
»Interacting with Build Artifacts

In order to interact with build artifacts, you may want to use the manifest post-processor. This will write the list of files produced by a builder to a json file after each builder is run.

For example, if you wanted to package a file from the file builder into a tarball, you might write this:

{
  "builders": [
    {
      "content": "Lorem ipsum dolor sit amet",
      "target": "dummy_artifact",
      "type": "file"
    }
  ],
  "post-processors": [
    [
      {
        "output": "manifest.json",
        "strip_path": true,
        "type": "manifest"
      },
      {
        "inline": [
          "jq \".builds[].files[].name\" manifest.json | xargs tar cfz artifacts.tgz"
        ],
        "type": "shell-local"
      }
    ]
  ]
}

This uses the jq tool to extract all of the file names from the manifest file and passes them to tar.
»Always Exit Intentionally

If any post-processor fails, the packer build stops and all interim artifacts are cleaned up.

For a shell script, that means the script must exit with a zero code. You must be extra careful to exit 0 when necessary.
»Usage Examples:
»Windows Host

Example of running a .cmd file on windows:

post-processor "shell-local" {
  environment_vars = ["SHELLLOCALTEST=ShellTest1"]
  scripts          = ["./scripts/test_cmd.cmd"]
}

Contents of test_cmd.cmd:

echo %SHELLLOCALTEST%

Example of running an inline command on windows: Required customization: tempfile_extension

post-processor "shell-local" {
  environment_vars   = ["SHELLLOCALTEST=ShellTest2"],
  tempfile_extension = ".cmd",
  inline             = ["echo %SHELLLOCALTEST%"]
}

Example of running a bash command on windows using WSL: Required customizations: use_linux_pathing and execute_command:

post-processor "shell-local" {
  environment_vars  = ["SHELLLOCALTEST=ShellTest3"],
  execute_command   = ["bash", "-c", "{{.Vars}} {{.Script}}"]
  use_linux_pathing = true
  script            = "./scripts/example_bash.sh"
}

Contents of example_bash.sh:

#!/bin/bash
echo $SHELLLOCALTEST

Example of running a PowerShell script on Windows: Required customizations: env_var_format and execute_command.

post-processor "shell-local" {
  environment_vars = ["SHELLLOCALTEST=ShellTest4"]
  execute_command  = ["powershell.exe", "{{.Vars}} {{.Script}}"]
  env_var_format   = "$env:%s=\"%s\"; "
  script           = "./scripts/example_ps.ps1"
}

Example of running a powershell script on windows as "inline": Required customizations: env_var_format, tempfile_extension, and execute_command

post-processor "shell-local" {
  tempfile_extension = ".ps1"
  environment_vars   = ["SHELLLOCALTEST=ShellTest5"]
  execute_command    = ["powershell.exe", "{{.Vars}} {{.Script}}"]
  env_var_format     = "$env:%s=\"%s\"; "
  inline             = ["write-output $env:SHELLLOCALTEST"]
}

»Unix Host

Example of running a Shell script on unix:

post-processor "shell-local" {
  environment_vars = ["PROVISIONERTEST=ProvisionerTest1"]
  scripts = ["./scripts/example_bash.sh"]
}

Example of running a bash "inline" on unix:

post-processor "shell-local" {
  environment_vars = ["PROVISIONERTEST=ProvisionerTest2"]
  inline           = ["echo hello", "echo $PROVISIONERTEST"]
}

Example of running a python script on unix:

post-processor "shell-local" {
  script           = "hello.py"
  environment_vars = ["HELLO_USER=packeruser"]
  execute_command  = [
    "/bin/sh",
    "-c",
    "{{.Vars}} /usr/local/bin/python {{.Script}}"
  ]
}

Where "hello.py" contains:

    import os

    print('Hello, %s!' % os.getenv("HELLO_USER"))

Packer plugins

Packer Plugins allow new functionality to be added to Packer without modifying the core source code. Packer plugins are able to add new components to Packer, such as builders, provisioners, post-processors, and data sources.

This page documents how to use plugins.

If you're interested in developing plugins, see the developing plugins page.

On the left hand side of this page, you can find the available Packer plugins, not all of them are 'official'.
»How Plugins Work

Packer plugins are completely separate, standalone applications that the core of Packer starts and communicates with. Even the components that ship with the Packer core (core builders, provisioners, and post-processors) are implemented in a similar way and run as though they are standalone plugins.

These plugin applications aren't meant to be run manually. Instead, Packer core launches and communicates with them. The next time you run a Packer build, look at your process list and you should see a handful of packer- prefixed applications running. One of those applications is the core; the rest are plugins -- one plugin process is launched for each component used in a Packer build.
»Tiers and Namespaces

Packer plugins are published and maintained by a variety of sources, including HashiCorp, and the Packer community. This website uses tiers and badges to denote the source of a plugin. Additionally, namespaces are used to help users identify the organization or publisher responsible for the integration, as shown in the table below.
Tier	Description	Namespace
Official
	Official plugins are owned and maintained by HashiCorp.	hashicorp
Verified
	Verified plugins are owned and maintained by third-party technology partners. Plugins in this tier indicate HashiCorp has verified the authenticity of the Plugin’s publisher, and that the partner is a member of the HashiCorp Technology Partner Program.	Third-party organization
Community
	Community providers are published by individual maintainers, groups of maintainers, or other members of the Packer community.	Third-party organization or maintainer's individual account
Archived
	Archived plugins are plugins that are no longer maintained by HashiCorp, a partner, or the community. This may occur if an API is deprecated or interest was low.	hashicorp or third-party
»HCP Packer Badge
HCP Packer Ready
is present for plugins that HashiCorp has verified to communicate build status to the HCP Packer registry.
»Installing Plugins

Currently, you do not need to install plugins for builder, provisioner, or post-processor components documented on the Packer website; these components ship with the Packer core and Packer automatically knows how to find and launch them. These instructions are for installing custom components that are not bundled with the Packer core.

The below tabs reference "multi-component" and "single-component" plugins. If you are not sure what kind of plugin you are trying to install, the easiest way to find out is to check the name. If the name starts with packer-plugin-, then it is a multi-component plugin. If the name starts with a prefix that actually says the component type (e.g. packer-provisioner- or packer-builder), then it is a single-component plugin.

Note: Only multi-component plugin binaries -- that is plugins named packer-plugin-*, like the packer-plugin-amazon -- are expected to work with Packer init. The legacy builder, post-processor and provisioner plugin types will keep on being detected but Packer cannot install them automatically. If a plugin you use has not been upgraded to use the multi-component plugin architecture, contact your maintainer to request an upgrade.
»Create a required_plugins block

    Add a required_plugins block to your packer block. Each block will tell Packer what version(s) of a particular plugin can be installed. Make sure to set a valid version constraint string.

Here is an example required_plugins block:

packer {
  required_plugins {
    myawesomecloud = {
      version = ">= 2.7.0"
      source = "github.com/azr/myawesomecloud"
    }
    happycloud = {
      version = ">= 1.1.3"
      source = "github.com/azr/happycloud"
    }
  }
}

    Run packer init from your project directory (the directory containing your Packer templates) to install all missing plugin binaries. Given the above example, Packer will try to look for a GitHub repository owned by user or organization azr named packer-plugin-myawesomecloud and packer-plugin-happycloud.

»Names and Addresses

Each plugin has two identifiers:

    A source address, which is only necessary when requiring a plugin outside the HashiCorp domain.
    A unique local name, which is used everywhere else in a Packer configuration.

»Local Names

Local names allow you to access the components of a plugin and must be unique per configuration.

This is best explained using an example. In the above required_plugins block, we declared the local name "myawesomecloud" for the plugin azr/myawesomecloud. If the "myawesomecloud" plugin contains both an "ebs" builder and an "import" post-processor, then the builder will be accessed in a source block by using:

source "myawesomecloud-ebs" "example" {
  // builder configuration...
}

similarly, the import post-processor would be accessed by declaring the post-processor block:

post-processor "myawesomecloud-import" {
  // post-processor configuration...
}

If we change the required_plugins block to use a different local name "foo":

  required_plugins {
    foo = {
      version = ">= 2.7.0"
      source = "github.com/azr/myawesomecloud"
    }
  }

Then we'd instead access that builder using the source:

source "foo-ebs" "example" {
  // builder configuration...
}

»Source Addresses

A plugin's source address is its global identifier. It also tells Packer where to download it.

Source addresses consist of three parts delimited by slashes (/), as follows:

<HOSTNAME>/<NAMESPACE>/<TYPE>

    Hostname: The hostname of the location/service that distributes the plugin. Currently, the only valid "hostname" is github.com, but we plan to eventually support plugins downloaded from other domains.

    Namespace: An organizational namespace within the specified host. This often is the organization that publishes the plugin.

    Type: A short name for the platform or system the plugin manages. The type is usually the plugin's preferred local name.

For example, the fictional myawesomecloud plugin could belong to the hashicorp namespace on github.com, so its source could be github.com/hashicorp/myawesomecloud, Note: the actual repository that myawesomecloud comes from must always have the name format github.com/hashicorp/packer-plugin-myawesomecloud, but the required_plugins block omits the redundant packer-plugin- repository prefix for brevity.

The source address with all three components given explicitly is called the plugin's fully-qualified address. You will see fully-qualified address in various outputs, like error messages.
»Plugin location

Plugins will usually be located in the PACKER_HOME_DIR.

    packer init will install plugins in the last directory in the following numbered list.

    During the initialization of Packer, any plugin required in the required_plugins section will be looked up in all entries of the following list. First plugin found takes precedence. Two binaries of the same plugin with two different version will be considered as two different plugins. Highest found version matching required_plugins will be taken into consideration.

    The directory where packer is, or the executable directory.
    The current working directory. (".")
    The PACKER_HOME_DIR/plugins directory. PACKER_HOME_DIR refers to Packer's home directory, if it could be found.
    The director(y/ies) under the PACKER_PLUGIN_PATH env var, if PACKER_PLUGIN_PATH is set.

Note: There can be more than one directory in the PACKER_PLUGIN_PATH env var, it will be seperated by a semicolon (;) on Windows systems and a colon (:) on other systems. The order priority will be kept.

Using the following example :

    required_plugins {
      happycloud = {
        version = ">= 2.7.0"
        source = "github.com/azr/happycloud"
      }
    }

The plugin getter will then install the binaries in the following location for a system with no PACKER_PLUGIN_PATH env var set.

    PACKER_HOME_DIR/plugins/github.com/hashicorp/happycloud/

During initialization, on a darwin_amd64 system, Packer will look-up for the following files:

    PACKER_EXEC_DIR/github.com/azr/happycloud/packer-plugin-happycloud_*_x5.0_darwin_amd64
    ./github.com/azr/happycloud/packer-plugin-happycloud_*_x5.0_darwin_amd64
    PACKER_HOME_DIR/plugins/github.com/azr/happycloud/packer-plugin-happycloud_*_x5.0_darwin_amd64
    PACKER_PLUGIN_PATH/github.com/azr/happycloud/packer-plugin-happycloud_*_x5.0_darwin_amd64
    ./packer-plugin-happycloud

The first plugin-name/version files found will take precedence.

For plugins located under the github.com/azr/happycloud/ directory structure an accompanying SHA256SUM file will be required in order for packer init to ensure the plugin being loaded has not been tampered with. The SHA256SUM file will be automatically generated when a plugin is installed via packer init if the plugin was installed manually into PACKER_HOME_DIR/plugins/github.com/azr/happycloud/ then the file PACKER_HOME_DIR/plugins/github.com/azr/happycloud/packer-plugin-happycloud_*_x5.0_darwin_amd64_SHA256SUM must be generated manually as well.

Note: PACKER_HOME_DIR is not an actual env var and refers to Packer's home directory. PACKER_EXEC_DIR is not an actual env var and refers to the directory where packer is, or the executable directory.
»Implicit Github urls

Using the following example :

    required_plugins {
      happycloud = {
        version = ">= 2.7.0"
        source = "github.com/azr/happycloud"
      }
    }

The plugin getter will look for plugins located at:

    github.com/azr/packer-plugin-happycloud

Packer will error if you set the packer-plugin- prefix in a source. This will avoid conflicting with other plugins for other tools, like Terraform.


<a href="#heading--about-packer-created-images"><h3 id="heading--about-packer-created-images">About packer-created images</h3></a>

The basic anatomy of a packer-created image, in both words and graphics.

<a href="#heading--about-packer-timing-issues"><h3 id="heading--about-packer-timing-issues">About packer timing issues</h3></a>

Timing issues associated with packing an image, along with any related sensitivities.
