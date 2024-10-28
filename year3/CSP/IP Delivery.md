IP software defines unique packet formats called IP datagrams. Can carry 1-64000 bytes (+ header) and has essential routing info to guide packets from source to destination

The destination IP address in each datagram in each datagram helps make routing decisions, relying on routing tables to hold paths and next-hop info for various network addresses

Routing tables need initialization at boot and update when network topology changes to maintain accurate path finding
	Routing tables show network numbers, connections, router paths

Physical network layers do not recognize IP datagram formats directly. The datagram is encapsulated within a hardware frame for each network segment
	For each segment of the network path, IP datagrams are placed in the data field of the specific hardware frame of the network(Ethernet, WIFI etc.)
	The datagram travels across the network segments while encapsulated within frames, being re or de encapsulated at each router / intermediary device

Frame header sizes depend on underlying network tech(Ethernet, Token Ring, etc.)

Layered CSP approach analysis: ensures data sent by a client app is managed layer-by-layer until it reaches the server. Each layer handles a specific task

Fragmentation: Large packets need to meet payload limits of lower-layer protocols. This happens in the network layer, meaning data can traverse segments with varying max transmission unit (MTU) sizes

At the final destination (like a server), encapsulated data is stripped layer by layer as it travels back up through the layers, letting the end host process the original client data

Encapsulation impacts performance and compatibility in CSP. Certain networks may have things like variable latency and require adjustments like more buffering or fragmentation
	This affects data delivery time, with efficient route computation and dynamic routing ensuring min delays in path optimization



