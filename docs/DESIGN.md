# Clawitzer Linux OS – Design

## Base distribution

- **Recommended**: Linux Mint 22 (Virginia) on Ubuntu 24.04 LTS for Cinnamon and ease-of-use.
- **Alternative**: Ubuntu 24.04 desktop + Cinnamon if we want one fewer derivative to track.
- **Decision**: Linux Mint 22 (documented; can be changed in `distro/config/`).

## Clawitzer Agent strategy

One unified OS service provides all agent capabilities (no separate OpenClaw or Spacebot apps).

### Options

| Option | Base | Pros | Cons |
|--------|------|------|------|
| **A** | Fork [OpenClaw](https://github.com/openclaw/openclaw) (TypeScript/Node) | Rich messaging, skills, browser automation; large ecosystem. Add Spacebot concurrency/memory as extensions or companion service. | Two languages if we add Rust for graph memory; Node runtime on the image. |
| **B** | Fork [Spacebot](https://github.com/spacedriveapp/spacebot) (Rust) | Concurrent multi-user, graph memory, single binary. Port OpenClaw adapters/skills into Rust. | Larger porting effort for messaging and skills. |
| **C** | New unified codebase | Full control; one stack. | Highest effort; reimplement or embed both. |

### Recommended: Option A (fork OpenClaw, extend with Spacebot features)

- Use OpenClaw as the primary daemon and API surface.
- Add Spacebot-inspired concurrency (multi-channel, non-blocking) and optional graph-style memory (as a plugin or companion) in a later phase.
- Package as Node 22+ app in the distro; single systemd unit `clawitzer-agent.service` and one config/UI surface.
- Documented in `docs/agent-strategy.md`; implementation lives in `agent/` (fork or submodule).

## What goes on the ISO

- Base: Linux Mint 22 (or Ubuntu 24.04 + Cinnamon).
- Clawitzer Agent: single daemon from `agent/`, installed under `/usr/lib/clawitzer/`, systemd unit from `distro/overlay/`.
- Runtime: Node.js 22+ (for Option A).
- UI: Cinnamon from base; Clawitzer theme, wallpaper, and one "Clawitzer Agent" launcher in `distro/overlay/`.
- First-run: one setup wizard/desktop entry for API keys and channels.

## Build and test workflow

- **Edit**: Cursor (configs, scripts, themes, `agent/`).
- **Version control**: GitHub.
- **Build ISO**: GitHub Actions + remote build (workflow triggers Hetzner/DO VM or self-hosted runner, runs `distro/scripts/build-iso.sh`, uploads artifact).
- **Test**: Hetzner or DigitalOcean VMs via `cloud/` (Terraform or scripts); SSH for interactive testing.

## Repo layout

- `distro/` – config, overlay, scripts for the ISO build.
- `agent/` – Clawitzer Agent codebase (OpenClaw fork/extend per Option A).
- `cloud/` – Terraform or scripts for Hetzner/DO (and optional AWS/GCP).
- `.github/workflows/` – Actions for remote ISO build.
- `docs/` – this design, runbooks, and decisions.
