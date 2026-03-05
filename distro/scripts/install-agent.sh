#!/usr/bin/env bash
# Register Clawitzer Agent in the live system (run inside Cubic chroot or after overlay copy).
# Copies overlay (systemd, config, launcher) and installs agent tree to /usr/lib/clawitzer.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
OVERLAY="$REPO_ROOT/distro/overlay"
AGENT_SRC="$REPO_ROOT/agent"
AGENT_DEST="/usr/lib/clawitzer"

# Copy overlay into current root (chroot or real root)
if [[ -d "$OVERLAY/etc" ]]; then
  cp -a "$OVERLAY/etc/"* /
fi
if [[ -d "$OVERLAY/usr" ]]; then
  cp -a "$OVERLAY/usr/"* /usr/
fi

# Install agent tree so systemd can run it
if [[ -d "$AGENT_SRC" ]] && [[ -f "$AGENT_SRC/package.json" ]]; then
  mkdir -p "$(dirname "$AGENT_DEST")"
  cp -a "$AGENT_SRC"/* "$AGENT_DEST/"
  if command -v npm &>/dev/null; then
    (cd "$AGENT_DEST" && npm install --omit=dev) || true
  fi
fi

# Enable service if systemd is available
if command -v systemctl &>/dev/null; then
  systemctl enable clawitzer-agent.service 2>/dev/null || true
fi

echo "Clawitzer Agent overlay applied and service enabled (if systemd present)."
