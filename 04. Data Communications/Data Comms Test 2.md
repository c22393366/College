#DataComms    

# <mark style="background: #69E772;">18. IP Classful Addressing</mark>


- An <mark style="background: #69E772;">internet</mark> must operate like any other network:
    - It must allow hosts to send and receive data to each other
    - To facilitate this some type of <mark style="background: #69E772;">addressing scheme</mark> is required
    - i.e. all hosts require a <mark style="background: #69E772;">unique</mark> address
    
- So <mark style="background: #69E772;">addressing</mark> is a <mark style="background: #69E772;">critical</mark> component of the <mark style="background: #69E772;">internet abstraction</mark>

- The <mark style="background: #69E772;">Internet Protocol </mark>(<mark style="background: #69E772;">IP</mark>) defines such an addressing scheme

- IP addressing is <mark style="background: #69E772;">independent</mark> of the underlying physical addressing scheme

<mark style="background: #69E772;">A multi-node internet:</mark>
    
- ![](https://i.imgur.com/xv2h2N6.png)
    
### <mark style="background: #69E772;">IP Address Hierarchy:</mark>

- Each host/router <mark style="background: #69E772;">interface</mark> is assigned a <mark style="background: #69E772;">unique</mark> 32-bit <mark style="background: #69E772;">IP address</mark>

- This address is used in packets that are sent across an interne

- Each IP address consists of two parts: a <mark style="background: #69E772;">prefix</mark> and a <mark style="background: #69E772;">suffix</mark>

- Each physical network is assigned a <mark style="background: #69E772;">unique network number</mark> which forms the <mark style="background: #69E772;">network prefix</mark> part of a host’s IP address.

- It uniquely identifies the physical network to which the host is attached

- The <mark style="background: #69E772;">host suffix</mark> uniquely identifies the host on that network.

- <mark style="background: #69E772;">Network numbers/prefixes</mark> are assigned <mark style="background: #69E772;">globally</mark>, <mark style="background: #69E772;">host</mark> suffixes are assigned <mark style="background: #69E772;">locally</mark>


### <mark style="background: #69E772;">Dotted Decimal Notation:</mark>

- Representing IP addresses in 32-bit binary form is only suitable for computers.

- A human-friendly version of IP addresses is known as <mark style="background: #69E772;">dotted-decimal notation</mark>.

- Here each <mark style="background: #69E772;">octet</mark> of the IP address is represented as a decimal value separated by a dot ‘.’
	- Examples include: 129.52.6.0, 128.10.2.3 and 128.128.255.0
	- Each decimal value represents 8-bits,
	- Consequently, the range of decimal numbers extends from 0 - 255
	
    
### <mark style="background: #69E772;">IP Address Hierarchy:</mark>

- The IP addressing scheme must accommodate large <mark style="background: #69E772;">and</mark> small internets:
- This was originally achieved using classful <mark style="background: #69E772;">IP addressing</mark>
- Classful Addressing was the first attempt to organise the IP address space
    
### <mark style="background: #69E772;">Original Classful IP addressing:</mark>
    
- Here the IP address space was divided into <mark style="background: #69E772;">five</mark> classes:
- Each class had different size <mark style="background: #69E772;">prefix</mark> and <mark style="background: #69E772;">suffix</mark> portions to accommodate large and small networks.
- The first four bits identify the <mark style="background: #69E772;">class</mark> to which the address belongs (see next slide).
- <mark style="background: #69E772;">Classes A, B and C</mark> are known as the <mark style="background: #69E772;">primary classes</mark> because they are used for <mark style="background: #69E772;">host addressing</mark>.
- Class D addresses are used for <mark style="background: #69E772;">multicasting</mark>
- Class E was reserved for future use
    
### <mark style="background: #69E772;">Classful IP Addressing Scheme:</mark>
    
- ![](https://i.imgur.com/NUXm2Q0.png)

- Note the different sizes of the <mark style="background: #69E772;">prefix</mark> and <mark style="background: #69E772;">suffix</mark> portions for each class:
- For Class A addresses the first octet is the <mark style="background: #69E772;">network prefix</mark> and the last three octets are the <mark style="background: #69E772;">host suffix</mark>.
- Notice also the split between <mark style="background: #69E772;">network prefix</mark> and <mark style="background: #69E772;">host suffix</mark> for Classes B and C
- ![](https://i.imgur.com/kOf7yq7.png)
    
### <mark style="background: #69E772;">Routing of IP Packets:</mark>

- Q: Why is the separation of prefix and suffix important?

- A: Routers are responsible for directing datagrams/packets onto their final destination.
	- This is called <mark style="background: #69E772;">routing</mark>.
	- The router needs to look at the address to make a decision about where to route a packet.
	- This is similar to the Post Office delivering letters
    
<mark style="background: #69E772;">Routing of "Letters":</mark>

- Letters are routed through <mark style="background: #69E772;">National</mark> and <mark style="background: #69E772;">Local</mark> sorting offices.
- National Sorting Offices tend to be far away from the destination.
- They only need to examine the County/Town to route the letter towards a sorting office closest to the destination
- The Local Sorting Office closest to the destination examines the Street Name and House Number to make the final delivery.
- This Post Office analogy is similar to the way Routers route incoming IP packets.

<mark style="background: #69E772;">Back to routing of "Packets":</mark>

- Routers far away from the Destination router can be considered <mark style="background: #69E772;">National</mark> Sorting Offices:
- They only need to examine <mark style="background: #69E772;">network prefixes</mark> (similar to <mark style="background: #69E772;">County/Town</mark>) in an attempt to route the packet towards the final destination router.
- The Router closest to the destination station can be considered a <mark style="background: #69E772;">Local Sorting</mark> Office
- They examine the entire destination IP address including the <mark style="background: #69E772;">host suffix</mark>
    
<mark style="background: #69E772;">Routing of IP Packets using Classful Addressing:</mark>
    
- Classful IP addresses are <mark style="background: #69E772;">self-identifying</mark> as the <mark style="background: #69E772;">network prefix</mark> portion of an IP address can be computed from the address itself:
- The first four bits will determine the class and hence the <mark style="background: #69E772;">network prefix</mark>.
- Refer to the next slide to see how the bits relate to the classes.
- This makes it easy for <mark style="background: #69E772;">“far away”</mark> routers to route packets towards the destination router
- Whilst dotted-decimal notation represents IP addressing in a simple form it does hide the first four bits.

- Instead, we humans have to rely on range values to determine the Class of the address:
	- For Class A addresses the first octet is in the range 0-127,
	- For Class B addresses the range is 128-191, and,
	- For Class C addresses the range is 193-223
	
    
### <mark style="background: #69E772;">Classful IP address values:</mark>
	
- ![](https://i.imgur.com/PWxKt7b.png)
    
### <mark style="background: #69E772;">Routing of IP Packets using Classful Addressing</mark>

* Whilst <mark style="background: #69E772;">dotted-decimal notation</mark> represents OP addressing in simple form it does hide the first four bits

* Instead, we humans have to rely on range values to determine the four classes of the address
	* For Class A addresses the <mark style="background: #69E772;">first</mark> octet is in the range 0-127,
	* For Class B addresses the range is 128-191, and,
	* For Class C addresses the range is 193-223.
	
	
<mark style="background: #69E772;">Classful Addressing Example:</mark>
- ![](https://i.imgur.com/s3IBbhw.png)
    
### <mark style="background: #69E772;"> Subnet and Classless IP Addressing:</mark>

* A problem with <mark style="background: #69E772;">Classful addressing</mark> is that it results in an <mark style="background: #69E772;">unequal</mark> division of the <mark style="background: #69E772;">IP address space</mark>.

* As the global Internet has grown, the use of <mark style="background: #69E772;">classful addressing</mark> has become problematic:
	* The IP address space is being exhausted,
	* Many addresses remain unused,
	* Refer to examples in class.
	
* Two new addressing methods are used to overcome this: <mark style="background: #69E772;">subnet addressing</mark> and <mark style="background: #69E772;">classless addressing</mark>
* Here the division between the prefix and suffix portions can occur on any bit boundary: e.g. a 20-bit <mark style="background: #69E772;">network prefix</mark> + 12-bit <mark style="background: #69E772;">host suffix</mark> is possible.
* To facilitate Classless Addressing, an additional piece of information is defined with each address block: Known as an <mark style="background: #69E772;">address mask</mark> or <mark style="background: #69E772;">subnet mask</mark>.

* <mark style="background: #69E772;">Masks</mark> are 32-bit values that facilitate the extraction of the <mark style="background: #69E772;">network prefix</mark> from any given IP address:
	* They are comprised of a contiguous sequence (unbroken sequence) of 1 bits followed by a contiguous sequence of 0 bits.
	* They can be represented in dotted-decimal notation just like IP addresses.
	
	
<mark style="background: #69E772;">Example Classless IP Addressing Allocation:</mark>
* ![](https://i.imgur.com/7rm5oyG.png)
* ![](https://i.imgur.com/AO2A5Ub.png)

* Note the <mark style="background: #69E772;">address mask</mark> or <mark style="background: #69E772;">subnet mask</mark> for the 192.4.10.0/24 network.

* The <mark style="background: #69E772;">/XX </mark>(‘slash’ XX) is another way to represent masks:

* <mark style="background: #69E772;">/24</mark> means that the mask is comprised of 24 ONE bits followed by 8 (32-24) ZERO bits:

* This notation is known as <mark style="background: #69E772;">Classless Inter-Domain Routing (CIDR)</mark>: 
	* It is a human-friendly way of representing <mark style="background: #69E772;">address masks</mark>
	* In <mark style="background: #69E772;">dotted-decimal notation</mark>, this mask can be represented as: <mark style="background: #69E772;">255.255.255.0</mark>
	* The first three octets are all ONEs, the last octet is all ZEROs.
	

### <mark style="background: #69E772;">Using Address Masks to route packets:</mark>

* Following on from the previous discussion on routing.
* Recall that for any given destination IP address, the router must determine the <mark style="background: #69E772;">network prefix</mark> portion:
* The router uses the <mark style="background: #69E772;">network prefix</mark> to query its <mark style="background: #69E772;">routing table</mark>.
* With Classless addressing, routers use the <mark style="background: #69E772;">Mask</mark> (aka: <mark style="background: #69E772;">network masks</mark>, <mark style="background: #69E772;">subnet masks</mark>) to extract the <mark style="background: #69E772;">network prefix</mark> portion from a destination IP address:
* Recall that with <mark style="background: #69E772;">classful address</mark>, the router simply examined the first four bits of the address to determine the class.
* For an incoming packet with a destination IP address, D, the router tests the following condition: <mark style="background: #69E772;">A = = (D&&M)</mark>

* <mark style="background: #69E772;">Where:</mark>
	* <mark style="background: #69E772;">A</mark> is the IP address (network number) of networks that the router knows about,
	* <mark style="background: #69E772;">M</mark> is the mask associated with the network, and,
	* <mark style="background: #69E772;">D</mark> represents a destination IP address that the router needs to make a routing decision.
	
	
### <mark style="background: #69E772;">Address Masks:</mark>

* For example, consider the following:
	* A = 11000000 00000100 00001010 00000000
	* D = 11000000 00000100 00001010 00000011
	* M = 11111111 11111111 11111111 00000000
	
* The mask, <mark style="background: #69E772;">M</mark>, is ‘applied’ to the Destination IP address <mark style="background: #69E772;">D</mark> i.e. D && M

* The <mark style="background: #69E772;">AND</mark> operation effectively zeros out the last eight bits of <mark style="background: #69E772;">D</mark>.

* The result is then compared to the <mark style="background: #69E772;">A</mark> address.

* If they match, then the Destination IP address, <mark style="background: #69E772;">D</mark> is said to <mark style="background: #69E772;">belong</mark> to the network, <mark style="background: #69E772;">A</mark>:

* The packet containing the Destination IP address, D, is then <mark style="background: #69E772;">routed</mark> towards network <mark style="background: #69E772;">A</mark>,

* The packet is routed to the address indicated by the <mark style="background: #69E772;">Next Hop</mark> field in the routing table (refer to next slide).

* Otherwise, the <mark style="background: #69E772;">next</mark> entry in the routing table will be tried using the above approach.

<mark style="background: #69E772;">Example IP Routing Table using Classless Addressing:</mark>
-  ![](https://i.imgur.com/g3UUoty.png)

### <mark style="background: #69E772;">Classless Addressing and the IP Address Space:</mark>

* <mark style="background: #69E772;">Classless addressing</mark> makes more efficient use of the IP address space.
* Consider an example of a single <mark style="background: #69E772;">class B prefix</mark> (16-bit prefix): 128.211.0.0
* With <mark style="background: #69E772;">classful</mark> addressing this Class B prefix can only be used to identify a <mark style="background: #69E772;">single</mark> network with approx. 65K host addresses.

* With <mark style="background: #69E772;">classless addressing</mark>, this Class B prefix can be considered as having a 16-bit mask:
	* In dotted-decimal notation: 255.255.0.0
	* In CIDR notation: /16
	
* Using <mark style="background: #69E772;">classless addressing</mark>, there are multiple approaches to dividing this large address block into smaller blocks.
	
### <mark style="background: #69E772;">Classless Addressing VS. IP Address Space:</mark>
	
* Larger value address masks (e.g. /17, /18, /19 etc.) can be used to partition the Class B address block into smaller address blocks (known as <mark style="background: #69E772;">subnets</mark>)

* For example, two customers could be allocated subnet address blocks with /28 masks (/28 > /16): 128.211.0.16/28 and, 128.211.0.32/28

* Although both subnets have the same mask size (28 bits), the network prefixes differ and are <mark style="background: #69E772;">unique</mark>.

* In addition, most of the original /16 address space is still available for allocation to other customers.

### <mark style="background: #69E772;">Basic Subnetting:</mark>

* Subnetting allows for the creation of <mark style="background: #69E772;">multiple</mark> logical networks from a single address block.
	* Subnets are created by taking one, or more, of the <mark style="background: #69E772;">host</mark> bits from the original address block and using them as <mark style="background: #69E772;">network</mark> bits in the smaller subnet blocks:
	* This is achieved by increasing the mask of the original large address block. For example, from <mark style="background: #69E772;">/16 </mark> to <mark style="background: #69E772;">/20</mark>
	* The more <mark style="background: #69E772;">host bits</mark> from the original large address block that are used, the more subnets can be defined.
	
* For each additional host bit <mark style="background: #69E772;">taken</mark>, the number of subnetworks available is doubled:
	* For example, with <mark style="background: #69E772;">one</mark> host bit taken, two subnets can be defined. With two host bits taken, four subnets are created etc.
	* However, with each host bit taken, fewer host addresses are available for each of the subnets.
	
* For example, if <mark style="background: #69E772;">n-bits</mark> are taken from the original host portion:
	* The number of <mark style="background: #69E772;">subnets</mark> created is: <mark style="background: #69E772;">2^n</mark>
	* The total number of addresses per subnet is <mark style="background: #69E772;">2^m</mark> (<mark style="background: #69E772;">m</mark> = the number of host bits remaining)
	* The number of <mark style="background: #69E772;">usable</mark> host addresses: <mark style="background: #69E772;">2^m – 2</mark>;
	* The first address in the block is used to identify the <mark style="background: #69E772;">network</mark>, The last address in the block is the <mark style="background: #69E772;">Broadcast Address</mark>
	
<mark style="background: #69E772;">Basic Subnetting Example:</mark>
* Given address block:192.168.1.0/24, divide this network into 2 subnets:

* Looking at the original address block:
	* /24 means 8 hosts bits i.e. 28 = 256, Addresses
	* Of these 256 addresses, 254 are usable for host addresses
	* i.e. 28 – 2 = 254.
	
* ![](https://i.imgur.com/3J7t4xN.png)
	
### <mark style="background: #69E772;">Basic Subnetting:</mark>

* To divide this network into 2 subnets, <mark style="background: #69E772;">one</mark> bit is taken from the original host portion:
* This extends the original mask (255.255.255.0) by one bit as follows:
* 11111111.1111111.1111111.10000000
* In dotted-decimal notation (DDN): <mark style="background: #69E772;">255.255.255.128</mark>
* In CIDR notation: <mark style="background: #69E772;">/25</mark>
* Note: <mark style="background: #69E772;">X</mark> below represents the single host bit taken from the host portion of original address block to be used in the network prefix.
* ![](https://i.imgur.com/NeQhtZA.png)
* ![](https://i.imgur.com/nS5LYQs.png)

* Taking 1 bit from the original host portion creates 2 subnets, each with the same extended subnet mask: <mark style="background: #69E772;">255.255.255.128</mark> or <mark style="background: #69E772;">/25</mark>
* For each new sub-net, there are:<mark style="background: #69E772;"> 7 Host Bits</mark>, i.e. 2^7 = 128 addresses, of which 126 are usable host addresses.

* The single host bit taken from the original host portion gives: <mark style="background: #69E772;">2^1 = 2</mark> Subnets:
	* Leaving <mark style="background: #69E772;">7</mark> bits for the host portion i.e. so <mark style="background: #69E772;">2^7 =128</mark> addresses per subnet,
	* With the network and broadcast addresses removed this leaves <mark style="background: #69E772;">2^7 – 2 = 126 usable host addresses</mark> on each subnet
	* The <mark style="background: #69E772;">Address Table</mark> needs to be completed:
	* The <mark style="background: #69E772;">Magic Number</mark> approach is one way to determine the addresses in each subnet.
	

### <mark style="background: #69E772;">Basic Subnetting Using Magic Numbers (The Magic Number approach):</mark>

* Determine the mask for each new subnet.
* In the above example the mask is determined to be: 255.255.255.128
* Looking from left-to-right along the new mask, seek the last octet that is non-zero <mark style="background: #69E772;">and</mark> less than or equal to 255.
* In this case, the fourth octet matches this criterion.
* Subtract this octet from 256 as follows:
* 256 – 128 = 128 which is <mark style="background: #69E772;">The Magic Number</mark>

* The Magic Number (MN) is used to determine the starting network address for <mark style="background: #69E772;">each</mark> of the Subnets:
	* To determine network address of the <mark style="background: #69E772;">next</mark> subnet, simply add the MN to the previous network address, taking care to add the MN to the octet from which it was derived.
	* In this example, the network address of the <mark style="background: #69E772;">first</mark> subnet is the first address in the original address block: 192.168.1.0
	* As the MN (128) was found in the fourth octet, the MN is added to the fourth octet: 192.168.1.0, to give the network address of the <mark style="background: #69E772;">next</mark> subnet: 192.168.1.128
	
* With the <mark style="background: #69E772;">Magic Number</mark> approach, the Address Table is easy to complete as follows
* ![](https://i.imgur.com/tEN6k1F.png)


<mark style="background: #69E772;">Subnets in Use:</mark>
-  ![](https://i.imgur.com/GTKJ1rW.png)
	
	
### <mark style="background: #69E772;">Basic Subnetting:</mark>
	
* Given an address block of 192.168.1.0 /24, we wish to divide this network into 4 subnets:
	* Determine the power of 2 to provide 4 networks:
	* i.e. <mark style="background: #69E772;">2^? = 4</mark> (Note the number of subnets will be a power of 2)
	* Hence <mark style="background: #69E772;">two</mark> bits are required to be taken from the original host portion.
	* This leaves <mark style="background: #69E772;">6 bits</mark> remaining for host addresses.
	
* Having calculated the number of host bits required for each subnet, the mask can be determined as follows:
* The new Subnet mask is: 11111111.1111111.11111111.11000000
	* In DDN: 255.255.255.192
	* In CIDR notation: /26
	
* Using the <mark style="background: #69E772;">Magic Number</mark> approach to determine the addresses in each subnet.
* With a Mask for each subnet of: 255.255.255.192
* Looking from left-to-right along the new mask, seek the last octet that is non-zero <mark style="background: #69E772;">and</mark> less than or equal to 255.
* In this case, the fourth octet matches this criterion. Subtract this octet from 256 as follows: 256 – 192 = 64 which is The Magic Number
* The Address Table can be completed as follows:
* ![](https://i.imgur.com/2svQZCC.png)

* See how the <mark style="background: #69E772;">MN</mark> (64) is used to determine the <mark style="background: #69E772;">network address</mark> for each subnet.
* Note: the MN was derived from the fourth octet. Consequently, it is added to this octet in the previous subnet’s network address.
	
### <mark style="background: #69E772;">Subnetting a Class B Network:</mark>
	
* Given an address block of <mark style="background: #69E772;">172.25.0.0 /16</mark>, we wish to divide this network into 11 subnets with each subnet catering for 3000 hosts:
	* Determine the power of 2 to provide for 3000 hosts:
	* i.e. <mark style="background: #69E772;">2? = 3000</mark>
	* 2^12 is sufficient (i.e. 211 = 2048, 2 12 = 4096)
	* This requires four bits to be borrowed from the second octet.
	* Leaving <mark style="background: #69E772;">12 bits</mark> for host addresses.
	
* The new Subnet mask is:
	* 11111111.1111111.11110000.00000000
	* In DDN: <mark style="background: #69E772;">255.255.240.0</mark>
	* In CIDR notation: <mark style="background: #69E772;">/20</mark>
	
* Using the <mark style="background: #69E772;">Magic Number</mark> approach to determine the addresses in each subnet.
* 
* With a Mask for each subnet of: 255.255.240.0
	* Looking from left-to-right along the new mask, seek the last octet that is non-zero <mark style="background: #69E772;">and</mark> less than or equal to 255.
	* In this case, the third octet matches this criterion.
	* Subtract this octet from 256 as follows: 256 – 240 = 16 which is <mark style="background: #69E772;">The Magic Number</mark>
	
* The Address Table can be completed as follows:
* ![](https://i.imgur.com/Fyl7zNN.png)
	 
### <mark style="background: #69E772;">Basic Subnetting:</mark>

* ![](https://i.imgur.com/Npkpm8K.png)

* See how the <mark style="background: #69E772;">MN</mark> (16) is used to determine the <mark style="background: #69E772;">network address</mark> for each subnet. 
* Note: the MN was derived in the third octet. Consequently, it is added to this octet in the previous subnet’s network address.
	
### <mark style="background: #69E772;">Special IP Addresses:</mark>

* IP defines a set of special address forms that are reserved and should never be assigned to hosts

* These include:
	* <mark style="background: #69E772;">Directed Broadcast Address:</mark> This is defined for <mark style="background: #69E772;">each</mark> physical network. A <mark style="background: #69E772;">suffix</mark> of all 1 bits is added to the network prefix
	* <mark style="background: #69E772;">Limited Broadcast Address.</mark> Here an <mark style="background: #69E772;">address</mark> consisting of all 1 bits will allow a broadcast on “a single wire”
	* <mark style="background: #69E772;">This Computer Address.</mark> An IP address consisting of all zeros refers to <mark style="background: #69E772;">this computer</mark>. Used by hosts at <mark style="background: #69E772;">boot-up</mark> to obtain its IP address
	* <mark style="background: #69E772;">Loopback Address:</mark> This has a network prefix 127/8; the host suffix is irrelevant but is usually set to 1 i.e. 127.0.0.1
	

### <mark style="background: #69E772;">Routers and Multi-Homed Hosts:</mark>

* Routers <mark style="background: #69E772;">and</mark> multi-homed host computers are assigned two or more IP addresses because: 
	* They have connections to multiple physical networks
	* Each IP address prefix specifies <mark style="background: #69E772;">only one</mark> physical network.
	 
* A fundamental principle of the IP addressing scheme:

* “An IP address does not identify a specific computer. Instead, each IP address identifies a connection between a computer and a network. A computer with multiple network connections, e.g. a router, requires one IP address for each connection.”

### <mark style="background: #69E772;">Examples:</mark>

<mark style="background: #69E772;">A router addressing example:</mark>

* ![](https://i.imgur.com/5szfNDr.png)
	
	
<mark style="background: #69E772;">An example Classless Address Allocation:</mark>
	
* An organisation with an address block 17.12.40.0/26 has to divide this block for three separate networks requiring 32, 16 and 16 addresses.

* Firstly the size of the subnet masks for each sub-network needs to be calculated as follows:
	* 32 addresses requires a mask of 27 i.e. 2 32-27 = 32
	* 16 addresses requires a mask of 28 i.e. 2 32-28 = 16
	* 
* An example configuration for this organisation would be:
* ![](https://i.imgur.com/LbrbpdS.png)

	
<mark style="background: #69E772;">Another example of Classless Address Allocation:</mark>

* An ISP is allocated an address block 190.100.0.0/16.
* There are two groups of customers that need to be allocated addresses as follows:
* Group 1 - This group consists of 64 customers each requiring 256 addresses.
* Group 2 - This group consists of 128 customers each requiring 128 addresses.
* To be completed in class.
	
<mark style="background: #69E772;">Example IP Routing Table:</mark>
* ![](https://i.imgur.com/VzY92OK.png)
* ![](https://i.imgur.com/haubOLS.png)
