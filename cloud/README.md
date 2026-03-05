# Cloud – VM provisioning for Clawitzer

Use **Hetzner** or **DigitalOcean** for interactive testing (SSH). AWS/GCP optional for image import later.

## Terraform

- **terraform/hetzner/** – Hetzner Cloud server (Ubuntu 24.04). Set `HCLOUD_TOKEN` and optionally `TF_VAR_ssh_public_key`; run `terraform init && terraform apply`.
- **terraform/digitalocean/** – DigitalOcean Droplet (Ubuntu 24.04). Set `TF_VAR_do_token` and optionally `TF_VAR_ssh_key_ids`; run `terraform init && terraform apply`.

Outputs: `ipv4_address`, `ssh_command`. SSH in and run the Clawitzer Agent install or use for remote ISO build.

## GitHub Actions remote build

1. Create a VM (Hetzner or DO) with Ubuntu 24.04; install Cubic (or live-build) and Node 22+.
2. Add repo secrets: **BUILD_HOST** = `user@ip`, **BUILD_SSH_KEY** = private key contents.
3. The workflow `.github/workflows/build-iso.yml` runs the **remote-build** job when those secrets exist: it rsyncs the repo, runs `distro/scripts/build-iso.sh` on the VM, and uploads `_build/` as artifact `clawitzer-iso-remote`.

Alternatively run **cloud/scripts/remote-build.sh** locally: `./cloud/scripts/remote-build.sh user@host`.

## Manual testing

- **Quick stack test**: Provision Ubuntu 24.04 VM, SSH in, clone repo (or copy agent/ + distro/scripts), run agent install and smoke-test.
- **Full OS test**: Build ISO (locally or via remote-build), convert to image, import to Hetzner/DO, boot VM and test.
