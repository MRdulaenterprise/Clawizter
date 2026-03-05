# Building the Clawitzer ISO

## Prerequisites

- Host: Ubuntu 24.04 or Linux Mint 22 (same or newer than target base).
- [Cubic](https://launchpad.net/cubic) (for GUI) or live-build for scripted builds.
- Linux Mint 22 ISO (or Ubuntu 24.04 desktop ISO) as the source image.

## Quick start (Cubic)

1. Install Cubic: `sudo apt install cubic`
2. Start Cubic and select the Linux Mint 22 (or Ubuntu 24.04) desktop ISO.
3. In the chroot:
   - Add packages (Node 22+, and any in `distro/config/packages.txt`).
   - Copy `distro/overlay/` contents into the live system.
   - Run `distro/scripts/install-agent.sh` (or equivalent) to register the Clawitzer Agent.
4. Use Cubic’s “Generate” step to produce the Clawitzer ISO.

## Scripted build

Run from repo root:

```bash
./distro/scripts/build-iso.sh
```

This script is intended to be run on an Ubuntu 24.04 / Mint 22 host or inside a matching container/VM. It will use Cubic’s chroot or live-build (see script) to produce `Clawitzer-*.iso`.

## GitHub Actions (remote build)

The workflow in `.github/workflows/build-iso.yml` triggers a build on a Hetzner or DigitalOcean VM (or self-hosted runner), runs `build-iso.sh`, and uploads the ISO as an artifact or Release. See the workflow file and `cloud/` for VM setup.
