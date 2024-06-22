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

***Download all configs***

```bash
mkdir -p ~/.config/hypr && mkdir -p ~/.config/waybar && mkdir -p ~/.config/dunst && \
wget -O ~/.config/hypr/hyprland.conf https://raw.githubusercontent.com/grisha765/dotfiles/main/hyprland/hyprland.conf && \
wget -O ~/.config/hypr/hyprpaper.conf https://raw.githubusercontent.com/grisha765/dotfiles/main/hyprland/hyprpaper.conf && \
wget -O ~/.config/hypr/keys.conf https://raw.githubusercontent.com/grisha765/dotfiles/main/hyprland/keys.conf && \
wget -O ~/.config/hypr/monitors.conf https://raw.githubusercontent.com/grisha765/dotfiles/main/hyprland/monitors.conf && \
wget -O ~/.config/hypr/startup.conf https://raw.githubusercontent.com/grisha765/dotfiles/main/hyprland/startup.conf && \
wget -O ~/.config/hypr/wm.conf https://raw.githubusercontent.com/grisha765/dotfiles/main/hyprland/wm.conf && \
wget -O ~/.config/hypr/record_screen.sh https://raw.githubusercontent.com/grisha765/dotfiles/main/hyprland/record_screen.sh && chmod +x ~/.config/hypr/record_screen.sh && \
wget -O ~/.config/waybar/config https://raw.githubusercontent.com/grisha765/dotfiles/main/waybar/config && \
wget -O ~/.config/waybar/style.css https://raw.githubusercontent.com/grisha765/dotfiles/main/waybar/style.css && \
wget -O ~/.config/waybar/modules https://raw.githubusercontent.com/grisha765/dotfiles/main/waybar/modules && \
wget -O ~/.config/waybar/wifi.sh https://raw.githubusercontent.com/grisha765/dotfiles/main/waybar/wifi.sh && chmod +x ~/.config/waybar/wifi.sh && \
wget -O ~/.config/waybar/network_status.sh https://raw.githubusercontent.com/grisha765/dotfiles/main/waybar/network_status.sh && chmod +x ~/.config/waybar/network_status.sh && \
wget -O ~/.config/dunst/dunstrc https://raw.githubusercontent.com/grisha765/dotfiles/main/dunst/dunstrc && \
wget -O ~/.config/kitty/kitty.conf https://raw.githubusercontent.com/grisha765/dotfiles/main/kitty/kitty.conf
```
