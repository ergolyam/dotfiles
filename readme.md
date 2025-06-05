# My Desktop Linux Configurations

Welcome to my repository for configuration files for various desktop Linux utilities and applications. Here, I store and share my settings for different tools such as Hyprland, Waybar, and more. This repository helps me keep all my configurations in one place and share them with the community.

## Installation and Setup

### Prerequisites

Before configuring Hyprland, ensure you have the following utilities installed:

- **[niri](https://github.com/YaLTeR/niri)**: `(Main)` A scrollable-tiling Wayland compositor.
- **[hyprland](https://github.com/hyprwm/Hyprland)**: (Second) A independent tiling Wayland compositor.
- **[mako](https://github.com/emersion/mako)**: `(Main)` A lightweight Wayland notification daemon.
- **[dunst](https://github.com/dunst-project/dunst)**: (Second) Lightweight and customizable notification daemon.
- **[waybar](https://github.com/Alexays/Waybar)**: A customizable status bar.
- **[swaybg](https://github.com/swaywm/swaybg)**: `(Main)` Wallpaper tool for Wayland compositors.
- **[hyprpaper](https://github.com/hyprwm/hyprpaper)**: (Second) A wallpaper manager for Hyprland.
- **[nmtui](https://github.com/NetworkManager/NetworkManager/tree/main/src/nmtui)**: NetworkManager terminal ncurses ui for network configuration.
- **[wofi](https://hg.sr.ht/~scoopta/wofi)**: Launcher/menu program for wlroots based wayland compositors.
- **[grim](https://sr.ht/~emersion/grim)** and **[slurp](https://github.com/emersion/slurp)**: Screenshot utilities.
- **[alacritty](https://github.com/alacritty/alacritty)**: `(Main)` A cross-platform, OpenGL terminal emulator.
- **[tmux](https://github.com/tmux/tmux)**: A terminal multiplexer.
- **[kitty](https://github.com/kovidgoyal/kitty)**: Simple OpenGL terminal.
- **[wlogout](https://github.com/ArtsyMacaw/wlogout)**: Logout manager for wayland.
- **[bluetui](https://github.com/pythops/bluetui)**: Simple bluetooth tui manager.
- **[translate-shell](https://github.com/soimort/translate-shell)**: Command-line translator.

### Plugins

- **[hyprscroller](https://github.com/dawsers/hyprscroller)**: Layout plugin that creates a window layout similar to [PaperWM](https://github.com/paperwm/PaperWM).

## Installation Script

This repository includes a flexible installation script that allows you to selectively install only the components you need using flags.

### Full Installation

- Create symlinks (Dev Installation):
    ```bash
    git clone https://github.com/grisha765/dotfiles.git ~/dotfiles && \
    cd ~/dotfiles && bash install.sh
    ```

- Download configs from raw GitHub (User Installation):
    ```bash
    curl -Ls https://dub.sh/grisha765 | bash -s
    ```

This installs all available configs (Hyprland, Waybar, Dunst, Kitty, Wlogout, Wofi, Fish, Fonts).

### Selective Installation

- You can install specific configs by passing arguments to the script:
    ```bash
    bash install.sh --fish            # Only install fish config
    bash install.sh --hypr --kitty    # Install Hyprland and Kitty configs
    bash install.sh --fonts           # Install only fonts
    ```

### Available Flags

```bash
bash install --help
```

## Notes

- If you're using the script inside a git repository, it will create symlinks.
- If you're running it outside a git repo (e.g. from raw GitHub), it will download files directly using `wget`.

