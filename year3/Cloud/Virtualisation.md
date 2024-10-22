Virtualisation is the separation of resources  and services from physical hardware, allowing multiple virtual systems to run on one physical machine

A buffer stores incoming data and then passes it to the receiver according to the speed it can process it

Caching is high speed storage on a separate disk. Commonly holds frequently used data. Cache sits before RAM. Stores copies of the data


VMs:
- Software which emulates a computer system
- Has its own vCPU, vRAM, and vNIK

Virtualisation types:
- desktop: flexible, improved security, and simplified data management
- Server virtualisation: one physical hosts many virtual
- Server Virtualisation

Hypervisors:
- AKA VMM: Virtual Machine Monitor 
- software layer that allows multiple OSs to run on a single physical machine by creating VMs
- Bare metal:
	- Runs on the host machine's hardware
	- Most efficient and used often in data centres and enterprise environments 
	- Preferred for high performance, security, and stability because it directly interacts with hardware
- Hosted:
	- Runs on top of a host OS, providing virtualization services like memory management and device support
	- Used commonly for testing, dev, or desktop virtualization. Easier to set up but slightly less efficient thanks to an extra layer of OS
- Hypervisors allocate resources as needed
- Ensure VMs are separated and isolated, addressing concerns for security and OSs running without conflict
- Hardware is abstracted, allowing for VMs to share resources
- Management of VMs
