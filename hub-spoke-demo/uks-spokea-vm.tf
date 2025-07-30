resource "azurerm_resource_group" "rg-uks-spokea-vm-01" {
  name     = "rg-uks-spokea-vm-01"
  location = "uksouth"
}

resource "azurerm_network_interface" "nic-uks-spokea-01" {
  name                = "nic-uks-spokea-01"
  location            = azurerm_resource_group.rg-uks-spokea-vm-01.location
  resource_group_name = azurerm_resource_group.rg-uks-spokea-vm-01.name
  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.vnet-uks-spokea-01-snet-01.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm-uks-spokea-01" {
  name                  = "vm-uks-spokea-01"
  location              = azurerm_resource_group.rg-uks-spokea-vm-01.location
  resource_group_name   = azurerm_resource_group.rg-uks-spokea-vm-01.name
  network_interface_ids = [azurerm_network_interface.nic-uks-spokea-01.id]
  size                  = "Standard_B1s"
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "None"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  admin_username = "labadmin"
  admin_ssh_key {
    username   = "labadmin"
    public_key = var.ssh_public_key
  }

}