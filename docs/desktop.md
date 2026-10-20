# Desktop / Laptop

Set the following values in `~/.config/chezmoi/chezmoi.toml` before `chezmoi apply`:

```toml
[data]
profile = "desktop" # or "laptop"
init = "systemd"   # or "runit"
install_fonts = true
install_cursor = true
install_bluetui = true
install_cliphist = true
```

| Variable | Values | Purpose |
| -------- | ------ | ------- |
| `profile` | `desktop`, `laptop`, `default` | Selects workstation files; `default` applies Fish only. |
| `init` | `systemd`, `runit` | Selects the systemd Syncthing Quadlet or runit service configs. |
| `install_fonts` | `true`, `false` | Applies bundled fonts. |
| `install_cursor` | `true`, `false` | Applies cursor files and downloads Hackneyed. |
| `install_bluetui` | `true`, `false` | Downloads the x86_64 `bluetui` binary to `~/.local/bin`. |
| `install_cliphist` | `true`, `false` | Downloads the x86_64 `cliphist` binary to `~/.local/bin`. |

The template starts with only `profile = "default"`; additional options are set manually, not prompted during initialization.
