** 10:17
*** create_audit_event(
EVENT_TYPES.AUTHORISATION,
ENDPOINT.API,
request,
None,
"Created token.",
)
*** create_audit_event(
    EVENT_TYPES.AUTHORISATION,
    ENDPOINT.API,
    request,
    None,
    "Deleted token.",
)
*** create_audit_event(
    EVENT_TYPES.AUTHORISATION,
    ENDPOINT.API,
    request,
    None,
    "Deleted token.",
)
***     create_audit_event(
EVENT_TYPES.NODE,
ENDPOINT.API,
request,
system_id,
"Created bcache.",
    )
*** create_audit_event(
    EVENT_TYPES.NODE,
    ENDPOINT.API,
    request,
    system_id,
    "Deleted bcache.",
)
***     create_audit_event(
EVENT_TYPES.NODE,
ENDPOINT.API,
request,
system_id,
"Updated bcache.",
    )
***     create_audit_event(
EVENT_TYPES.NODE,
ENDPOINT.API,
request,
system_id,
"Created bcache cache set.",
    )
***     create_audit_event(
EVENT_TYPES.NODE,
ENDPOINT.API,
request,
system_id,
"Deleted bcache cache set.",
    )
***     create_audit_event(
EVENT_TYPES.NODE,
ENDPOINT.API,
request,
system_id,
"Updated bcache cache set.",
    )
*** create_audit_event(
    EVENT_TYPES.SETTINGS,
    ENDPOINT.API,
    request,
    None,
    description=("Deleted script '%s'." % script.name),
)
*** create_audit_event(
    EVENT_TYPES.SETTINGS,
    ENDPOINT.API,
    request,
    None,
    description=("Deleted DHCP snippet '%s'." % dhcp_snippet.name),
)
*** create_audit_event(
    EVENT_TYPES.SETTINGS,
    ENDPOINT.API,
    request,
    None,
    description=(
"Deleted package repository '%s'." % package_repository.name
    ),
)
*** create_audit_event(
    EVENT_TYPES.SETTINGS,
    ENDPOINT.API,
    request,
    None,
    description="Deleted script '%s'." % script.name,
)
***     create_audit_event(
EVENT_TYPES.SETTINGS,
ENDPOINT.API,
request,
None,
description=(
    "Reverted script '%s' to revision '%s'."
    % (script.name, revert_to)
),
    )
*** create_audit_event(
    EVENT_TYPES.SETTINGS,
    ENDPOINT.API,
    request,
    None,
    description=(f"Added tag '{tag}' to script '{script.name}'."),
)
*** create_audit_event(
    EVENT_TYPES.SETTINGS,
    ENDPOINT.API,
    request,
    None,
    description=(f"Removed tag '{tag}' from script '{script.name}'."),
)
*** create_audit_event(
    EVENT_TYPES.AUTHORISATION,
    ENDPOINT.API,
    request,
    None,
    description="Imported SSH keys.",
)
*** create_audit_event(
    EVENT_TYPES.AUTHORISATION,
    ENDPOINT.API,
    request,
    None,
    description="Deleted SSH key id='%s'." % id,
)
*** create_audit_event(
    EVENT_TYPES.AUTHORISATION,
    ENDPOINT.API,
    request,
    None,
    description="Imported SSH keys.",
)
*** create_audit_event(
    EVENT_TYPES.TAG,
    ENDPOINT.API,
    request,
    None,
    description=f"Tag '{name}' {action}.",
)
(tag creation event)
*** create_audit_event(
    EVENT_TYPES.TAG,
    ENDPOINT.API,
    request,
    None,
    description=f"Tag '{tag.name}' deleted.",
)
*** create_audit_event(
    EVENT_TYPES.TAG,
    ENDPOINT.API,
    request,
    None,
    description=f"Tag '{tag.name}' created.",
)
*** create_audit_event(
    EVENT_TYPES.AUTHORISATION,
    ENDPOINT.API,
    request,
    None,
    description=(
"Created %s '%s'."
% ("admin" if is_superuser else "user", username)
    ),
)
*** create_audit_event(
    EVENT_TYPES.AUTHORISATION,
    ENDPOINT.API,
    request,
    None,
    description=(
"Deleted %s '%s'."
% ("admin" if user.is_superuser else "user", username)
    ),
)
*** sshkey = super().save()
if self.instance.user is request.user:
    description = "Created SSH key."
else:
    description = "Created SSH key for %s." % self.instance.user
create_audit_event(
    EVENT_TYPES.AUTHORISATION,
    endpoint,
    request,
    None,
    description=description,
)
*** create_audit_event(
    EVENT_TYPES.AUTHORISATION,
    endpoint,
    request,
    None,
    description="Created SSL key.",
)
*** create_audit_event(
    EVENT_TYPES.SETTINGS,
    endpoint,
    request,
    None,
    description=(
"%s DHCP snippet '%s'."
% (
    "Updated" if self.is_update else "Created",
    dhcp_snippet.name,
)
    ),
)
*** create_audit_event(
    EVENT_TYPES.SETTINGS,
    endpoint,
    request,
    None,
    description=(
"%s package repository '%s'."
% (
    "Updated" if self.is_update else "Created",
    package_repository.name,
)
    ),
)
***     create_audit_event(
EVENT_TYPES.SETTINGS,
endpoint,
request,
None,
description="Saved script '%s'." % script.name,
    )
***     with transaction.atomic():
for key, value in config.items():
    config_manager.set_config(key, value)
    create_audit_event(
EVENT_TYPES.SETTINGS,
ENDPOINT.CLI,
description=f"Updated configuration setting '{key}'.",
    )
clear_tls_notifications()
***     create_audit_event(
EVENT_TYPES.SETTINGS,
endpoint,
request,
None,
description=(
    "Updated configuration setting '%s' to '%s'."
    % (name, value)
),
    )
*** Even though this is not the API, the action may raise
:class:`MAASAPIException` exceptions.  When this happens, the view
will return to the client an http response reflecting the exception.
"""
self._execute(*args, **kwargs)
description = self.get_node_action_audit_description(self)
# Log audit event for the action.
create_audit_event(
    EVENT_TYPES.NODE,
    self.endpoint,
    self.request,
    self.node.system_id,
    description=description,
)
*** Even though this is not the API, the action may raise
:class:`MAASAPIException` exceptions.  When this happens, the view
will return to the client an http response reflecting the exception.
"""
description = self.get_node_action_audit_description(self)
# Log audit event for the action.
create_audit_event(
    EVENT_TYPES.NODE,
    self.endpoint,
    self.request,
    self.node.system_id,
    description=description,
)
self._execute(*args, **kwargs)
*** create_audit_event(EVENT_TYPES.NODE_PXE_REQUEST, endpoint, request)
*** create_audit_event(
    EVENT_TYPES.NODE_PXE_REQUEST,
    endpoint,
    request,
    system_id=node.system_id,
)
*** create_audit_event(
    EVENT_TYPES.NODE_PXE_REQUEST,
    endpoint,
    request,
    system_id=node.system_id,
    description=description,
)
*** create_audit_event(EVENT_TYPES.NODE_PXE_REQUEST, endpoint, request)
*** create_audit_event(EVENT_TYPES.SETTINGS, endpoint)