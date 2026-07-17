variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "managed_virtual_network_enabled" { 
    type = bool 
    default = false 
}
variable "tags" { 
    type = map(string) 
    default = {} 
}
