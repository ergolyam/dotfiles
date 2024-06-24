# My Desktop Linux Configurations

Welcome to my repository for configuration files for various desktop Linux utilities and applications. Here, I store and share my settings for different tools such as Hyprland, Waybar, and more. This repository helps me keep all my configurations in one place and share them with the community.

## Installation and Setup

### Prerequisites

Before configuring Hyprland, ensure you have the following utilities installed:

- **Hyprland**: The Wayland compositor itself.
- **Waybar**: A customizable status bar.
- **Hyprpaper**: A wallpaper manager for Hyprland.
- **nm-applet**: NetworkManager applet for network configuration.
- **blueman-applet**: Bluetooth manager applet.
- **wofi** or **rofi**: Application launchers.
- **Grim** and **slurp**: Screenshot utilities.
- **wl-recorder**: screen recorder.
- **Kitty**: simple OpenGL terminal.
- **amixer**: ALSA mixer for volume control.
- **wlogout**: logout manager for wayland.

### Install Linux

***Download utils***

- **Debian**:
    ```bash
    sudo apt update
    sudo apt install hyprland waybar hyprpaper network-manager-gnome blueman wofi grim slurp alsa-utils wl-recorder kitty
    ```

- **Arch**:
    ```bash
    sudo pacman -S hyprland waybar hyprpaper network-manager-applet blueman wofi grim slurp alsa-utils wl-recorder kitty
    ```

- **Fedora**:
    ```bash
    sudo dnf install hyprland waybar hyprpaper networkmanager-applet blueman wofi grim slurp alsa-utils wl-recorder kitty
    ```

***Create symlinks***

```bash
git clone https://github.com/grisha765/dotfiles.git ~/dotfiles && \
cd ~/dotfiles && bash install.sh
```
