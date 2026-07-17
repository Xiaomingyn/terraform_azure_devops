variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "storage_data_lake_gen2_filesystem_id" { type = string }
variable "sql_administrator_login" { type = string }
variable "sql_administrator_login_password" { 
    type = string 
    default = "SynapseAdminPassword123!"
    sensitive = true 
}

variable "tags" { 
    type = map(string) 
    default = {} 
}
