Snapshots capture the current state of the VM, including the disk, memory, and processor state at a point in time
	This allows for rollback to a specific state

Types:
- Production Checkpoints: create data consistent snapshots but don't bother with the running state. Used when system consistency is needed
	- Example: VSS or FSF
- Standard: The entire state

Storage of Snapshots:
- Upon take, VM is paused, and new virtual hard disk file is created to store changes. = Differencing Disk. This leads to large amounts of storage being taken up quickly

Formats:
- VHD + VHDX are Microsoft. X has larger disk size support and protection against file corruption
- XML formats go through VMDK and OVF/OVA

Considerations for Snapshots:
- Additional overhead can reduce VM performance
	- Not intended for long term storage or as a backup because of this
- Deletion must be done carefully. Improper differencing disk deletion can lead to data loss