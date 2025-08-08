resource "azurerm_virtual_network" "VNET_ATOZ" {
  name                = "ATOZ-VirtualNetwork11"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name

}

resource "azurerm_subnet" "Subnet1_ATOZ" {
    depends_on = [ azurerm_virtual_network.VNET_ATOZ ]
  name                 = "ATOZY-Subnet1"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "Subnet2_ATOZ" {
    depends_on = [ azurerm_virtual_network.VNET_ATOZ ]
  name                 = "ATOZY-Subnet2"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.2.0/24"]
}