
# VWAN

## Summary
VWAN is an Azure service that makes it simpler to manage network topologies, for example automating route tables and peerings between vnets. This setup will configure a hub-and-spoke network using VWAN

## Components
The two main components are the virtual WAN, and the VWAN hub. Hubs are Microsoft managed VNets that exist in each region in which you want connectivity, and are associated with the VWAN component, which is the overall collection of networks.

## Spoke-to-spoke communication - single region
Deploying a VWAN hub and adding a virtual hub connection automatically creates peerings between the hub and the spoke. Similarly to a traditional hub-and-spoke deployment, the VWAN hub acts as a relay allowing communication between Vnets, and traffic transit still needs to be enabled on the peerings.

## Bastion in VWAN
Bastion cannot be deployed directly to a VWAN hub. It is recommended that a separate VNet is created.

## Spoke-to-spoke communication - multi-region

