output "resource_group_name" {
 value = azurerm_resource_group.this.name
}

output "virtual_network_name" {
 value = azurerm_virtual_network.this.name
}

output "subnet_name" {
 value = azurerm_subnet.this.name
}