<!-- Primer tutorial the osi model -->
Let’s explore each of the seven layers of the OSI model through this tutorial.  You’ll get to see how these layers stack together to create the Internet we know today. At the end, we’ll draw you a picture of the OSI “network stack” to help you remember what you’ve learned.

<a href="#heading--Physical-Layer"><h2 id="heading--Physical-Layer">Physical Layer</h2></a>

The Physical Layer deals with the physical aspects of network communication, such as cables and connectors. Use the `ifconfig` command on Ubuntu to display physical network interfaces and their configurations:

1. Open a terminal on your Ubuntu system.
2. Type the following command: 

```nohighlight
ifconfig eth0
# (replace "eth0" with the name of your interface if different)
```

This command provides details about the specified network interface, including its MAC address, speed, and media type. Here's an example output:

```nohighlight
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.0.100  netmask 255.255.255.0  broadcast 192.168.0.255
        inet6 fe80::1234:5678:90ab:cdef  prefixlen 64  scopeid 0x20<link>
        ether 00:11:22:33:44:55  txqueuelen 1000  (Ethernet)
        RX packets 123456  bytes 78901234 (78.9 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 234567  bytes 56789012 (56.7 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

In this example, we can observe the following details about the "eth0" interface:

- MAC address: The line ```ether 00:11:22:33:44:55``` displays the MAC (Media Access Control) address, which uniquely identifies the network interface.
- Speed and media type: While not explicitly mentioned in this output, additional information about the speed and media type of the interface may be displayed, depending on the system and network card. This information can include the interface's speed (e.g., 100 Mbps, 1 Gbps) and media type (e.g., Ethernet).

By using the `ifconfig` command and examining the output, we can gain insights into the physical layer attributes of a specific network interface, including its MAC address, speed, and media type. Information at this level is frequently used for troubleshooting network issues, configuring network settings, and understanding the physical characteristics of the network infrastructure.

<a href="#heading--The-Data-Link-Layer"><h2 id="heading--The-Data-Link-Layer">The Data Link Layer</h2></a>

The Data Link Layer is the second layer of the OSI model, responsible for error-free data transfer over a physical link. It handles framing, error detection, and flow control. To see the Data Link Layer in action, use the `arp` command on an Ubuntu system to view the ARP cache:

1. Open a terminal on your Ubuntu system.
2. Type the following command: 

```nohighlight
arp -a
```

Running the `arp -a` command will display the ARP cache entries, which include the IP addresses and corresponding MAC addresses of devices on your local network. Here's an example output:

```nohighlight
router (192.168.0.1) at 00:11:22:33:44:55 [ether] on eth0
laptop (192.168.0.10) at AA:BB:CC:DD:EE:FF [ether] on eth0
printer (192.168.0.20) at 11:22:33:44:55:66 [ether] on eth0
```

The ARP cache shows the translation of IP addresses to MAC addresses:

- IP address: Each entry represents a device on the network and includes its IP address (e.g., "router" has `192.168.0.1`).
- MAC address: The MAC addresses uniquely identify network interfaces (e.g., "router" has `00:11:22:33:44:55`).

Examining the ARP cache with the `arp` command reveals how the Data Link Layer translates IP addresses to MAC addresses. This translation is crucial for network communication, as MAC addresses are used at this layer to identify devices on the local network, while IP addresses are used at the Network Layer for addressing devices across different networks.

<a href="#heading--The-Network-Layer"><h2 id="heading--The-Network-Layer">The Network Layer</h2></a>

The Network Layer, the third layer of the OSI model, handles logical addressing and routing of data across networks. It determines the best path for data packets from source to destination. To see its functionality, use the `ping` command on an Ubuntu system:

1. Open the command prompt or terminal on your Ubuntu system.
2. Type the following command: 

```nohighlight
ping [destination IP address]
```

The "ping" command sends ICMP echo requests to the destination IP address. It measures round-trip time and verifies connectivity between network devices. Here's some example output:

```nohighlight
Pinging 192.168.0.1 with 32 bytes of data:
Reply from 192.168.0.1: bytes=32 time=1ms TTL=64
Reply from 192.168.0.1: bytes=32 time=2ms TTL=64
Reply from 192.168.0.1: bytes=32 time=1ms TTL=64
Reply from 192.168.0.1: bytes=32 time=3ms TTL=64

