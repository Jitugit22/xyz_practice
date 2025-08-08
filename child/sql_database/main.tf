data "azurerm_mssql_server" "ATOZ_sql_server" {
  name                = var.sql_server_name
  resource_group_name = var.resource_group_name
}   


resource "azurerm_mssql_database" "ATOZ_sql_database" {

  name         = "ATOZ-db"
  server_id    = data.azurerm_mssql_server.ATOZ_sql_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

  tags = {
    foo = "bar"
  }
}
