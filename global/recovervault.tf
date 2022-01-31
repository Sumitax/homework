resource "azurerm_recovery_services_vault" "test-vault" {
  name                = var.recovery_service_vault
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  sku                 = "Standard"

  soft_delete_enabled = true
}

resource "azurerm_backup_policy_vm" "backuppolicy" {
  name                = var.backup_policy
  resource_group_name = azurerm_resource_group.myrg.name
  recovery_vault_name = azurerm_recovery_services_vault.test-vault.name

  timezone = "UTC"

  backup {
    frequency = "Weekly"
    time      = "23:00"
    days      = "Sunday"
  }


  retention_weekly {
    count    = 14
    days = "Sunday"
  }

}