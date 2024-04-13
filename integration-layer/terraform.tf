terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.99.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "2.48.0"
    }
  }
  backend "azurerm" {
    
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
    key_vault {
      purge_soft_delete_on_destroy = true
    }
    api_management {
      purge_soft_delete_on_destroy = true
    }
  }
  subscription_id = var.subscription_id
  skip_provider_registration = true
}


provider "azuread" {
  # Configuration options
}

# To cascade the integration layer output if needed to other layers
# Read outputs from the state files
data "terraform_remote_state" "integration_layer" {
  backend = "azurerm"
  config = {
    storage_account_name = var.remote_state_backend.storage_account
    container_name = var.remote_state_backend.storage_container
    key = var.remote_state_backend.file_name
    resource_group_name = var.remote_state_backend.rg
    subscription_id = var.remote_state_backend.subscription
  }
}