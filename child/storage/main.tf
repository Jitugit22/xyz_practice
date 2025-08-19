resource "azurerm_storage_account" "shivastorage" {
  name                     = "shivajitustorage1"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}