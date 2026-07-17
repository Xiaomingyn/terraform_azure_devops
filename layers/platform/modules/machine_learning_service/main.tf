resource "azurerm_machine_learning_workspace" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  application_insights_id       = var.application_insights_id
  key_vault_id                  = var.key_vault_id
  storage_account_id            = var.storage_account_id
  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }
  container_registry_id         = var.container_registry_id
  public_network_access_enabled = true
  tags                          = var.tags
}
