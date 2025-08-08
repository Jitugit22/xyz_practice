resource "azurerm_public_ip" "PublicIP_ATOZ" {
  name                = "ATOZ-PublicIP"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}
