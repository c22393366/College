Load Balancing:
- Distributes incoming network or app traffic across multiple servers. Keeps from a single server being overloaded. 
- Web roles are stateless, meaning any client requests can be handled by any role instance
- Status-check happens every 15 seconds to determine if an instance is available to take on traffic or if it needs to be taken out of the rotation
- Fault tolerance is increased as responsibility is spread 

Elasticity:
- Defined as the system's ability to automatically adjust resources to match workload changes
	- Automated as apposed to manual intervention required in scalability
- Vertical Scaling: Changes the power of individual instances like through adding more CPU or memory. Can be disruptive, however, and is not common
- Horizontal Scaling: Changing the number of instances. Non-disruptive, based on demand

