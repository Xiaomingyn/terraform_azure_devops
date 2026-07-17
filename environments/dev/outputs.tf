output "resource_group_name" { value = try(module.resource_group[0].name, null) }
output "virtual_network_id" { value = try(module.virtual_network[0].id, null) }
output "app_service_hostname" { value = try(module.app_service[0].default_hostname, null) }
output "key_vault_uri" { value = try(module.key_vault[0].vault_uri, null) }
output "storage_account_id" { value = try(module.storage_account[0].id, null) }
