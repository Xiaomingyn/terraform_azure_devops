locals {
  name_prefix = lower(join("-", compact([
    var.organization,
    var.project,
    var.workload_name,
    var.environment
  ])))
}
