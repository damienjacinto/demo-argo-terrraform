/**
 * # Config
 *
 * - Module to handle default configuration with overloading by environment
 * - Environment input must match a sub-module of this module
 *
 */

module "_defaults" {
  source = "./_defaults"
}

module "local" {
  source = "./local"
}

locals {
  data_map = {
    local = module.local.data,
  }
}

output "data" {
  value = merge(
    module._defaults.data,
    lookup(local.data_map, var.config_env)
  )
}
