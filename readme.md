# My Desktop Linux Configurations

Welcome to my repository for configuration files for various desktop Linux utilities and applications.

## Installation

### Apply dotfiles

```sh
sh -c "$(wget -qO- get.chezmoi.io/lb)" -- init --apply ergolyam
```

## `chezmoi.toml`

During `chezmoi init`, chezmoi renders `home/.chezmoi.toml.tmpl` into the local chezmoi config file, usually `~/.config/chezmoi/chezmoi.toml`. This file is not committed to the repository. It stores machine-specific choices that templates can read later.

- The current template asks for a `profile` once and writes the selected values to the `[data]` section:
    ```toml
    [data]
    profile = "desktop"
    init = "runit"
    install_fonts = true
    install_cursor = true
    install_bluetui = true
    install_cliphist = true
    ```

- The following `[data]` values control what gets applied on a given machine:

| Variable | Values | Description |
| -------- | ------ | ----------- |
| `profile` | `default`, `desktop`, `laptop` | Selects desktop, laptop files or default fish-only files. |
| `init` | `runit`, `systemd` | Selects service manager configs. |
| `install_fonts` | `true`, `false` | Applies bundled fonts. |
| `install_cursor` | `true`, `false` | Applies icons/cursors and downloads Hackneyed. |
| `install_bluetui` | `true`, `false` | Downloads the x86_64 binary file `bluetui` and saves it to `~/.local/bin` |
| `install_cliphist` | `true`, `false` | Downloads the x86_64 binary file `cliphist` and saves it to `~/.local/bin` |

- You can edit `~/.config/chezmoi/chezmoi.toml` manually after initialization and then re-run:
    ```sh
    chezmoi apply
    ```
