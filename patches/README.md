# Patches Directory

This directory contains feed modification patches that need to be applied before building.

## patches/feeds-ddns-cloudflare/

Adds Cloudflare DDNS v4 and v6 support to the ddns-scripts package.

**What it does:**
- Removes the `rm cloudflare.com-v4.json` line that intentionally deletes Cloudflare from ddns-scripts-services
- Adds `cloudflare.com-v6.json` installation
- Registers cloudflare.com-v6 in the services_ipv6 list

**Usage:**
```bash
bash patches/feeds-ddns-cloudflare/apply.sh
```

## patches/feeds-footer-version/

Customizes the LuCI footer across all themes to show "by Lean ... for Ungelivable Team".

**Themes modified:**
- luci-theme-bootstrap
- luci-theme-material
- luci-theme-openwrt-2020
- luci-theme-openwrt (openwrt.org)
- luci-theme-design
- luci-theme-argon

**Usage:**
```bash
bash patches/feeds-footer-version/apply.sh
```

## Note

These patches are for feeds (external repositories). After applying, run:
```bash
./scripts/feeds update -a
./scripts/feeds install -a
```
