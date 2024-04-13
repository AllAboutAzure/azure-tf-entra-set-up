/*
  Terraform Block Variables
*/
variable "subscription_id" {
  type = string
  description = "environment specific subscription ID"
}

variable "remote_state_backend" {
  type = object({
    storage_account = string
    storage_container = string
    file_name = string
    rg = string
    subscription = string
  })
  description = "this object contains the remote state file informations"
}

/*
 Module Variables
*/

variable "location" {
  type = string
  default = "EastUS"
  validation {
    condition = can(regex("^(EastUS)$", var.location))
    error_message = "Invalid location selected, only allowed locations is EastUS"
  }
}

variable "resource_groups" {
  type = map()
  description = "resource groups"
}

variable "virtual_network" {
  default = {}
  description = "vn"
}

variable "apims" {
  default = []
  description = "apims"
}

variable "entra_app_regs" {
  default = []
  description = "entra app registrations"
}

variable "app_service_environments" {
  default = []
}

variable "app_service_plans" {
  default = []
}

variable "function_apps" {
  default = []
}

variable "logic_apps" {
  default = []
}

variable "keyvaults" {
  default = []
}

variable "storage_accounts" {
  default = []
}