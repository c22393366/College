Traditional horizontal network interaction in not enough for explaining functionalities like protocols needed for data transmission between hosts

Protocol layering is when each layer of a protocol stack offers services to the layer above and below it. This helps with modularity where each layer performs one defined task like
- Binary transmission
- Ensuring reliable transmission of data 

Protocol Entity: Performs a specific task like frame transmission 
Protocol Stack: collection of entities which work together to handle comms tasks between two hosts
Protocol Model: Framework categorizing and explaining layers' roles in the comms process

OSI(Open Systems Interconnection): standardizes comms between systems, allowing for interoperability regardless of who builds them
	7 layers, each abstracting a function
		This minimizes the cross-layer information flow
		Manage data flow, handle errors, handles addressing & more

Layers (Bottom to Top):
- Physical: Transmits raw bits over a comm channel. Addresses voltage levels, frequencies, media types (cables & wires etc)
- Data Link: Transmission of frames across a link, making a raw transmission medium into an error free data channel. Does framing, error control, flow control, handles access to a shared comms channel
- Network Layer: Routes data packets between hosts across complex network infrastructures. Manages subnet ops, creates a global address space, and ensures successful delivery of packets 
- Transport: Ensures reliable process-to-process delivery of data between hosts. Interfaces directly between apps to manage data transmission, multiplex streams, and address issues like latency and data loss

Information moves up and down through the layers in a structured manner. E.g. data from application layer flows down through presentation, session, transport, etc., each adding and interoperating relevant headers.

As data moves through layers, things added to the packets help manage comms at each level

Fragmentation: data sometimes needs to be split across packets to accommodate size restrictions at the lower-layer protocols

Lower layers are typically implemented on intermediary devices like routers. These manage things like routing data or receiving/transmitting frames at network boundaries