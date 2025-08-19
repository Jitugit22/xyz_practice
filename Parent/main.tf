module "rg" {
  source = "../child/resource_group"

}

module "storage_account_type" {
  source     = "../child/storage"
  depends_on = [module.rg]
}


module "vnet" {
  source     = "../child/virtual_network"
  depends_on = [module.rg]
}

module "public_ip" {
  source     = "../child/Public_ip"
  depends_on = [module.rg]
}

module "NSG" {
  source     = "../child/NSG"
  depends_on = [module.rg]
}

module "azurerm_linux_virtual_machine" {
  source     = "../child/virtual_machine"
  depends_on = [module.rg, module.vnet, module.public_ip, module.NSG]
}

module "sql_server" {
  source     = "../child/sql_server"
  depends_on = [module.rg]
}

module "sql_database" {
  source     = "../child/sql_database"
  depends_on = [module.rg, module.sql_server]
}

terraform {
  backend "azurerm" {
  }
}