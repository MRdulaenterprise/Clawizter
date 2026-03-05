# Testing Clawitzer in the Cloud

## Preferred providers

- **Hetzner** or **DigitalOcean** for VMs. Use `cloud/` (Terraform or scripts) to create a VM and SSH in.

## Quick stack test (no ISO)

1. Provision an Ubuntu 24.04 VM on Hetzner/DO (see `cloud/README.md`).
2. On the VM, run the same Clawitzer Agent install used in the ISO (e.g. from `distro/scripts/` or `agent/`).
3. SSH in and smoke-test: daemon running, API/UI responding.

## Full OS test (from ISO)

1. Build the ISO (locally or via GitHub Actions remote build).
2. Convert ISO to a disk image and import as a custom image on Hetzner/DO (or use AWS/GCP VM Import if needed).
3. Create a VM from that image; SSH (and optionally VNC/browser to agent UI) to test.

## Constraint

Most clouds do not boot directly from an uploaded ISO. The pipeline should install from the ISO to a virtual disk and export that as an image, or use the provider’s image import (e.g. Hetzner snapshot, DO custom image).
