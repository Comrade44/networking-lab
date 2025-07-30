resource "azurerm_resource_group" "rg-centralus-vm" {
  name     = "rg-centralus-vm"
  location = "centralus"
}

resource "azurerm_virtual_network" "vnet-centralus" {
  name                = "vnet-centralus"
  location            = azurerm_resource_group.rg-centralus-vm.location
  resource_group_name = azurerm_resource_group.rg-centralus-vm.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "vnet-centralus-snet-01" {
  name                 = "vnet-centralus-snet-01"
  virtual_network_name = azurerm_virtual_network.vnet-centralus.name
  resource_group_name  = azurerm_resource_group.rg-centralus-vm.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic-centralus-01" {
  name                = "nic-centralus-01"
  location            = azurerm_resource_group.rg-centralus-vm.location
  resource_group_name = azurerm_resource_group.rg-centralus-vm.name
  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.vnet-centralus-snet-01.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm-centralus" {
  name                  = "vm-centralus"
  location              = azurerm_resource_group.rg-centralus-vm.location
  resource_group_name   = azurerm_resource_group.rg-centralus-vm.name
  network_interface_ids = [azurerm_network_interface.nic-centralus-01.id]
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

  custom_data = base64encode(<<-EOF
    <powershell>
      Install-WindowsFeature -name Web-Server -IncludeManagementTools
      remove-item C:\inetpub\wwwroot\iisstart.htm
      Add-Content -Path "C:\inetpub\wwwroot\iisstart.htm" -Value $("Hello World from " + $env:computername)
    </powershell>
  EOF
  )
}