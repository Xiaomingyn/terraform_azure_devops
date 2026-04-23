location            = "YOUR-AZURE-GEO-LOCATION"
resource_group_name = "YOUR-resource_group_name"
vnet_name           = "vnet-tf-prod"
vnet_address_space  = ["10.20.0.0/16"]
subnet_name         = "snet-app"
subnet_prefixes     = ["10.20.1.0/24"]

tags = {
 environment = "prod"
 managed_by  = "terraform"
 repo        = "YOUR-REPO-NAME"
}