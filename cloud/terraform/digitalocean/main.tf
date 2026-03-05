# DigitalOcean – Droplet for Clawitzer build or interactive testing.
# Set TF_VAR_do_token or do_token in env; optionally do_ssh_key_id for existing key.
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.34"
    }
  }
}

variable "do_token" {
  type      = string
  sensitive = true
  default   = ""
}

provider "digitalocean" {
  token = var.do_token != "" ? var.do_token : null
}

variable "droplet_name" {
  type    = string
  default = "clawitzer-build"
}

variable "region" {
  type    = string
  default = "nyc3"
}

variable "size" {
  type    = string
  default = "s-1vcpu-1gb"
}

variable "ssh_key_ids" {
  type    = list(number)
  default = []
}

resource "digitalocean_droplet" "main" {
  name   = var.droplet_name
  region = var.region
  size   = var.size
  image  = "ubuntu-24-04-x64"

  dynamic "ssh_key" {
    for_each = var.ssh_key_ids
    content {
      id = ssh_key.value
    }
  }
}

output "ipv4_address" {
  value = digitalocean_droplet.main.ipv4_address
}

output "ssh_command" {
  value = "ssh root@${digitalocean_droplet.main.ipv4_address}"
}
