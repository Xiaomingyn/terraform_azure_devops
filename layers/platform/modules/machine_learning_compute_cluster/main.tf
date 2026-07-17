resource "azurerm_machine_learning_compute_cluster" "this" {
  name                          = var.name
  location                      = var.location
  machine_learning_workspace_id = var.machine_learning_workspace_id
  vm_priority                   = var.vm_priority
  vm_size                       = var.vm_size
  subnet_resource_id            = var.subnet_resource_id
  tags                          = var.tags

  scale_settings {
    min_node_count                       = var.min_node_count
    max_node_count                       = var.max_node_count
    scale_down_nodes_after_idle_duration = "PT15M"
  }
}
