
locals {
  env = "${lookup(var.workspace_to_environment_map, terraform.workspace, "dev")}"
  region = "${var.environment_to_region_map[local.env]}"

  app_instance_type = "${var.environment_to_instance_size_map[local.env]}"
  app_ami = "${var.ubuntu}"

  common_tags = "${map(
    "Environment", "${local.env}"
  )}"

}
