#!/usr/bin/env bash
# Build Clawitzer ISO (Cubic or live-build).
# Run on Ubuntu 24.04 or Linux Mint 22 host (or in a matching container/VM for CI).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$REPO_ROOT"

echo "Clawitzer ISO build – repo root: $REPO_ROOT"

# Check for Cubic or live-build
if command -v cubic &>/dev/null; then
  echo "Cubic is installed. For now run Cubic manually: point it at Linux Mint 22 ISO, then in chroot:"
  echo "  1. Add packages from distro/config/packages.txt"
  echo "  2. Copy distro/overlay/ into the live system"
  echo "  3. Run distro/scripts/install-agent.sh from inside the chroot"
  echo "  4. Use Cubic to generate the ISO."
  echo "Automated Cubic driver can be added here (e.g. using cubic's chroot path)."
  exit 0
fi

if command -v lb &>/dev/null; then
  echo "live-build (lb) found. Configure distro/config/live-build/ and run: lb build"
  echo "Placeholder: create live-build config in distro/config/ and invoke lb build."
  exit 0
fi

echo "Neither Cubic nor live-build found. Install one of:"
echo "  - Cubic: sudo apt install cubic"
echo "  - live-build: sudo apt install live-build"
exit 1
