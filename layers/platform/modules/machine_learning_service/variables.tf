variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "application_insights_id" { type = string }
variable "key_vault_id" { type = string }
variable "storage_account_id" { type = string }
variable "identity" { 
    type = object({ type = string, identity_ids = list(string) }) 
    default = { type = "SystemAssigned", identity_ids = [] } 
}
variable "container_registry_id" { type = string }
variable "tags" { 
    type = map(string) 
    default = {} 
}
