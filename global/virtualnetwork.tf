#create virtual network
resource "azurerm_virtual_network" "vnet" {
    name = var.virtual_network_name
    address_space = var.network_address_space
    location = azurerm_resource_group.myrg.location
    resource_group_name = azurerm_resource_group.myrg.name
}

#create subnet
resource "azurerm_subnet" "mysubnet" {
    name = var.subnet
    resource_group_name = azurerm_resource_group.myrg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.67.9.0/24"]
}

#create public ip address
resource "azurerm_public_ip" "publicIP-LB-test" {
   name                         = var.public_ip
   location                     = azurerm_resource_group.myrg.location
   resource_group_name          = azurerm_resource_group.myrg.name
   allocation_method            = "Dynamic"
 }

 resource "azurerm_network_security_group" "Nsg" {
  name                = var.network_security_group
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    port                       = 1433
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "test123"
    priority                   = 101
    port                       = 3389
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

 }
 resource "azurerm_network_interface" "NIC" {
   count               = 2
   name                = "${var.NetworkInterfaceCard}-${count.index}"
   location            = azurerm_resource_group.myrg.location
   resource_group_name = azurerm_resource_group.myrg.name

   ip_configuration {
     name                          = "testConfiguration"
     subnet_id                     = azurerm_subnet.mysubnet.id
     private_ip_address_allocation = "dynamic"
   }
 }

 resource "azurerm_network_interface_security_group_association" "attach_Nic_Nsg" {
    count                     = 2
    network_interface_id      = element(azurerm_network_interface.NIC.*.id, count.index)
    network_security_group_id = azurerm_network_security_group.Nsg.id
}
