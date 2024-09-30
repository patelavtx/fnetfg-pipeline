terraform {
  backend "azurerm" {
    resource_group_name  = "atulrg-ado"
    storage_account_name = "atulado"
    container_name       = "ado-fnetfg"
    key                  = "fnetfg.tfstate"
  }
}
