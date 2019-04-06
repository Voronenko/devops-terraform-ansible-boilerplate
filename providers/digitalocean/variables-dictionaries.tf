variable "workspace_to_environment_map" {
  type = "map"
  default = {
    default = "default"
    dev     = "dev"
    qa      = "qa"
    staging = "staging"
    prod    = "prod"
  }
}

variable "environment_to_instance_size_map" {
  type = "map"
  default = {
    default = "s-1vcpu-3gb"
    dev     = "s-1vcpu-3gb"
    qa      = "s-1vcpu-3gb"
    staging = "s-1vcpu-3gb"
    prod    = "s-1vcpu-3gb"
  }
}

variable "environment_to_fixedip_map" {
  type = "map"
  default = {
    default = "false"
    dev     = "false"
    qa      = "false"
    staging = "false"
    prod    = "false"
  }
}

variable "environment_to_region_map" {
  type = "map"
  default = {
    default = "ams3"
    dev     = "ams3"
    qa      = "ams3"
    staging = "ams3"
    prod    = "ams3"
  }
}

variable "environment_to_keys_map" {
  type = "map"
  default = {
    default = "2241440"
    dev     = "2241440"
    qa      = "2241440"
    staging = "2241440"
    prod    = "2241440"
  }
}


