variable "name" { type = string }
variable "location" { type = string }
variable "machine_learning_workspace_id" { type = string }
variable "vm_priority" { 
    type = string 
    default = "Dedicated" 
}
variable "vm_size" { 
    type = string 
    default = "Standard_DS3_v2" 
}
variable "min_node_count" { 
    type = number 
    default = 0 
}
variable "max_node_count" { 
    type = number 
    default = 2 
}
variable "subnet_resource_id" { 
    type = string 
    default = null 
}
variable "tags" { 
    type = map(string) 
    default = {} 
}
