Distributed cloud computing:
- multiple systems share processing tasks and resources, enabling scalability and resilience. The precursor to cloud computing.
- Single-Tier: All processes ran on one machine, with user access via terminals. Single point of control and failure. Example: Mainframe
- Two-Tier: Processing split between clients and servers, wherein servers manage app and data logic. Seen commonly in database systems, where the server is a centralised database server
- Three-Tier: Middle layer introduced in the way of an application server. This handles business logic. The system becomes scalable and modular. In web apps, the browser interacts with the app server which interacts with the database
- N-Tier: 
	- Presentation Layer: User interface
	- Business Logic Layer: App Processing 
	- Data Layer

Distributed System Characteristics 
- Autonomous components, meaning independent functions without centralised control
- Multiple processes run concurrently across multiple machines
- No single point of failure or control

Examples of distributed systems:
- Internet:
	- Heterogeneous network of computers and applications
	- Uses IPS
- Mobile and Ubiquitous Computing: 
	- Cellular networks and wireless systems allow devices to communicate while devices are mobile e.g. smartphones
- Intranets:
	- Private and internal networks in organizations which often interface with public internet via firewalls

Cloud Dev Models:
- Private: Used exclusively by a single organization, managed internally or by a third party
- Public
- Hybrid: Allows for data and applications to be shared between the two types
- Community: Shared among organizations with common concerns

Challenges:
- Security: Third parties hold data
- Vendor Lock-In: Dependency on specific cloud platforms
- Latency

Emerging Trends:
- Serverless Computing: provider focuses on server infrastructure and user focuses on deploying and scaling apps
- Edge Computing: Data is processed closer to where it is generated. This reduces latency and bandwidth use

Requirements:
- Resource Sharing:
	- Allow the share of hardware, software, and data resources
	- Struggle to manage access control and security when many users are accessing shared resources (deadlock)
- Openness:
	- Ability to extend and improve the system over time
	- Interfaces should be well defined and documented, allowing for integration of new components 
- Concurrency:
	- Components of the distributed system can run without conflict
	- Lost updates and non-repeatable reads without proper coordination, however
- Scalability:
	- The ability of the distributed system to handle increased loads and improve performance via the addition of faster workloads and resources
- Fault Tolerance:
	- Escape a single point of failure and keep system operational even when some components fail
- Transparency:
	- The System should present itself as a single, unified entity to devs and users
	- Types:
		- Access: Local and remote resources are accessed using the same type of operations
		- Location: Resources can be accessed without knowledge of their specific location
		- Migration: Components can be relocated without affecting users
		- Replication: Component replicas remain synced
		- Concurrency: Users are unaware of concurrent operations happening elsewhere
		- Scalability: Scaling without users noticing differences to app infrastructure
		- Performance: The sys adapts to varying loads
		- Failure: Faults are concealed from the user