# Configuration du provider 
provider "azurerm" {
  features {}
}

#creation du groupe de ressource 
resource "azurerm_resource_group" "test" {
  name     = "${var.name}-rg"
  location = var.location
}
#--------------------------------------------------------------------------------------
resource "azurerm_storage_account" "test" {
  name                     = "test"
  resource_group_name      = azurerm_resource_group.test.name
  location                 = azurerm_resource_group.test.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "test" {
  name                  = "vhds"
  storage_account_name  = azurerm_storage_account.test.name
  container_access_type = "private"
}
#--------------------------------------------------------------------------------------
# Creation du réseau virtuel
resource "azurerm_virtual_network" "test" {
  name                = "${var.name}-vnet"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]
}
#--------------------------------------------------------------------------------------
# Creation de sous_réseau test
resource "azurerm_subnet" "test" {
  name                 = "${var.name}-subnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.1.0/24"]
}
#--------------------------------------------------------------------------------------
# Creation de sous_réseau test2
resource "azurerm_subnet" "test2" {
  name                 = "${var.name}-subnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.2.0/24"]
}
#--------------------------------------------------------------------------------------
# Creation de sous_réseau test3
resource "azurerm_subnet" "test3" {
  name                 = "${var.name}-subnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.3.0/24"]
}
#--------------------------------------------------------------------------------------
#Creation de la carte réseau test
resource "azurerm_network_interface" "test" {
  name                = "${var.name}-nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  ip_configuration {
    name                          = "${var.name}-nic-ip-config"
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.test.id
  }
}
#--------------------------------------------------------------------------------------
#Creation de la carte réseau test2
resource "azurerm_network_interface" "test2" {
  name                = "${var.name}-nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  ip_configuration {
    name                          = "${var.name}-nic-ip-config"
    subnet_id                     = azurerm_subnet.test2.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.test.id
  }
}
#--------------------------------------------------------------------------------------
#Creation de la carte réseau test3
resource "azurerm_network_interface" "test3" {
  name                = "${var.name}-nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  ip_configuration {
    name                          = "${var.name}-nic-ip-config"
    subnet_id                     = azurerm_subnet.test3.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.test.id
  }
}
#--------------------------------------------------------------------------------------
#Creation de la machine virtuelle test
resource "azurerm_linux_virtual_machine" "test" {
  name                            = var.name
  location                        = azurerm_resource_group.test.location
  resource_group_name             = azurerm_resource_group.test.name
  network_interface_ids           = [azurerm_network_interface.test.id]
  size                            = "Standard_B1s"
  computer_name                   = "mpssrvm"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  os_disk {
    name                 = "${var.name}-os-disk"
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

}
#--------------------------------------------------------------------------------------
#Creation de la machine virtuelle test2
resource "azurerm_linux_virtual_machine" "test2" {
  name                            = var.name
  location                        = azurerm_resource_group.test.location
  resource_group_name             = azurerm_resource_group.test.name
  network_interface_ids           = [azurerm_network_interface.test2.id]
  size                            = "Standard_B1s"
  computer_name                   = "mpssrvm"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  os_disk {
    name                 = "${var.name}-os-disk"
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

}
#--------------------------------------------------------------------------------------
#Creation de la machine virtuelle test3
resource "azurerm_linux_virtual_machine" "test3" {
  name                            = var.name
  location                        = azurerm_resource_group.test.location
  resource_group_name             = azurerm_resource_group.test.name
  network_interface_ids           = [azurerm_network_interface.test3.id]
  size                            = "Standard_B1s"
  computer_name                   = "mpssrvm"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  os_disk {
    name                 = "${var.name}-os-disk"
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

}