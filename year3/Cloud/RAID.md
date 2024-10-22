RAID is used to enhance the performance and reliability of disk storage by combining many physical disk drives into one logical unit

The failure time in physical disks is measured in Mean Time Between Failures. RAID improves on these individual disks by offering data protection, increased performance, or both

Software RAID is implemented using host-based software. However, using host CPU cycles for RAID calcs affect sys performance

Hardware RAID uses a specialised hardware controller, providing better performance than software RAID

RAID techniques:
- #Striping: data is split into chunks and written across multiple disks at the same time, improving performance. This offers no redundancy
- Mirroring: Data is duplicated across two or more disks, providing redundancy. If one fails, the data can still be retained and retrieved 
- Parity: Storing an additional piece of data that helps rebuild data in the case of a disk failure. Calculated using XORs 

RAID 0: Striped array with no redundancy. Performance is improved by distributing data across may disks but offers no data protection

RAID 1: Mirroring is seen, but every disk has an identical copy, which means a doubled cost. 2 read write

RAID 1+0 = RAID 10: 0 + 1. Ideal for apps with high random rw ops.

RAID 3: Byte level striping and a dedicated parity disk. Fault tolerance comes in, but bottle neck chance during write operations. Good for large, sequential rw ops, like data backups and multimedia streaming

RAID 4: Similar to 3, but uses block size, rather than byte. This allows for size adjustment based on needs

RAID 5: Block with distributed parity. Good performance and removes bottleneck issue. Common in DBs and file servers. four I/O calcs per second


RAID 6: Improves with dual distributed parity, allowing the array to tolerate the failure of 2 disks. Takes longer at write time due to parity calc, however. six I/O calcs per second. Good for apps with lower write intensities, like email servers or DB entry systems

Hot spares are unused disks in the array that can take over in the event of disk failure, ensuring minimal downtime