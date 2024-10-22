Visualising Data Centre Phases:
- CDC -> Compute -> Storage -> Network -> Complete

Compute Virtualisation:
- Masking or abstracting the physical computing hardware and allowing multiple OSs to run on one or clustered physical machines
- Enables the creation of many VMs
- The hypervisor sits between the hardware and VMs, allocating standardised hardware resources
- Benefits: Server consolidation, Isolation, Encapsulation, Hardware independence, reduced cost

Resource Pool: The logical abstraction of centrally managed physical resources. Key terms include:
- Reserve: CPU and memory amount saved for VM
- Limit: Max CPU and memory amount that can be taken
- Share: CPU or memory amount VM can have with respect to parents total resources


CPU Resource Optimisation occurs through multicore processing and hyperthreading

Hypervisors manage virtual CPUs and support load balancing

Storage virtualisation abstracts the complexity of physical storage, creating logical volumes from storage pools. This allows for improved utilization, non-disruptive migration, multi-vendor support, and cost efficiency

Network Virtualisation segments physical networks into virtual networks , allowing for better resource sharing, improved security, and simpler management. These virtual networks can connect physical and virtual systems, allowing centralised management and traffic control 

App virtualization means apps can be delivered in isolated environments, avoiding conflicts between different versions and ensuring OS app integrity

Cloud Offering Examples:
- Secured backup
- On demand computing resources 
- Trial platforms / infrastructures
- Access on demand

Benefits:
- Reduced IT cost
- Agility of business
- Flex Scaling
- Available
- Lower energy consumption