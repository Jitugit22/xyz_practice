
resource "azurerm_network_interface" "NIC_ATOZ" {
  name                = "ATOZ-NIC"
  location            = var.location
  resource_group_name = var.resource_group_name


  ip_configuration {
    name                          = "internaltest"
    subnet_id                     = data.azurerm_subnet.atozsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.name.id

  }
}


data "azurerm_public_ip" "name" {
  name                = "ATOZ-PublicIP"
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "atozsubnet" {
  name                 =  "ATOZY-Subnet1"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
}

resource "azurerm_linux_virtual_machine" "ATOZ_VM" {
  name                  = "ATOZ-LinuxVM"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_B1s"
  admin_username        = "azureATOZ"
  admin_password        = "P@ssw0rd1234!"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.NIC_ATOZ.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  custom_data = base64encode(<<EOF
#!/bin/bash
sudo apt-get update -y
sudo apt-get install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
  )
}

resource "azurerm_network_interface_security_group_association" "jituns_association" {
  network_interface_id      = azurerm_network_interface.NIC_ATOZ.id
  network_security_group_id = data.azurerm_network_security_group.nsgdata.id
}
 data "azurerm_network_security_group" "nsgdata" {
  name                = "nsgmonday"
  resource_group_name = "ATOZ-ResourceGroup"
}

