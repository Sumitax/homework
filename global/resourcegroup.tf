#Resource-1: AZure Resource group
resource "azurerm_resource_group" "myrg" {
  name = var.resource_group_name
  location = var.resource_group_location
}

# Resource-2: Random String 
resource "random_string" "myrandom" {
  length = 16
  upper = false 
  special = false
}

