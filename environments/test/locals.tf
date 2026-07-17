locals {
  common_tags = merge({
    managed_by  = "terraform"
    environment = var.environment
    workload    = var.workload_name
    project     = var.project
    layer_model = "core-platform-application"
  }, var.extra_tags)

  prefix = lower(join("-", [var.organization, var.project, var.workload_name, var.environment]))
}
