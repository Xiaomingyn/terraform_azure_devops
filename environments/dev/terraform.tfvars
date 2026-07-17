# General informaiton 
## Note: keep these values as short as possible, as they will be used in naming resources.
##       If they are too long, terraform prozess will break due to naming constraints.
organization           = "xctec"
project                = "infra"
workload_name          = "analytics"
location               = "westeurope" # Not used in naming resources

# Passing through from DevOps YAML parameter
#environment                             = "dev"          
#deploy_storage_account                  = false
#deploy_loganalysticsworkspace           = false
#deploy_keyvault                         = false
#deploy_containerregistry                = false
#deploy_applicationInsights              = false
#deploy_machinelearning                  = false
#deploy_synapse                          = false
#deploy_machinelearningComputeInstance   = false
#deploy_machinelearningComputeCluster    = false 
#deploy_LogicApp                         = false 
#deploy_data_factory                     = false
#deploy_app_service                      = false 
#deploy_app_service_plan                 = false 
#deploy_cognitive_services               = false 
#deploy_container_apps                   = false
#deploy_resource_group                   = false
#deploy_virtual_network                  = false

# Application specific parameter
synapse_admin_login                     = "synadminuser"