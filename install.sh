#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$BASH_SOURCE")")

echo "Script dir: $SCRIPT_DIR"

# Создание необходимых директорий, если они не существуют
echo "Create dir's."
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/dunst
mkdir -p ~/.config/kitty
mkdir -p ~/.config/wlogout
mkdir -p ~/.config/wofi
mkdir -p ~/.config/fish
mkdir -p ~/.config/opensd/profiles

# Создание символических ссылок для файлов и директорий

echo "Create symlinks for hyprland."
ln -sf $SCRIPT_DIR/hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
ln -sf $SCRIPT_DIR/hyprland/hyprpaper.conf ~/.config/hypr/hyprpaper.conf
ln -sf $SCRIPT_DIR/hyprland/wallapaper.png ~/.config/hypr/wallapaper.png
ln -sf $SCRIPT_DIR/hyprland/keys.conf ~/.config/hypr/keys.conf
ln -sf $SCRIPT_DIR/hyprland/monitors.conf ~/.config/hypr/monitors.conf
ln -sf $SCRIPT_DIR/hyprland/startup.conf ~/.config/hypr/startup.conf
ln -sf $SCRIPT_DIR/hyprland/wm.conf ~/.config/hypr/wm.conf
ln -sf $SCRIPT_DIR/hyprland/wmrules.conf ~/.config/hypr/wmrules.conf
ln -sf $SCRIPT_DIR/hyprland/plugins ~/.config/hypr/plugins
ln -sf $SCRIPT_DIR/hyprland/record_screen.sh ~/.config/hypr/record_screen.sh
ln -sf $SCRIPT_DIR/hyprland/set_workspace.sh ~/.config/hypr/set_workspace.sh
ln -sf $SCRIPT_DIR/hyprland/toggle_overview_mode.sh ~/.config/hypr/toggle_overview_mode.sh
ln -sf $SCRIPT_DIR/hyprland/set_scroller_mode.sh ~/.config/hypr/set_scroller_mode.sh
ln -sf $SCRIPT_DIR/hyprland/screenshot.sh ~/.config/hypr/screenshot.sh

echo "Create symlinks for waybar."
ln -sf $SCRIPT_DIR/waybar/config ~/.config/waybar/config
ln -sf $SCRIPT_DIR/waybar/ethernet.sh ~/.config/waybar/ethernet.sh
ln -sf $SCRIPT_DIR/waybar/modules ~/.config/waybar/modules
ln -sf $SCRIPT_DIR/waybar/style.css ~/.config/waybar/style.css
ln -sf $SCRIPT_DIR/waybar/wifi.sh ~/.config/waybar/wifi.sh
ln -sf $SCRIPT_DIR/waybar/network_status.sh ~/.config/waybar/network_status.sh
ln -sf $SCRIPT_DIR/waybar/usd_rate.sh ~/.config/waybar/usd_rate.sh
ln -sf $SCRIPT_DIR/waybar/status_scroller_mode.sh ~/.config/waybar/status_scroller_mode.sh
ln -sf $SCRIPT_DIR/waybar/wttr.sh ~/.config/waybar/wttr.sh

echo "Create symlinks for dunst."
ln -sf $SCRIPT_DIR/dunst/dunstrc ~/.config/dunst/dunstrc
ln -sf $SCRIPT_DIR/dunst/battery_check.sh ~/.config/dunst/battery_check.sh
ln -sf $SCRIPT_DIR/dunst/battery_low.mp3 ~/.config/dunst/battery_low.mp3
ln -sf $SCRIPT_DIR/dunst/battery_full.ogg ~/.config/dunst/battery_full.ogg

echo "Create symlinks for kitty."
ln -sf $SCRIPT_DIR/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf $SCRIPT_DIR/kitty/newtab_kitty_choice.sh ~/.config/kitty/newtab_kitty_choice.sh

echo "Create symlinks for wlogout."
ln -sf $SCRIPT_DIR/wlogout/layout ~/.config/wlogout

echo "Create symlinks for wofi."
ln -sf $SCRIPT_DIR/wofi/config ~/.config/wofi/config
ln -sf $SCRIPT_DIR/wofi/style.css ~/.config/wofi/style.css
ln -sf $SCRIPT_DIR/wofi/wofi_trans.sh ~/.config/wofi/wofi_trans.sh

echo "Create symlinks for fish."
ln -sf $SCRIPT_DIR/fish/config.fish ~/.config/fish/config.fish

if grep -q "Jupiter" /sys/devices/virtual/dmi/id/product_name; then
    echo "Create symlinks for jupiter"
    rm ~/.config/opensd/config.ini
    ln -sf $SCRIPT_DIR/steamdeck/opensd/config.ini ~/.config/opensd/config.ini
    ln -sf $SCRIPT_DIR/steamdeck/opensd/my.profile ~/.config/opensd/profiles/my.profile
    ln -sf $SCRIPT_DIR/hyprland/monitors_select.sh ~/.config/hypr/monitors_select.sh
    sed -i '/^#exec-once = .*monitors_select\.sh &/ s/^#//; /^#exec-once = .*opensdd &/ s/^#//' $SCRIPT_DIR/hyprland/startup.conf
else
    echo "This is not Jupiter, skipping symlink creation."
fi

echo "Dotfiles have been linked."

