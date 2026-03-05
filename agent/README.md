# Clawitzer Agent

Unified OS agent service: OpenClaw features + Spacebot-inspired concurrency/memory (Option A – fork OpenClaw, extend).

## Strategy

See `docs/agent-strategy.md`. This directory holds:

- A fork or clone of [openclaw/openclaw](https://github.com/openclaw/openclaw), rebranded as Clawitzer Agent, **or**
- A submodule pointing at a Clawitzer fork of OpenClaw.

## Build and install

- Requires Node.js 22+.
- Install into `/usr/lib/clawitzer/` when building the distro (see `distro/overlay` and `distro/scripts/install-agent.sh`).
- systemd unit: `clawitzer-agent.service` (provided in `distro/overlay/`).

## Initial setup

To populate this directory with OpenClaw-based code:

```bash
git clone https://github.com/openclaw/openclaw.git .
# Rebrand, then add Spacebot-inspired concurrency/memory in a later phase.
```

Or add OpenClaw as a submodule and wrap it with a small Clawitzer launcher and config under `/etc/clawitzer/`.
