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

## Azure Firewall without NAT for outbound connectivity
Adding an Azure Firewall to the hub network and a UDR to the spokes (by applying the config in bub-firewall.tf) forces internet traffic for the spoke VMs to be routed via the Azure Firewall.