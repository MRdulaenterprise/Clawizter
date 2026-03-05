# Hetzner Cloud – VM for Clawitzer build or interactive testing.
# Set HCLOUD_TOKEN in env or use -var "hcloud_token=...".
terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

variable "hcloud_token" {
  type      = string
  sensitive = true
  default   = ""
}

provider "hcloud" {
  token = var.hcloud_token != "" ? var.hcloud_token : null
}

variable "server_name" {
  type    = string
  default = "clawitzer-build"
}

variable "image" {
  type    = string
  default = "ubuntu-24.04"
}

variable "server_type" {
  type    = string
  default = "cx22"
}

resource "hcloud_ssh_key" "default" {
  count      = length(var.ssh_public_key) > 0 ? 1 : 0
  name       = "clawitzer-default"
  public_key = var.ssh_public_key
}

variable "ssh_public_key" {
  type    = string
  default = ""
}

resource "hcloud_server" "main" {
  name        = var.server_name
  image       = var.image
  server_type = var.server_type
  location    = "fsn1"

  dynamic "ssh_key" {
    for_each = length(var.ssh_public_key) > 0 ? [1] : []
    content {
      name = hcloud_ssh_key.default[0].name
    }
  }
}

output "ipv4_address" {
  value = hcloud_server.main.ipv4_address
}

output "ssh_command" {
  value = "ssh root@${hcloud_server.main.ipv4_address}"
}
