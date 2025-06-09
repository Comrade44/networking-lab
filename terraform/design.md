# Single-region Hub & Spoke

## Summary
This is a single region hub and spoke configuration that uses a NAT gateway and Azure Firewall for outbound access to the internet from the subnets.

## Virtual Networks
There are three virtual networks, one hub and two spokes. Each has a single subnet. The two spokes are peered bi-directionally to the hub.

## Bastion
Azure Bastion is configured and connected to the hub network to allow remote access to the VMs.

## Default outbound connectivity
https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/default-outbound-access
With a public IP address attached to the vm, curl https://ipinfo.io will return the IP of the public IP.

## NAT Gateway outbound connectivity
NAT gateway provides IP proxy and NAT services for outbound internet connectivity. NAT gateways are created per-vnet, and cannot be used from a peered vnet.