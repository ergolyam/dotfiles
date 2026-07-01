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
    wm = "niri"
    terminal = "alacritty"
    notifications = "mako"
    launcher = "fuzzel"
    install_fonts = true
    install_cursor = true
    ```

- These values control `home/.chezmoiignore.tmpl`, so only the relevant files are applied on a given machine.
    - `profile` selects the main setup type. `desktop` applies the desktop configuration. `server` keeps only the Fish shell configuration.
    - `wm` selects the window manager configs to keep. Supported values are `niri` and `hypr`.
    - `terminal` selects terminal-related configs. `alacritty` keeps Alacritty and tmux files. `kitty` keeps Kitty files.
    - `notifications` selects the notification daemon configs. Supported values are `mako` and `dunst`.
    - `launcher` selects the launcher configs. Supported values are `fuzzel` and `wofi`.
    - `install_fonts` controls whether files from `.local/share/fonts` are applied.
    - `install_cursor` controls whether the Hackneyed cursor theme is downloaded and `~/.local/share/icons/default` points to it.

- You can edit `~/.config/chezmoi/chezmoi.toml` manually after initialization and then re-run:
    ```sh
    chezmoi apply
    ```
