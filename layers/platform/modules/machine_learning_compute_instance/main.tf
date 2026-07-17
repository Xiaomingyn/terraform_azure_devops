resource "azurerm_machine_learning_compute_instance" "this" {
  name                          = var.name
  machine_learning_workspace_id = var.machine_learning_workspace_id
  virtual_machine_size          = var.virtual_machine_size
  subnet_resource_id            = var.subnet_resource_id
  tags                          = var.tags
}
