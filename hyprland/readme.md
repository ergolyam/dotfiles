# Hyprland Configuration

This README provides details on configuring Hyprland using a set of configuration files. Each configuration file has a specific purpose and contains settings that help in customizing your Hyprland experience. Below are descriptions and instructions for each configuration file included in this setup.

## Overview

Hyprland is a dynamic tiling Wayland compositor that allows extensive customization. The configuration files included here will help you set up your monitors, key bindings, startup applications, and window manager settings.

## Installation and Setup

## Initial Setup

1. **Clone the Repository**: Clone this repository using `git clone`.
3. **Place the Configuration File**: Place the `config` files in your hyprland configuration directory, typically `~/.config/hypr/`.

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

### Configuration Files

#### 1. `hyprland.conf`

- **Function**: Main configuration file that sources other configuration files.
- **Usage**: Do not modify this file directly. It points to other specific configuration files for modular settings.

#### 2. `monitors.conf`

- **Function**: Configure monitor settings such as resolution, refresh rate, and monitor positioning.
- **Usage**: Adjust settings according to your monitor specifications. Refer to the [Hyprland Monitors Documentation](https://wiki.hyprland.org/Configuring/Monitors/) for more details.

#### 3. `keys.conf`

- **Function**: Define key bindings for launching applications, managing windows, and performing system actions.
- **Usage**: Customize key bindings as per your preferences. Ensure the specified applications (e.g., terminal, file manager) are installed on your system.

#### 4. `startup.conf`

- **Function**: Set environment variables and specify applications to launch at startup.
- **Usage**: Add or remove applications based on your needs. Ensure the applications listed (e.g., waybar, hyprpaper) are installed.

#### 5. `wm.conf`

- **Function**: Configure window manager settings such as input methods, general appearance, and window rules.
- **Usage**: Adjust settings like keyboard layout, gaps, borders, and animations to suit your workflow. Refer to the [Hyprland Variables Documentation](https://wiki.hyprland.org/Configuring/Variables/) for detailed configuration options.

#### 6. `hyprpapper.conf`

- **Function**: Configure the wallpaper settings for Hyprland.
- **Usage**: Specifies the wallpaper to be preloaded and applied to a specific monitor. 