Ping statistics for 192.168.0.1:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milliseconds:
    Minimum = 1ms, Maximum = 3ms, Average = 1ms
```

Here's what happened:

- Packet routing: When you run the `ping` command, it sends packets containing a request to a specific IP address. The Network Layer determines the best path for these packets to reach the destination by consulting routing tables and protocols like IP.
- Connectivity verification: The `ping` command waits for a reply from the destination device. When it receives the reply, it confirms connectivity and measures the round-trip time. The Network Layer ensures that these packets are properly routed and delivered.

Using `ping`, we can observe how the Network Layer handles packet routing and verifies connectivity between devices. This is important for smooth communication and troubleshooting network issues.

<a href="#heading--The-Transport-Layer"><h2 id="heading--The-Transport-Layer">The Transport Layer</h2></a>

The Transport Layer, the fourth layer of the OSI model, handles connections, reliability, and data transfer for applications. To see how it works, we can use the `netstat` command:

1. Open the command prompt or terminal on your Ubuntu system.
2. Type the following command and press Enter:

```nohighlight
netstat -a
```

The `netstat` command displays active network connections and their associated transport layer protocols like TCP and UDP. This allows us to observe how the Transport Layer establishes connections, ensures reliability, and handles data transfer. Here's some example output:

```nohighlight
Active Connections

