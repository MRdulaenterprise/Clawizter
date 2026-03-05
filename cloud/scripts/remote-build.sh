#!/usr/bin/env bash
# Run the Clawitzer ISO build on a remote VM (for GitHub Actions or local use).
# Usage: ./remote-build.sh <user@host>
# Requires: repo cloned on host, Cubic or live-build installed on host.
# Env: BUILD_HOST (default from first arg), optionally SSH_KEY path.
set -euo pipefail

REMOTE="${1:-$BUILD_HOST}"
if [[ -z "$REMOTE" ]]; then
  echo "Usage: $0 <user@host>"
  echo "Or set BUILD_HOST=user@host"
  exit 1
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$REPO_ROOT"

echo "Syncing repo to $REMOTE and running build..."
rsync -avz --exclude .git "$REPO_ROOT/" "$REMOTE:clawitzer-build/"
ssh "$REMOTE" "cd clawitzer-build && ./distro/scripts/build-iso.sh"

echo "Build triggered on remote. To fetch ISO, run: scp $REMOTE:clawitzer-build/_build/*.iso ."
