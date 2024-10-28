Apps tend to work in pairs in network programming: a client and a server
	These work on remote hosts and communicate over a network
	The server remains passive, waiting on contact from clients
	The client actively initiates comms

A network serves as a conduit for transferring info between hosts but doesn't understand or generate the data itself

Server Apps:
- Provide specific services and are designed to handle any requests from clients
- Operate on server-class machines: Powerful computers which handle significant data processing and networking tasks
- Servers start upon sys boot on their own and run continuously, waiting for connections from clients
- The management of many clients needs robust hardware and sophisticated OS systems to allocate resources and power and prevent things like deadlock

Client Apps:
- General purpose for running on user devices like PCs
- User-initiated, running for a specific session and running locally
- Actively reach out to servers to request services and can connect to different servers, but only one at a time
- Do not need special hardware or OS

CS Comms:
- Before comms, the server must inform its local protocol software about the types of messages it expects
- Then, it sits and waits for connection requests, registering its identifies with the protocol software
- Once client reaches out with a message, specifying its own identifier and location, the server's protocol software matches to the registered app
- Upon connection establishment, the client and server exchange messages and terminate connection when complete

Client Characteristics:
- Offer computational functionality for user-specific needs
- Run for the duration of a single session
- Are directly invoked by user

Server Characteristics:
- Specialised programs dedicated to a specific device
- Do things like handling file requests, database queries, web pages
- Capable of handling many sessions concurrently

Addressing and Identification in CS Models:
- Unique Identifiers:
	- Each server is given a unique id to distinguish between many servers on the same network or machine
		- This is used to ID the correct service to communicate to
- Server-class machines can host several servers simultaneously, like a web server and file server running concurrently
- OS sys must support multi-tasking and process management 

Challenges:
- Maintaining sessions between client and server, especially when there's long interactions and/or many client requests, which may degrade performance
- Servers must optimally manage resources to handle multiple requests
- Clients must handle network latency and potential connection issues gracefully

