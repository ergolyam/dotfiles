# My Linux Dotfiles

Personal [chezmoi](https://www.chezmoi.io/) configurations for Linux desktops, laptops, and rootless Podman servers.

## Configurations

| Mode | `[data]` settings | Includes | Guide |
| ---- | ----------------- | -------- | ----- |
| Minimal | `profile = "default"` | Fish shell only | — |
| Desktop / Laptop | `profile = "desktop"` or `"laptop"` | Niri, Waybar, Fish, desktop utilities | [Desktop](docs/desktop.md) |
| Mineclonia | `profile = "default"`, `server_type = "mineclonia"` | Luanti, PostgreSQL, backups | [Mineclonia](docs/mineclonia.md) |
| VPN | `profile = "default"`, `server_type = "vpn"` | 3x-ui/Xray, Nginx, ACME, backups | [VPN](docs/vpn.md) |

## Installation

On servers, complete the [host preparation](docs/server.md) before applying dotfiles. Run chezmoi as the dedicated service user.

```sh
sh -c "$(wget -qO- get.chezmoi.io/lb)" -- init ergolyam
```

Edit `~/.config/chezmoi/chezmoi.toml` to select a mode (see the guides), then apply:
```sh
chezmoi apply
```

## `chezmoi.toml`

`chezmoi init` renders `home/.chezmoi.toml.tmpl` into the local config, usually `~/.config/chezmoi/chezmoi.toml`. It is not committed to this repository.

The initial `[data]` section contains `profile = "default"` (Fish only). Set `profile` for desktops or add `server_type` for servers; VPN also requires `domain`. Desktop options and server setup are documented in the guides above.
