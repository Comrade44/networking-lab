# Single-region Hub & Spoke

## Summary
This is a single region hub and spoke configuration that uses a NAT gateway and Azure Firewall for outbound access to the internet from the subnets.

## Virtual Networks
There are three virtual networks, one hub and two spokes. Each has a single subnet. The two spokes are peered bi-directionally to the hub.

## routing
Routing between virtual networks is not possible by default. Even with a UDR pointing to the hub network, a forwarding device (such as a firewall or NVA) is required to route traffic.

## Bastion
Azure Bastion is configured and connected to the hub network to allow remote access to the VMs.

## Default outbound connectivity
https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/default-outbound-access
With a public IP address attached to the vms, curl https://ipinfo.io will return the IP of the public IP.

## NAT Gateway outbound connectivity
NAT gateway provides IP proxy and NAT services for outbound internet connectivity. NAT gateways are created per-vnet, and cannot be used from a peered vnet.
Applying the config in the file outbound-nat.tf, logging into the VMs via Bastion and running curl https://ipinfo.io will return the IP address of the NAT gateway for that subnet.

## Azure Firewall for outbound connectivity
Adding an Azure Firewall to the hub network and a UDR to the spokes (by applying the config in hub-firewall.tf) forces all outbound traffic for the spoke VMs to be routed via the Azure Firewall.
Basic SKU cannot use Firewall Manager to deploy policy rule sets, and all traffic is explicitly denied by Azure Firewall.

## Inter-spoke network connectivity
With the Azure firewall set up in the hub vnet, enabling the option "Allow 'vnet-a' to receive forwarded traffic from 'vnet-b" on all peerings will allow the spokes to communicate. This can be verified by installing and running Apache on the VM in spoke B, and using curl to connect to the web server from the VM in spoke A.

## NAT gateway in front of Azure Firewall for increased SNAT capability
https://learn.microsoft.com/en-us/azure/firewall/integrate-with-nat-gateway
Azure firewall supports up to 250 public IP addresses, each with up to 2496 SNAT ports. For larger scale solutions such as AVD, using a NAT gateway with Azure firewall allows up to 16 public IP addresses each with 64,512 SNAT ports. This will provide the same amount of outbound ports with fewer Public IPs to manage. Applying the config in hub-firewall-nat-gw.tf will add this functionality.
