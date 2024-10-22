Data is constantly moving in and out of computers, either being stored in memory for quick access or written to disk for long term retrieval

Storage Types:
- Single Disk Drive
- Logical Volume: Multiple disks concatenated to act as one, without [[RAID]] or #Striping 
- Storage Array: Disk groups offering things like RAID for redundancy and performance improvement
- SCSI: Protocol for attaching storage to a computer

Network Storage Types:
- Network Attached Storage (NAS):
	- Accessible by multiple machines which use file sharing protocols for comms
	- Appears as a single node on the network with a file-based interface
	- Built for easy network file sharing
- Internet SCSI:
	- Encapsulates SCSI commands onto TCP/IP packets for transfer over a network
	- Common in networked environments where SCSI block storage is needed over a standard IP network
- Storage Area Network (SAN):
	- A dedicated high-speed network providing access to consolidated block-level access
	- Fibre channel for communication

Direct Attached Storage:
- DAS Basics:
	- Traditional storage model where disks are directly attached to a computer 
	- Pros: Simple, lower-cost option for small setups
	- Cons: Storage is tied to a specific machine, making it difficult to scale and lacks the flexibility of network storage
- External Storage Compatibility
	- RAID controller manages multiple disks
	- Host Bus Adapter: Transfers the data between computer and storage system, without handling RAID calcs

NAS vs SAN:
- NAS:
	- Lower cost 
	- Easier deployment, typically using file sharing
- SAN:
	- Higher performance, especially for DB apps and large file transfers
	- Supports more processors and devices attached to the same storage pool
	- Spans across multiple sites, improving disaster recovery
	- Fewer devices are needed, and storage can be pooled and managed from a single point
	- LAN-free backups, allowing for data to be written from disk to tape without server overhead
	- .
	- SAN allows longer distances between processors and storage
	- Offloads I/O traffic from LAN to a dedicated network
	- Real time data sharing

Summary:
- DAS is limited in scalability and flexibility but is cost effective for small operations. 
- NAS improves on sharing but has high overhead from file-based comms
- SAN: Better but more expensive