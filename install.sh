#!/bin/bash

# Создание необходимых директорий, если они не существуют
echo "Create dir's."
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/dunst
mkdir -p ~/.config/kitty

# Создание символических ссылок для файлов и директорий

echo "Create symlinks for hyprland."
ln -sf ~/dotfiles/hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
ln -sf ~/dotfiles/hyprland/hyprpaper.conf ~/.config/hypr/hyprpaper.conf
ln -sf ~/dotfiles/hyprland/keys.conf ~/.config/hypr/keys.conf
ln -sf ~/dotfiles/hyprland/monitors.conf ~/.config/hypr/monitors.conf
ln -sf ~/dotfiles/hyprland/startup.conf ~/.config/hypr/startup.conf
ln -sf ~/dotfiles/hyprland/wm.conf ~/.config/hypr/wm.conf
ln -sf ~/dotfiles/hyprland/record_screen.sh ~/.config/hypr/record_screen.sh

echo "Create symlinks for waybar."
ln -sf ~/dotfiles/waybar/config ~/.config/waybar/config
ln -sf ~/dotfiles/waybar/ethernet.sh ~/.config/waybar/ethernet.sh
ln -sf ~/dotfiles/waybar/modules ~/.config/waybar/modules
ln -sf ~/dotfiles/waybar/style.css ~/.config/waybar/style.css
ln -sf ~/dotfiles/waybar/wifi.sh ~/.config/waybar/wifi.sh

echo "Create symlinks for dunst."
ln -sf ~/dotfiles/dunst/dunstrc ~/.config/dunst/dunstrc

echo "Create symlinks for kitty."
ln -sf ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf

echo "Dotfiles have been linked."

