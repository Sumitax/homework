resource "azurerm_virtual_machine" "VM" {
   count                 = 2
   name                  = "${var.virtual_machine_name}-${count.index}"
   location              = azurerm_resource_group.myrg.location
   resource_group_name   = azurerm_resource_group.myrg.name
   network_interface_ids = [element(azurerm_network_interface.NIC.*.id, count.index)]
   vm_size               = "Standard_B2s"
   admin_username        = var.azurerm_key_vault_secret.Secret.name
   admin_password        = var.azurerm_key_vault_secret.Secret.value


  storage_os_disk {
     name              = "myosdisk${count.index}"
     caching           = "ReadWrite"
     create_option     = "FromImage"
     storage_disk_type = "Standard_LRS"
     disk_size_gb      = "500"
   }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

   