# Clawitzer Linux OS

A full installable Linux distribution (bootable ISO) based on Ubuntu/Linux Mint, with a single unified **Clawitzer Agent** OS service: all [OpenClaw](https://github.com/openclaw/openclaw) features plus the best of [Spacebot](https://github.com/spacedriveapp/spacebot) (concurrent multi-user, graph memory), baked into the OS with a Mint-like ease-of-use UI.

## What is Clawitzer?

- **One OS**: Bootable Linux (derivative of Linux Mint / Ubuntu + Cinnamon).
- **One agent**: Clawitzer Agent — a single system daemon (no separate OpenClaw or Spacebot apps). Messaging (WhatsApp, Telegram, Discord, Slack, etc.), skills, browser automation, multi-model AI, and Spacebot-style concurrency and memory.
- **Workflow**: Edit in Cursor → version control on GitHub → build ISO in the cloud (GitHub Actions + Hetzner/DO) → test on VMs via SSH.

## Repo layout

| Path | Purpose |
|------|---------|
| **docs/** | Design, agent strategy, build and test runbooks |
| **distro/** | ISO build: config, overlay (systemd, launcher, theme), scripts |
| **agent/** | Clawitzer Agent (OpenClaw-based unified daemon) |
| **cloud/** | Terraform (Hetzner, DigitalOcean) and remote-build scripts |
| **.github/workflows/** | GitHub Actions (ISO build via remote build) |

## Quick start

- [Design and base choices](docs/DESIGN.md)
- [Agent strategy](docs/agent-strategy.md)
- [Building the ISO](docs/BUILD.md)
- [Testing in the cloud](docs/TEST-CLOUD.md)

## Building the ISO

1. **Host**: Ubuntu 24.04 or Linux Mint 22.
2. Install [Cubic](https://launchpad.net/cubic) or live-build.
3. Run `./distro/scripts/build-iso.sh` or use the Cubic GUI with a Linux Mint 22 ISO.
4. **Automated**: Add `BUILD_HOST` and `BUILD_SSH_KEY` repo secrets; the GitHub Actions workflow will SSH to your Hetzner/DO VM, build the ISO, and upload it as an artifact.

## Cloud testing

- Use **cloud/terraform/hetzner/** or **cloud/terraform/digitalocean/** to provision VMs.
- SSH in to test the Clawitzer Agent stack or a full Clawitzer OS image.

## License

Clawitzer overlay, scripts, and agent stub are part of this project. [OpenClaw](https://github.com/openclaw/openclaw) and [Spacebot](https://github.com/spacedriveapp/spacebot) have their own licenses when used.
