Application Layer: 
- contains internet protocols like HTTP, WWW, FTP, E-Mail

Presentation:
- Concerned with syntax and semantics of info being transmitted
- Allows for compatibility between data formats and structures, like data encoding and compression
- Facilitates comms between different systems like big endian ones (Sun Sparcs (Most significant byte is stored first)) and little ones (Windows(opposite of big))

Session Layer:
- Establishes and maintains connections between client and server
- Types:
	- Two way simultaneous comms
	- Two Way Alternate
	- One Way
- Handles things like resync after a crash
- Allows for long-lived sessions in CSP, like video conferencing

Transport Layer:
- Isolates apps from underlying network hardware by breaking down data into manageable chunks
- Uses TCP (Transmission Control Protocol) and UDP(User Datagram Protocol) to give reliable data delivery. 
	- TCP provides reliable, connection-oriented comms with error checking and flow control
	- UDP provides faster, connectionless comms without guarantees of delivery. Good for things like gaming 

Network Layer:
- Focus on the operation of the subnet, managing the routing of data packets
- Routing: Fid best path of packet delivery across various networks
- Addressing

Data Link Layer:
- Transmits data over a single network link
- Makes raw transmissions into frames and ensures frames reach the next network node without error
- Error detection, flow control, access control for shared comms channels 

Physical Layer:
- Transmits raw bits over  a comms channel
- Makes sure electrical signals representing data is correctly transmitted and received

OSI model vs TCP/IP model:
- OSI is theoretical and has 7 layers
- TCP/IP is based on real protocols and has layers:
	- App (merge of App, pres, session)
	- Transport (TCP, UDP)
	- Internet (Similar to Network)
	- Network Access Layer (Comparable to Data Link and Physical Layers)
- Differences:
	- TCP/IP is more flexible in adapting to real-world networking
	- OSI was developed before the protocols, but TCP/IP did the opposite

Layered Approached Benefits: simplifies dev by allowing software to focus on a specific layer's function, promoting modularity and separation of concerns 

Encapsulation: data is packaged layer by layer, adding headers at each layer to provide needed control. 
	E.g. HTTP data in the app layer is encapsulated with a TCP header at the transport layer, followed by an IP header at the network layer

Use-Case example: A web browser communicates with a web server using HTTP. This request from the browser us passed through the transport layer using TCP, routed through the internet layer, and is finally transmitted over a physical medium through data link and physical layers