Proto   Local Address     Foreign Address     State
TCP     0.0.0.0:80        0.0.0.0:0           LISTENING
TCP     192.168.0.10:45678 123.45.67.89:443  ESTABLISHED
UDP     0.0.0.0:53        0.0.0.0:0
```

Using this sample output, we can explore the Transport Layer's functionality in a very direct way:

- Establishing connections: The output shows TCP connections in "LISTENING" and "ESTABLISHED" states. When an application listens on a specific port, like TCP port 80, it waits for incoming connection requests. "LISTENING" means it's ready to accept connections, and "ESTABLISHED" indicates an active connection between local and foreign addresses.

- Maintaining reliability: TCP ensures accurate data delivery without loss. It uses acknowledgement, re-transmission, and flow control to achieve this, guaranteeing successful transmission and reception.

- Handling data transfer: The output includes both TCP and UDP. TCP offers reliable and ordered data transfer, while UDP provides faster but less reliable communication. The Transport Layer segments data, adds protocol-specific headers, and ensures proper delivery to the receiving application.

By using the `netstat` command, we can observe active connections and their transport layer protocols. This helps us understand how the Transport Layer establishes connections, maintains reliability, and handles data transfer between applications.

<a href="#heading--The-Session-Layer"><h2 id="heading--The-Session-Layer">The Session Layer</h2></a>

The Session Layer, the fifth layer of the OSI model, handles the setup, maintenance, and termination of sessions between network applications. It allows for coordinated data exchange between devices or processes. To see how it works, we can use the `telnet` command to create a session between your device and the remote server. We can use that session to demonstrate how the Session Layer manages session establishment, maintenance, and termination.

Here's what to do:

1. Open a command prompt or terminal on your system.
2. Use the `netstat -an` command to display active network connections for any IP address containing “129.129”:

```nohighlight
netstat -an | grep “129.129”
```

3. Type the following command to initiate a Telnet session with the IP address of the “freechess.org” remote server:

```nohighlight
telnet freechess.org
```
   
4. The Session Layer establishes a synchronised session between a Telnet client and “freechess.org”, managing the channel.

5. Don’t interact with the remote server through the Telnet client, so that it will time out in just a minute or two.

6. While the Telnet session is ongoing, use the `netstat -an` command in another command prompt or terminal to display active network connections:
  
```nohighlight
netstat -an | grep “129.129”
```

7. Observe any changes in the network connections, specifically looking for the established Telnet session to the “freechess.org” IP address and port.

8. Wait for the telnet session to time out.  When it does, use that `netstat -an` command again:

```nohighlight
netstat -an | grep “129.129”
```

8. Observe that the Telnet session connection to freechess.org is no longer present in the output.

By using the `telnet` command and monitoring network connections with the `netstat -an` command, we can establish, observe, and terminate a Telnet session, providing a practical demonstration of the functionality of the Session Layer. 

<a href="#heading--The-Presentation-Layer"><h2 id="heading--The-Presentation-Layer">The Presentation Layer</h2></a>

The Presentation Layer, the sixth layer of the OSI model, manages the formatting, encryption, compression, and translation of data to facilitate the exchange of multimedia files and ensure compatibility between different systems.  We’ll demonstrate this by proxy, using translation tools to approximate what goes on at this layer:

1. Assume you have a scenario where a user wants to share a multimedia presentation file (e.g., a LibreOffice Impress presentation) with another user over a network.

2. The user initiates the file transfer process by selecting the multimedia presentation file on their local system.  You might want to put together a simple LibreOffice presentation file with a couple of random slides.  Call it “presentation.odp”.

3. The Presentation Layer first formats the file in a standardised way, ensuring that it can be understood on the receiving end. This formatting can be demonstrated using a command-line tool like "hexdump" to view the hexadecimal representation of the file:

```nohighlight
hexdump -C presentation.odp
```

Your sample output might look something like this:

```nohighlight
00000000  50 4b 03 04 14 00 00 08  00 00 c1 82 cf 56 33 26  |PK...........V3&|
00000010  ac a8 2f 00 00 00 2f 00  00 00 08 00 00 00 6d 69  |../.../.......mi|
00000020  6d 65 74 79 70 65 61 70  70 6c 69 63 61 74 69 6f  |metypeapplicatio|
00000030  6e 2f 76 6e 64 2e 6f 61  73 69 73 2e 6f 70 65 6e  |n/vnd.oasis.open|
00000040  64 6f 63 75 6d 65 6e 74  2e 70 72 65 73 65 6e 74  |document.present|
00000050  61 74 69 6f 6e 50 4b 03  04 14 00 00 08 00 00 c1  |ationPK.........|
00000060  82 cf 56 00 00 00 00 00  00 00 00 00 00 00 00 18  |..V.............|
00000070  00 00 00 43 6f 6e 66 69  67 75 72 61 74 69 6f 6e  |...Configuration|
00000080  73 32 2f 6d 65 6e 75 62  61 72 2f 50 4b 03 04 14  |s2/menubar/PK...|
00000090  00 00 08 00 00 c1 82 cf  56 00 00 00 00 00 00 00  |........V.......|
000000a0  00 00 00 00 00 18 00 00  00 43 6f 6e 66 69 67 75  |.........Configu|
000000b0  72 61 74 69 6f 6e 73 32  2f 74 6f 6f 6c 62 61 72  |rations2/toolbar|
000000c0  2f 50 4b 03 04 14 00 00  08 00 00 c1 82 cf 56 00  |/PK...........V.|
000000d0  00 00 00 00 00 00 00 00  00 00 00 1a 00 00 00 43  |...............C|
000000e0  6f 6e 66 69 67 75 72 61  74 69 6f 6e 73 32 2f 73  |onfigurations2/s|
000000f0  74 61 74 75 73 62 61 72  2f 50 4b 03 04 14 00 00  |tatusbar/PK.....|
00000100  08 00 00 c1 82 cf 56 00  00 00 00 00 00 00 00 00  |......V.........|
00000110  00 00 00 18 00 00 00 43  6f 6e 66 69 67 75 72 61  |.......Configura|
00000120  74 69 6f 6e 73 32 2f 66  6c 6f 61 74 65 72 2f 50  |tions2/floater/P|
00000130  4b 03 04 14 00 00 08 00  00 c1 82 cf 56 00 00 00  |K...........V...|
00000140  00 00 00 00 00 00 00 00  00 1a 00 00 00 43 6f 6e  |.............Con|
00000150  66 69 67 75 72 61 74 69  6f 6e 73 32 2f 70 6f 70  |figurations2/pop|
00000160  75 70 6d 65 6e 75 2f 50  4b 03 04 14 00 00 08 00  |upmenu/PK.......|
```

4. The Presentation Layer then applies any necessary data compression techniques to reduce the file's size, optimising network transmission and storage. This can be demonstrated using a tool like `gzip`:

```nohighlight
gzip presentation.odp
```

5. After this operation, the file’s hex dump looks different:

```nohighlight
$ hexdump -C presentation.odp.gz | less
00000000  1f 8b 08 08 aa 3a 8b 64  00 03 70 72 65 73 65 6e  |.....:.d..presen|
00000010  74 61 74 69 6f 6e 2e 6f  64 70 00 cd fd 05 54 1d  |tation.odp....T.|
00000020  c1 b6 2e 8c 2e 5c 83 13  dc 82 bb 04 0d ee c1 17  |.....\..........|
00000030  1e dc dd dd 61 e1 ee ee  4e 70 82 bb 05 08 ee ee  |....a...Np......|
00000040  c1 dd dd ff 64 ef 7b ce  4e f6 3d e7 fc f7 be 31  |....d.{.N.=....1|
00000050  de 78 6f 65 74 7f d5 c5  9c b3 e6 ac ae fe aa 3b  |.xoet..........;|
00000060  a3 ba 27 50 0a 02 12 03  00 80 05 00 ba fd c6 55  |..'P...........U|
00000070  3e 52 94 17 33 02 00 80  df db af 2a 80 95 99 95  |>R..3......*....|
00000080  91 a3 9b ad 91 9e ad ad  a5 99 81 9e a3 99 8d 35  |...............5|
00000090  a3 b3 b5 21 83 8d 9e 83  99 03 83 8d ad 91 b5 a1  |...!............|
000000a0  8d 81 93 95 91 b5 23 83  ad bd 91 c3 2f fc 87 0c  |......#...../...|
000000b0  f0 2f a3 80 3f 7e d8 bf  36 61 1b 6b 63 33 13 27  |./..?~..6a.kc3.'|
000000c0  fb 7f 88 3a b0 30 fe 52  77 d2 d7 b3 67 fc bf d3  |...:.0.Rw...g...|
000000d0  72 b4 b1 b1 fc 9f b5 70  ff 0b 2d 87 5f 0e 3a 39  |r......p..-._.:9|
000000e0  fc df b7 66 6c 69 a3 e7  68 f4 7f db 9a ad 8d ad  |...fli..h.......|
000000f0  93 ed ef f0 fe 07 3d fc  ff 4a cf de c6 e4 57 77  |......=..J....Ww|
00000100  fe bf f8 f9 5f b5 f8 bb  57 6c f5 ac 8d 2c ff 07  |...._...Wl...,..|
00000110  3d a2 ff 42 cf cc 4a cf  c4 c8 81 51 c8 cc d1 4a  |=..B..J....Q...J|
00000120  cf d6 e1 ff d2 5d 3d 03  03 23 4b a3 5f 87 36 ff  |.....]=..#K._.6.|
00000130  e1 2e 2c 2c ec ff a6 89  f0 6b 33 b0 b1 76 fc 3d  |..,,.....k3..v.=|
00000140  58 5c ad 2c 77 34 96 ed  33 d8 b1 3b ce 14 99 0c  |X\.,w4..3..;....|
00000150  97 ca 6a e8 be 59 78 34  36 7c b4 62 69 37 cd 94  |..j..Yx46|.bi7..|
00000160  2e 72 e6 3e 29 7c 0f 59  26 42 2c 86 e6 b1 af bc  |.r.>)|.Y&B,.....|
:
```

6. If encryption is desired for secure transmission, the Presentation Layer can encrypt the file to protect its contents from unauthorised access. You can use a tool like `openssl` to demonstrate encryption:

```nohighlight
openssl enc -aes-256-cbc -salt \
 -in presentation.odp.gz \
 -out presentation.odp.gz.crypt
