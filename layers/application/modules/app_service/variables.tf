variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "service_plan_id" { type = string }
variable "application_insights_connection_string" { 
    type = string 
    default = null 
}
variable "https_only" { 
    type = bool 
    default = true 
}

variable "tags" { 
    type = map(string) 
    default = {} 
}
