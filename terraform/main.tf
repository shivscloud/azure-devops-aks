locals {
  env                 = "dev"
  region              = "eastus"
  resource_group_name = "rajesh-aks-deploy"
  eks_name            = "rajesh-aks"
  eks_version         = "1.27"
  
  // Define subnet configurations
  subnets = {
    subnet1 = {
      address_prefixes = ["10.0.0.0/24"]
    }
    subnet2 = {
      address_prefixes = ["10.0.20.0/24"]
    }
    // Add more subnet configurations as needed
  }
}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = local.region
}

resource "azurerm_virtual_network" "this" {
  name                = "main"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = {
    env = local.env
  }
}

resource "azurerm_subnet" "subnets" {
  for_each            = local.subnets
//   count               = length(local.subnets)
  name                = each.key
  address_prefixes    = each.value.address_prefixes
  resource_group_name = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}
