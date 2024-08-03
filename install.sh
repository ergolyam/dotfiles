#!/bin/bash

# Создание необходимых директорий, если они не существуют
echo "Create dir's."
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/dunst
mkdir -p ~/.config/kitty
mkdir -p ~/.config/wlogout
mkdir -p ~/.config/wofi
mkdir -p ~/.config/fish

# Создание символических ссылок для файлов и директорий

echo "Create symlinks for hyprland."
ln -sf ~/dotfiles/hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
ln -sf ~/dotfiles/hyprland/hyprpaper.conf ~/.config/hypr/hyprpaper.conf
ln -sf ~/dotfiles/hyprland/keys.conf ~/.config/hypr/keys.conf
ln -sf ~/dotfiles/hyprland/monitors.conf ~/.config/hypr/monitors.conf
ln -sf ~/dotfiles/hyprland/startup.conf ~/.config/hypr/startup.conf
ln -sf ~/dotfiles/hyprland/wm.conf ~/.config/hypr/wm.conf
ln -sf ~/dotfiles/hyprland/wmrules.conf ~/.config/hypr/wmrules.conf
ln -sf ~/dotfiles/hyprland/record_screen.sh ~/.config/hypr/record_screen.sh
ln -sf ~/dotfiles/hyprland/monitors_select.sh ~/.config/hypr/monitors_select.sh

echo "Create symlinks for waybar."
ln -sf ~/dotfiles/waybar/config ~/.config/waybar/config
ln -sf ~/dotfiles/waybar/ethernet.sh ~/.config/waybar/ethernet.sh
ln -sf ~/dotfiles/waybar/modules ~/.config/waybar/modules
ln -sf ~/dotfiles/waybar/style.css ~/.config/waybar/style.css
ln -sf ~/dotfiles/waybar/wifi.sh ~/.config/waybar/wifi.sh
ln -sf ~/dotfiles/waybar/network_status.sh ~/.config/waybar/network_status.sh
ln -sf ~/dotfiles/waybar/usd_rate.sh ~/.config/waybar/usd_rate.sh

echo "Create symlinks for dunst."
ln -sf ~/dotfiles/dunst/dunstrc ~/.config/dunst/dunstrc

echo "Create symlinks for kitty."
ln -sf ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf

echo "Create symlinks for wlogout."
ln -sf ~/dotfiles/wlogout/layout ~/.config/wlogout

echo "Create symlinks for wofi."
ln -sf ~/dotfiles/wofi/style.css ~/.config/wofi/style.css

echo "Create symlinks for fish."
ln -sf ~/dotfiles/fish/config.fish ~/.config/fish/config.fish

echo "Dotfiles have been linked."

