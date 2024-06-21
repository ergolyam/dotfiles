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
- **amixer**: ALSA mixer for volume control.

### Install Linux

***Download utils***

- **Debian**:
    ```bash
    sudo apt update
    sudo apt install hyprland waybar hyprpaper network-manager-gnome blueman wofi grim slurp alsa-utils
    ```

- **Arch**:
    ```bash
    sudo pacman -S hyprland waybar hyprpaper network-manager-applet blueman wofi grim slurp alsa-utils
    ```

- **Fedora**:
    ```bash
    sudo dnf install hyprland waybar hyprpaper networkmanager-applet blueman wofi grim slurp alsa-utils
    ```

***Download all configs***

```bash
mkdir -p ~/.config/hypr && mkdir -p ~/.config/waybar && mkdir -p ~/.config/dunst && \
wget -O ~/.config/hypr/hyprland.conf https://raw.githubusercontent.com/grisha765/my_desktop/main/hyprland/hyprland.conf && \
wget -O ~/.config/hypr/hyprpaper.conf https://raw.githubusercontent.com/grisha765/my_desktop/main/hyprland/hyprpaper.conf && \
wget -O ~/.config/hypr/keys.conf https://raw.githubusercontent.com/grisha765/my_desktop/main/hyprland/keys.conf && \
wget -O ~/.config/hypr/monitors.conf https://raw.githubusercontent.com/grisha765/my_desktop/main/hyprland/monitors.conf && \
wget -O ~/.config/hypr/startup.conf https://raw.githubusercontent.com/grisha765/my_desktop/main/hyprland/startup.conf && \
wget -O ~/.config/hypr/wm.conf https://raw.githubusercontent.com/grisha765/my_desktop/main/hyprland/wm.conf && \
wget -O ~/.config/waybar/config https://raw.githubusercontent.com/grisha765/my_desktop/main/waybar/config && \
wget -O ~/.config/waybar/style.css https://raw.githubusercontent.com/grisha765/my_desktop/main/waybar/style.css && \
wget -O ~/.config/waybar/modules https://raw.githubusercontent.com/grisha765/my_desktop/main/waybar/modules && \
wget -O ~/.config/dunst/dunstrc https://raw.githubusercontent.com/grisha765/my_desktop/main/dunst/dunstrc
```
