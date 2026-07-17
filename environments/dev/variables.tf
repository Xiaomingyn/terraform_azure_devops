# Azure Service Principal credentials
# Passing through from DevOps YAML parameter
variable "subscription_id" { type = string }
variable "tenant_id" { type = string }
variable "client_id" { type = string }
variable "client_secret" { 
  type = string 
  sensitive = true 
}

# General informaiton
# Defined in terraform.tfvars file
variable "organization" { type = string }
variable "project" { type = string }
variable "workload_name" { type = string }
variable "location" { type = string }

# resource deployment control
# Passing through from DevOps YAML parameter
variable "environment" { type = string }
variable "deploy_storage_account" { type = bool }
variable "deploy_loganalysticsworkspace" { type = bool }
variable "deploy_keyvault" { type = bool }
variable "deploy_containerregistry" { type = bool }
variable "deploy_applicationInsights" { type = bool }
variable "deploy_machinelearning" { type = bool }
variable "deploy_synapse" { type = bool }
variable "deploy_machinelearningComputeInstance" { type = bool }
variable "deploy_machinelearningComputeCluster" { type = bool }
variable "deploy_LogicApp" { type = bool }
variable "deploy_data_factory" { type = bool }
variable "deploy_app_service" { type = bool }
variable "deploy_app_service_plan" { type = bool }
variable "deploy_cognitive_services" { type = bool }
variable "deploy_container_apps" { type = bool }
variable "deploy_resource_group" { type = bool }
variable "deploy_virtual_network" { type = bool }

# resource specific parameters
variable "extra_tags" { 
  type = map(string) 
  default = {} 
}
variable "address_space" { 
  type = list(string) 
  default = ["10.10.0.0/16"] 
}
variable "subnets" {
  type = map(object({ address_prefixes = list(string) }))
  default = {
    app     = { address_prefixes = ["10.10.1.0/24"] }
    data    = { address_prefixes = ["10.10.2.0/24"] }
    ml      = { address_prefixes = ["10.10.3.0/24"] }
    private = { address_prefixes = ["10.10.4.0/24"] }
  }
}
variable "container_image" { 
  type = string 
  default = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest" 
}
variable "app_service_sku" { 
  type = string 
  default = "B1" 
}

variable "acr_sku" { 
  type = string 
  default = "Basic" 
}

variable "cognitive_sku" { 
  type = string 
  default = "S0" 
}
variable "synapse_admin_login" { 
  type = string 
  default = "synadminuser" 
}
variable "synapse_admin_password" { 
  type = string 
  default = "SynapseAdminPassword123!"
  sensitive = true 
}

