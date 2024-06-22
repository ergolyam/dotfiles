# Hyprland Configuration

This README provides details on configuring Hyprland using a set of configuration files. Each configuration file has a specific purpose and contains settings that help in customizing your Hyprland experience. Below are descriptions and instructions for each configuration file included in this setup.

## Overview

Hyprland is a dynamic tiling Wayland compositor that allows extensive customization. The configuration files included here will help you set up your monitors, key bindings, startup applications, and window manager settings.

### Install Linux

***Download configs***

```bash
mkdir -p ~/.config/hypr && \
wget -O ~/.config/hypr/hyprland.conf https://raw.githubusercontent.com/grisha765/my_desktop/main/hyprland/hyprland.conf && \
wget -O ~/.config/hypr/hyprpaper.conf https://raw.githubusercontent.com/grisha765/my_desktop/main/hyprland/hyprpaper.conf && \
wget -O ~/.config/hypr/keys.conf https://raw.githubusercontent.com/grisha765/my_desktop/main/hyprland/keys.conf && \
wget -O ~/.config/hypr/monitors.conf https://raw.githubusercontent.com/grisha765/my_desktop/main/hyprland/monitors.conf && \
wget -O ~/.config/hypr/startup.conf https://raw.githubusercontent.com/grisha765/my_desktop/main/hyprland/startup.conf && \
wget -O ~/.config/hypr/wm.conf https://raw.githubusercontent.com/grisha765/my_desktop/main/hyprland/wm.conf && \
wget -O ~/.config/hypr/record_screen.sh https://raw.githubusercontent.com/grisha765/my_desktop/main/hyprland/record_screen.sh
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

