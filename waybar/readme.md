# Waybar Configuration

This README provides details on configuring Waybar using a set of configuration files. Each configuration file has a specific purpose and contains settings that help in customizing your Waybar experience. Below are descriptions and instructions for each configuration file included in this setup.

## Overview

Waybar is a highly customizable status bar for Wayland compositors. The configuration files included here will help you set up the modules, styling, and behavior of Waybar to suit your preferences.

### Install Linux

***Download configs***

```bash
mkdir -p ~/.config/waybar && \
wget -O ~/.config/waybar/config https://raw.githubusercontent.com/grisha765/dotfiles/main/waybar/config && \
wget -O ~/.config/waybar/style.css https://raw.githubusercontent.com/grisha765/dotfiles/main/waybar/style.css && \
wget -O ~/.config/waybar/modules https://raw.githubusercontent.com/grisha765/dotfiles/main/waybar/modules && \
wget -O ~/.config/waybar/wifi.sh https://raw.githubusercontent.com/grisha765/dotfiles/main/waybar/wifi.sh && chmod +x ~/.config/waybar/wifi.sh && \
wget -O ~/.config/waybar/network_status.sh https://raw.githubusercontent.com/grisha765/dotfiles/main/waybar/network_status.sh && chmod +x ~/.config/waybar/network_status.sh
```

### Configuration Files

#### 1. `config`

- **Function**: Main configuration file for Waybar.
- **Usage**: Defines the structure and placement of modules in the Waybar.
- **Details**:
  - Includes module definitions and their positions (left, center, right) in the bar.

#### 2. `modules`

- **Function**: Defines individual modules used by Waybar.
- **Usage**: Customize the behavior and appearance of Waybar modules.
- **Details**:
  - Contains settings for workspace display, language, audio control, separators, and logout functionality.

#### 3. `style.css`

- **Function**: CSS file to style Waybar.
- **Usage**: Customize the appearance of Waybar elements.
- **Details**:
  - Sets background and text colors, font, padding, and styles for active workspace buttons.
