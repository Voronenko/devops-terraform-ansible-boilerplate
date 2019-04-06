provider "digitalocean" {
  # You need to set this in your .bashrc
  # export DIGITALOCEAN_TOKEN="Your API TOKEN"
  #
}

resource "digitalocean_droplet" "web" {
  # Obtain your ssh_key id number via your account. See Document https://developers.digitalocean.com/documentation/v2/#list-all-keys
  ssh_keys           = ["${var.environment_to_keys_map[local.env]}"]
  image              = "${local.app_ami}"
  region             = "${var.environment_to_region_map[local.env]}"
  size               = "${var.environment_to_instance_size_map[local.env]}"
  private_networking = false
  backups            = false
  ipv6               = false
  name               = "webserver"

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt-get -y install curl",
    ]

    connection {
      type     = "ssh"
      private_key = "${file("~/.ssh/id_rsa")}"
      user     = "root"
      timeout  = "2m"
    }
  }

}

resource "null_resource" "baseboxed_servers" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    cluster_instance_ids = "${join(",", digitalocean_droplet.web.*.id)}"
  }


  provisioner "local-exec" {
    command = "$INFRASTRUCTURE_ROOT_DIR/provisioners/base-box/provision_box.sh"

    environment {
      REMOTE_HOST = "${digitalocean_droplet.web.ipv4_address}"
      REMOTE_USER_INITIAL = "root"
      REMOTE_PASSWORD_INITIAL = ""
      BOX_DEPLOY_USER = "ubuntu"
      BOX_DEPLOY_PASS = ""
      BOX_PROVIDER = "digitalocean"
    }
  }
}



