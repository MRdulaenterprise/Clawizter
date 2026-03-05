# Clawitzer Agent – Strategy (Option A)

## Decision

**Option A**: Fork OpenClaw and extend with Spacebot-inspired features. One daemon, one UI, one config surface; no separate OpenClaw or Spacebot applications.

## Feature set (baked in)

### From OpenClaw (primary)

- Messaging: WhatsApp, Telegram, Discord, Slack, Signal, iMessage (as supported by upstream).
- Conversation context and persistence.
- Skills/plugins and browser automation.
- Multi-model swap (GPT-4o, DeepSeek, Llama, etc.).
- systemd daemon; minimal footprint.

### From Spacebot (to add or align)

- **Concurrency**: Multi-user/multi-channel processing without blocking (align with OpenClaw’s architecture or add worker pool).
- **Memory**: Consider graph-style or typed memory later (plugin or companion); initially use OpenClaw’s context.
- **Deployment**: Single logical service; Node app packaged under `/usr/lib/clawitzer/` with one systemd unit.

## Implementation approach

1. **agent/** – Clone or submodule of [openclaw/openclaw](https://github.com/openclaw/openclaw); rebrand as Clawitzer Agent.
2. **Packaging**: Install via distro overlay (or built .deb) into `/usr/lib/clawitzer/`; systemd unit `clawitzer-agent.service` in `distro/overlay/`.
3. **Config**: `/etc/clawitzer/` or `~/.config/clawitzer/`; one setup flow for API keys and channels.
4. **Desktop**: One launcher and (optional) first-run wizard; no separate “OpenClaw” or “Spacebot” UI.
5. **Later**: Port or reimplement Spacebot-style concurrency and graph memory as extensions or a small companion service if needed.

## Dependencies

- Node.js 22+ (distro package or NodeSource in `distro/config/`).
- OpenClaw’s runtime deps (see upstream); no separate Spacebot binary.

## References

- OpenClaw: https://github.com/openclaw/openclaw  
- OpenClaw Linux: https://docs.openclaw.ai/platforms/linux  
- Spacebot: https://github.com/spacedriveapp/spacebot  
