resource "azurerm_resource_group" "rg-uks-vm" {
  name     = "rg-uks-vm"
  location = "uksouth"
}

resource "azurerm_virtual_network" "vnet-uks" {
  name                = "vnet-uks"
  location            = azurerm_resource_group.rg-uks-vm.location
  resource_group_name = azurerm_resource_group.rg-uks-vm.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "vnet-uks-snet-01" {
  name                 = "vnet-uks-snet-01"
  virtual_network_name = azurerm_virtual_network.vnet-uks.name
  resource_group_name  = azurerm_resource_group.rg-uks-vm.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic-uks" {
  count = 2
  name                = "nic-uks-0${count.index + 1}"  
  location            = azurerm_resource_group.rg-uks-vm.location
  resource_group_name = azurerm_resource_group.rg-uks-vm.name
  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.vnet-uks-snet-01.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm-uks" {
  count = 2
  name                  = "vm-uks-0${count.index + 1}"
  location              = azurerm_resource_group.rg-uks-vm.location
  resource_group_name   = azurerm_resource_group.rg-uks-vm.name
  network_interface_ids = [azurerm_network_interface.nic-uks[count.index].id]
  size                  = "Standard_B1s"
  admin_username        = "labadmin"
  admin_password        = "DoNotUseInProd1!"

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "None"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  provision_vm_agent = true
}

resource "azurerm_virtual_machine_extension" "web_server_install" {
  for_each                   = tomap(azurerm_windows_virtual_machine.vm-uks)
  name                       = "${each.value.name}-wsi"
  virtual_machine_id         = each.value.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    }
  SETTINGS
}