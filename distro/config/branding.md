# Clawitzer branding (Cubic / live system)

When building the ISO, replace or customize:

- **Distribution name**: In the live system, set to "Clawitzer" where the base shows "Linux Mint" or "Ubuntu" (e.g. `/etc/os-release`, installer strings if modified).
- **Wallpaper / theme**: Place Clawitzer assets in `distro/overlay/usr/share/clawitzer/` and reference from Cinnamon or default desktop config.
- **Installer**: Leave base installer (Ubuntu/Mint) unchanged unless we maintain a fork; branding can be limited to name and artwork.

These are applied via Cubic's "Customization" step or by copying from `distro/overlay/` during the build.
