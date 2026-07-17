module "resource_group" {
  count    = var.deploy_resource_group ? 1 : 0
  source   = "../../layers/core/modules/resource_group"
  name     = "${local.prefix}-rg"
  location = var.location
  tags     = local.common_tags
}

module "virtual_network" {
  count = var.deploy_virtual_network ? 1 : 0
  source              = "../../layers/core/modules/virtual_network"
  name                = "${local.prefix}-vnet"
  location            = var.location
  resource_group_name = module.resource_group[0].name
  address_space       = var.address_space
  subnets             = var.subnets
  tags                = local.common_tags
}

module "storage_account" {
  count                    = var.deploy_storage_account ? 1 : 0
  source                   = "../../layers/core/modules/storage_account"
  name                     = "${local.prefix}-StAc-1"
  location                 = var.location
  resource_group_name      = module.resource_group[0].name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.common_tags
}

module "key_vault" {
  count               = var.deploy_keyvault ? 1 : 0
  source              = "../../layers/core/modules/key_vault"
  name                = substr(replace("${local.prefix}-kv", "-", ""), 0, 24)
  location            = var.location
  resource_group_name = module.resource_group[0].name
  tenant_id           = var.tenant_id
  sku_name            = "standard"
  purge_protection_enabled = false
  tags                = local.common_tags
}

module "log_analytics_workspace" {
  count               = var.deploy_loganalysticsworkspace ? 1 : 0
  source              = "../../layers/core/modules/log_analytics_workspace"
  name                = replace("${local.prefix}-law", "-", "")
  location            = var.location
  resource_group_name = module.resource_group[0].name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.common_tags
}

module "application_insights" {
  count               = var.deploy_applicationInsights ? 1 : 0
  source              = "../../layers/platform/modules/application_insights"
  name                = "${local.prefix}-appi"
  location            = var.location
  resource_group_name = module.resource_group[0].name
  workspace_id        = module.log_analytics_workspace[0].id
  application_type    = "web"
  tags                = local.common_tags
}

module "app_service_plan" {
  count               = var.deploy_app_service_plan ? 1 : 0
  source              = "../../layers/platform/modules/app_service_plan"
  name                = "${local.prefix}-asp"
  location            = var.location
  resource_group_name = module.resource_group[0].name
  os_type             = "Linux"
  sku_name            = var.app_service_sku
  tags                = local.common_tags
}

module "container_registry" {
  count               = var.deploy_containerregistry ? 1 : 0
  source              = "../../layers/platform/modules/container_registry"
  name                = replace("${local.prefix}acr", "-", "")
  location            = var.location
  resource_group_name = module.resource_group[0].name
  sku                 = var.acr_sku
  admin_enabled       = true
  tags                = local.common_tags
}

module "data_factory" {
  count               = var.deploy_data_factory && var.deploy_data_factory ? 1 : 0
  source              = "../../layers/platform/modules/data_factory"
  name                = "${local.prefix}-adf"
  location            = var.location
  resource_group_name = module.resource_group[0].name
  managed_virtual_network_enabled = false
  tags                = local.common_tags
}

module "logic_app" {
  count               = var.deploy_LogicApp ? 1 : 0
  source              = "../../layers/platform/modules/logic_app"
  name                = "${local.prefix}-logic"
  location            = var.location
  resource_group_name = module.resource_group[0].name
  tags                = local.common_tags
}

module "machine_learning_service" {
  count                  = var.deploy_machinelearning ? 1 : 0
  source                 = "../../layers/platform/modules/machine_learning_service"
  name                   = "${local.prefix}-mlw"
  location               = var.location
  resource_group_name    = module.resource_group[0].name
  application_insights_id = module.application_insights[0].id
  key_vault_id           = module.key_vault[0].id
  storage_account_id     = module.storage_account[0].id
  container_registry_id  = module.container_registry[0].id
  tags                   = local.common_tags
}

module "machine_learning_compute_cluster" {
  count                         = var.deploy_machinelearningComputeCluster ? 1 : 0
  source                        = "../../layers/platform/modules/machine_learning_compute_cluster"
  name                          = "${local.prefix}-mlcc"
  location                      = var.location
  machine_learning_workspace_id = module.machine_learning_service[0].id
  vm_priority                     = "lowpriority"
  vm_size                         = "STANDARD_DS3_V2"
  min_node_count                     = 0
  max_node_count                     = 2
  subnet_resource_id            = module.virtual_network[0].subnet_ids["ml"]
  tags                          = local.common_tags
}

module "machine_learning_compute_instance" {
  count                         = var.deploy_machinelearningComputeInstance ? 1 : 0
  source                        = "../../layers/platform/modules/machine_learning_compute_instance"
  name                          = "${local.prefix}-mlci"
  location                      = var.location
  machine_learning_workspace_id = module.machine_learning_service[0].id
  virtual_machine_size            = "STANDARD_DS3_V2"
  subnet_resource_id            = module.virtual_network[0].subnet_ids["ml"]
  tags                          = local.common_tags
}

module "synapse" {
  count                               = var.deploy_synapse ? 1 : 0
  source                              = "../../layers/platform/modules/synapse"
  name                                = "${local.prefix}-synw"
  location                            = var.location
  resource_group_name                 = module.resource_group[0].name
  storage_data_lake_gen2_filesystem_id = "/subscriptions/${var.subscription_id}/resourceGroups/${module.resource_group[0].name}/providers/Microsoft.Storage/storageAccounts/${module.storage_account[0].name}/blobServices/default/containers/synapse"
  sql_administrator_login             = var.synapse_admin_login
  sql_administrator_login_password    = var.synapse_admin_password
  tags                                = local.common_tags
}

module "app_service" {
  count                                 = var.deploy_app_service ? 1 : 0
  source                                = "../../layers/application/modules/app_service"
  name                                  = "${local.prefix}-app"
  location                              = var.location
  resource_group_name                   = module.resource_group[0].name
  service_plan_id                       = module.app_service_plan[0].id
  application_insights_connection_string = module.application_insights[0].connection_string
  https_only                            = true
  tags                                  = local.common_tags
}

module "container_app" {
  count                        = var.deploy_container_apps ? 1 : 0
  source                       = "../../layers/application/modules/container_app"
  name                         = "${local.prefix}-ca"
  resource_group_name          = module.resource_group[0].name
  container_app_environment_id = "/subscriptions/${var.subscription_id}/resourceGroups/${module.resource_group[0].name}/providers/Microsoft.App/managedEnvironments/${local.prefix}-cae"
  container_name                = "my-container"
  image                        = var.container_image
  cpu                          = "0.5"
  memory                       = "1.0Gi"
  tags                         = local.common_tags
}

module "cognitive_services" {
  count               = var.deploy_cognitive_services ? 1 : 0
  source              = "../../layers/application/modules/cognitive_services"
  name                = replace("${local.prefix}-cog", "-", "")
  location            = var.location
  resource_group_name = module.resource_group[0].name
  kind                = "CognitiveServices"
  sku_name            = var.cognitive_sku
  tags                = local.common_tags
}
