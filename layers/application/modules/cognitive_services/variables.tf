variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "kind" { 
    type = string 
    default = "CognitiveServices" 
}

variable "sku_name" { 
    type = string 
    default = "S0" 
}
variable "tags" { 
    type = map(string) 
    default = {} 
}
