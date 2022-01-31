variable "resource_group_name" {
  description = "resource group name"
  type = string
  default = "test-rg"
}
variable "resource_group_location" {
  description = "resource group location"
  type = string
  default = "East us"
}

variable "virtual_network_name"{
  description = "Virtual network name"
  type = string
  default = "test-Vnet"
}

variable "subnet" {
  description = "subnet of virtual network"
  type = string  
  default = "subnet-${count.index}"
}

variable "network_address_space" {
 description = "address space" 
 type = list(string)
 default = ["10.67.9.0/24"]
  
}

variable "public_ip" {
  description = "Public ip for load balancer"
  type = string
  default = "publicIPForLB"
  
}

variable "loadBalancer" {
  description = "Load balancer create for 2 vm"
  type = string
  default = "loadBalancer-test"  
}

variable "NetworkInterfaceCard" {
  description = "create 2 NIC for vm"
  type = string
  default = "mynic"
  
}
variable "network_security_group"{
  description = "network security group name"
  type = string
  default = "Nsg-appvm"
}

variable "virtual_machine_name" {
  description = "VM"
  type = string
  default = "app-vm"
  }

variable "recovery_service_vault" {
  description = "Create RCV"
  type = string
  default = "RCV-appvm"
  
}
  variable "backup_policy" {
    description = "Backup of virtual machine"
    type = string
    default = "app-vm-recovery-vault-policy"
    
  }

  