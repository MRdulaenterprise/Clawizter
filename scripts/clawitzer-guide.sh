#!/usr/bin/env bash
# Clawitzer – terminal user guide. Run: ./scripts/clawitzer-guide.sh

set -e
GUIDE_WIDTH=70

# Colors (disable if not a TTY or NO_COLOR)
if [[ -t 1 ]] && [[ -z "${NO_COLOR:-}" ]]; then
  C_HEAD=$(tput setaf 6 2>/dev/null || true)    # cyan
  C_STEP=$(tput setaf 2 2>/dev/null || true)   # green
  C_CMD=$(tput setaf 3 2>/dev/null || true)    # yellow
  C_RESET=$(tput sgr0 2>/dev/null || true)
else
  C_HEAD= C_STEP= C_CMD= C_RESET=
fi

line() { printf '%*s\n' "$GUIDE_WIDTH" '' | tr ' ' '='; }
box()  { echo "========================================"; echo "  $1"; echo "========================================"; }

echo ""
box "Clawitzer Linux OS - Quick start guide"
echo ""
echo "${C_HEAD}► What you need${C_RESET}"
line
echo "  • DigitalOcean account (digitalocean.com)"
echo "  • A terminal (this one is fine)"
echo ""
echo "${C_HEAD}► Step 1 – Create a Droplet (one-time)${C_RESET}"
line
echo "  1. Go to: cloud.digitalocean.com → Create → Droplets"
echo "  2. Image: Ubuntu 24.04  |  Plan: Basic \$6/mo (1 GB) or 2 GB for full OpenClaw"
echo "  3. Authentication: Password (you’ll get root password by email)"
echo "  4. Create Droplet → copy its IP address (e.g. 143.198.229.30)"
echo ""
echo "${C_HEAD}► Step 2 – SSH into the Droplet${C_RESET}"
line
echo "  From your Mac (replace YOUR_IP with the Droplet IP):"
echo ""
echo "  ${C_CMD}  ssh root@YOUR_IP${C_RESET}"
echo ""
echo "  Enter the password from DigitalOcean’s email when prompted."
echo ""
echo "${C_HEAD}► Step 3 – Run these on the Droplet (copy & paste)${C_RESET}"
line
echo "  ${C_STEP}Block 1 – Install Node.js 22${C_RESET}"
echo "  ${C_CMD}curl -fsSL https://deb.nodesource.com/setup_22.x | bash -${C_RESET}"
echo "  ${C_CMD}apt-get install -y nodejs${C_RESET}"
echo ""
echo "  ${C_STEP}Block 2 – Clone Clawitzer and install agent${C_RESET}"
echo "  ${C_CMD}git clone https://github.com/MRdulaenterprise/Clawizter.git /opt/clawitzer${C_RESET}"
echo "  ${C_CMD}cd /opt/clawitzer${C_RESET}"
echo "  ${C_CMD}cp -a /opt/clawitzer/distro/overlay/etc/* /${C_RESET}"
echo "  ${C_CMD}cp -a /opt/clawitzer/distro/overlay/usr/* /usr/${C_RESET}"
echo "  ${C_CMD}mkdir -p /usr/lib/clawitzer && cp -a /opt/clawitzer/agent/* /usr/lib/clawitzer/${C_RESET}"
echo "  ${C_CMD}cd /usr/lib/clawitzer && npm install --omit=dev${C_RESET}"
echo ""
echo "  ${C_STEP}Block 3 – Start the agent and test${C_RESET}"
echo "  ${C_CMD}node /usr/lib/clawitzer/lib/daemon.js &${C_RESET}"
echo "  ${C_CMD}sleep 2 && curl -s http://127.0.0.1:19898/${C_RESET}"
echo ""
echo "  You should see JSON with \"name\":\"Clawitzer Agent\"."
echo ""
echo "${C_HEAD}► Step 4 – Open in your browser (from your Mac)${C_RESET}"
line
echo "  In a ${C_STEP}new${C_RESET} terminal on your Mac, run (replace YOUR_IP):"
echo ""
echo "  ${C_CMD}  ssh -L 19898:127.0.0.1:19898 root@YOUR_IP${C_RESET}"
echo ""
echo "  Leave that window open. Then in your browser open:"
echo ""
echo "  ${C_CMD}  http://127.0.0.1:19898${C_RESET}"
echo ""
echo "${C_HEAD}► Optional – Full OpenClaw (needs 2 GB Droplet)${C_RESET}"
line
echo "  On the Droplet:"
echo "  ${C_CMD}cd /usr/lib/clawitzer && npm install openclaw@latest --save${C_RESET}"
echo "  ${C_CMD}pkill -f 'node.*daemon.js'; node /usr/lib/clawitzer/lib/daemon.js &${C_RESET}"
echo ""
echo "  Reload http://127.0.0.1:19898 in your browser for the full UI."
echo ""
line
echo "  More: docs/DIGITALOCEAN-SETUP.md  |  README.md"
echo ""