```

7. Another hex dump will show yet more changes to the file:

```nohighlight
$ hexdump -C presentation.odp.gz.crypt | less
00000000  53 61 6c 74 65 64 5f 5f  77 5a ef 37 94 ea bb 5b  |Salted__wZ.7...[|
00000010  2f c8 4a 4d 30 a9 2a ec  3d 55 4d dd dd b0 7c a2  |/.JM0.*.=UM...|.|
00000020  d5 92 fa 92 85 ce 86 c7  b3 fb ef 42 42 37 5e 91  |...........BB7^.|
00000030  f3 08 81 0e a2 22 dc 74  a6 c0 1d d8 7a 97 0d a1  |.....".t....z...|
00000040  5b 87 ac 89 3f 50 02 31  8f 35 8f 63 7c e5 6d 2d  |[...?P.1.5.c|.m-|
00000050  72 76 1a a5 fc 61 1f cc  5d 47 da af 68 97 07 7b  |rv...a..]G..h..{|
00000060  5e 75 3c e0 9c 1c 04 1b  23 a3 10 9c ea 38 92 69  |^u<.....#....8.i|
00000070  e2 84 6c 3f 0a 91 83 f1  1b 3e 3a 96 54 e3 af bd  |..l?.....>:.T...|
00000080  14 b8 16 c9 67 21 ec a0  85 21 33 ca ce 8b b5 09  |....g!...!3.....|
00000090  6f 08 42 21 58 aa 65 46  ec 31 8d a4 62 ca 1f ac  |o.B!X.eF.1..b...|
000000a0  04 9b b5 5a dc c5 ae 88  95 6f 13 ab b1 90 fa f2  |...Z.....o......|
000000b0  50 50 63 22 86 e2 5a 4e  37 fe 92 a6 65 88 7a 5f  |PPc"..ZN7...e.z_|
000000c0  42 89 b2 b3 65 26 0f 53  57 ed d4 97 50 ab df 7b  |B...e&.SW...P..{|
000000d0  48 1e f6 84 c4 f3 c5 34  3b fb e4 91 e3 31 6c be  |H......4;....1l.|
000000e0  11 43 9a 64 68 13 c6 3a  34 9d 58 64 10 b8 b5 01  |.C.dh..:4.Xd....|
000000f0  69 8d 64 ef b9 e6 35 09  7e 86 d8 08 cf 07 b9 fd  |i.d...5.~.......|
00000100  8b 6b 59 2e ba df 2a 50  34 1f 72 5f bc 19 d7 2d  |.kY...*P4.r_...-|
00000110  67 4a dc 3f ab 29 9a db  7c 6d a9 c9 04 42 ab 72  |gJ.?.)..|m...B.r|
00000120  af 27 de 57 8a 73 f2 75  8d 33 15 4f 6f b5 76 91  |.'.W.s.u.3.Oo.v.|
00000130  52 25 52 76 81 58 9e 1f  ef 66 0e a5 d2 34 69 01  |R%Rv.X...f...4i.|
00000140  59 5c ea 55 1c 38 2b ef  1f 6a 9a 14 9c e1 11 72  |Y\.U.8+..j.....r|
00000150  c2 1b 49 59 ff 1c d3 45  46 69 7c 5d a7 fd 29 d2  |..IY...EFi|]..).|
00000160  30 d5 c9 64 cf 0c 14 17  13 0f 1c d0 23 2b e6 67  |0..d........#+.g|
:
```

8. Once the file is formatted, compressed, and optionally encrypted, it is ready for transmission over the network. This can be achieved using various network protocols or file transfer utilities, such as "scp" (Secure Copy) or "rsync":

```nohighlight
scp <file> <username>@<remote_server>:<destination_path>
```

9. At the receiving end, the Presentation Layer of the recipient's system receives the transmitted file. The Presentation Layer then performs the reverse processes to the received file.  First, it decrypts the file:

```nohighlight
openssl enc -aes-256-cbc -d \
-in presentation.odp.gz.crypt \
-out presentation.odp.gz
```

10. Next, it decompresses the data to restore it to its original size and format; for this proxy example, try using `gunzip` to decompress the file:

```nohighlight
gunzip presentation.odp.gz
```

11. Finally, the Presentation Layer presents the multimedia presentation file to the receiving user in a compatible format that can be displayed by the appropriate application or software. You can open the file using the appropriate software, such as LibreOffice:
   
```nohighlight
libreoffice --impress presentation.odp
```

In this example, our faux (proxied) Presentation Layer performs various tasks such as data formatting, compression, encryption, and decryption to ensure the seamless exchange of the multimedia presentation file between users over the network. The provided CLI commands demonstrate each step of the process, albeit by analogy, allowing you to observe the kind of transformations done by the Presentation Layer.

The Presentation Layer's functionalities extend beyond this example, encompassing other tasks such as character encoding conversions, graphic image compression, and handling different data representations between systems. It plays a vital role in enabling interoperability and ensuring that data is properly understood and utilised by different applications and devices within a network.

<a href="#heading--Wrap-up"><h2 id="heading--Wrap-up">Wrap-up</h2></a>

Here, you got a rough feel for how the various OSI layers manipulate and transfer data, from your application at the Presentation Layer, all the way down to the Physical Layer, and then back to Presentation for display on the other end.  The actual process is more complex and invokes a lot of standards -- which is why it works so reliably.  In the next tutorial, we'll explore these layers in more depth. 

And, as promised, here's a concise picture of what we just covered:

![image|690x469](upload://AflI1wcMYwng8ByjV2is5kagVFT.png)
