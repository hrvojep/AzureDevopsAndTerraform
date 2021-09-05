provider "azurerm" {    
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "tfmainrg-storage-account-h"
        storage_account_name = "tfmainrgstorageaccounth"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg-h"
  location = "australiaeast"
}

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}



resource "azurerm_container_group" "tfcg_test" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.tf_test.location
  resource_group_name       = azurerm_resource_group.tf_test.name

  ip_address_type     = "public"
  dns_name_label      = "h-weatherapi"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "hrvoje/weatherapi:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}