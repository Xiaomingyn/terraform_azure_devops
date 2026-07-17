variable "name" { type = string }
variable "machine_learning_workspace_id" { type = string }
variable "virtual_machine_size" { 
    type = string 
    default = "Standard_DS3_v2" 
}
variable "subnet_resource_id" { 
    type = string 
    default = null 
}
variable "tags" { 
    type = map(string) 
    default = {} 
}
