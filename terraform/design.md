# Single-region Hub & Spoke

## Summary
This is a single region hub and spoke configuration that uses a NAT gateway and Azure Firewall for outbound access to the internet from the subnets.

## Virtual Networks
There are three virtual networks, one hub and two spokes. Each has a single subnet. The two spokes are peered bi-directionally to the hub.

## Bastion
Azure Bastion is configured and connected to the hub network to allow remote access to the VMs.