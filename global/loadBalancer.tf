resource "azurerm_lb" "LB" {
   name                = var.loadBalancer
   location            = azurerm_resource_group.myrg.location
   resource_group_name = azurerm_resource_group.myrg.name
   sku                 = Standard
   type                = Public

   frontend_ip_configuration {
     name                 = "publicIPAddress"
     public_ip_address_id = azurerm_public_ip.publicIP-LB-test.id
   }
 }

 resource "azurerm_lb_backend_address_pool" "BEpool" {
   loadbalancer_id     = azurerm_lb.LB.id
   name                = "BackEndAddressPool"
 }
resource "azurerm_lb_backend_address_pool_address" "BEpooladdress" {
  name                    = "example"
  backend_address_pool_id = azurerm_lb_backend_address_pool.BEpool.id
  virtual_network_id      = azurerm_virtual_network.vnet.id
  ip_address              = "Dynamic"
}

 resource "azurestack_lb_probe" "test" {
  resource_group_name = azurestack_resource_group.test.name
  loadbalancer_id     = azurestack_lb.test.id
  name                = "running-probe"
  port                = 80
}