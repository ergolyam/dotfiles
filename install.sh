#!/usr/bin/env bash

script_dir=$(dirname "$(realpath "$BASH_SOURCE")")
base_config="$HOME/.config"
base_url="https://raw.githubusercontent.com/grisha765/dotfiles/main"

echo "Script dir: $script_dir"

echo "Create dir's."
config_dirs=(
  "hypr"
  "waybar"
  "dunst"
  "kitty"
  "wlogout"
  "wofi"
  "fish"
  "opensd/profiles"
  )
for i in "${config_dirs[@]}"; do
  mkdir -pv $base_config/${i}
done
mkdir -pv ~/.local/share/fonts

echo "Create symlinks for hyprland."
hypr_files=(
  "hyprland.conf"
  "hyprpaper.conf"
  "wallapaper.png"
  "keys.conf"
  "monitors.conf"
  "startup.conf"
  "wm.conf"
  "wmrules.conf"
  "plugins"
  "record_screen.sh"
  "set_workspace.sh"
  "toggle_overview_mode.sh"
  "set_scroller_mode.sh"
  "screenshot.sh"
  )
for i in "${hypr_files[@]}"; do
  if [ -d "$script_dir/.git" ]; then
    ln -sfv $script_dir/hyprland/${i} $base_config/hypr/${i}
  else
    wget -O $base_config/hypr/${i} $base_url/hyprland/${i}
  fi
done

echo "Create symlinks for waybar."
waybar_files=(
  "config"
  "ethernet.sh"
  "modules"
  "style.css"
  "wifi.sh"
  "network_status.sh"
  "usd_rate.sh"
  "status_scroller_mode.sh"
  "wttr.sh"
  "media.sh"
  )
for i in "${waybar_files[@]}"; do
  if [ -d "$script_dir/.git" ]; then
    ln -sfv $script_dir/waybar/${i} $base_config/waybar/${i}
  else
    wget -O $base_config/waybar/${i} $base_url/waybar/${i}
  fi
done

echo "Create symlinks for dunst."
dunst_files=(
  "dunstrc"
  "battery_check.sh"
  "battery_low.mp3"
  "battery_full.ogg"
  )
for i in "${dunst_files[@]}"; do
  if [ -d "$script_dir/.git" ]; then
    ln -sfv $script_dir/dunst/${i} $base_config/dunst/${i}
  else
    wget -O $base_config/dunst/${i} $base_url/dunst/${i}
  fi
done

echo "Create symlinks for kitty."
kitty_files=(
  "kitty.conf"
  "newtab_kitty_choice.sh"
  )
for i in "${kitty_files[@]}"; do
  if [ -d "$script_dir/.git" ]; then
    ln -sfv $script_dir/kitty/${i} $base_config/kitty/${i}
  else
    wget -O $base_config/kitty/${i} $base_url/kitty/${i}
  fi
done

echo "Create symlinks for wlogout."
wlogout_files=(
  "layout"
  )
for i in "${wlogout_files[@]}"; do
  if [ -d "$script_dir/.git" ]; then
    ln -sfv $script_dir/wlogout/${i} $base_config/wlogout/${i}
  else
    wget -O $base_config/wlogout/${i} $base_url/wlogout/${i}
  fi
done

echo "Create symlinks for wofi."
wofi_files=(
  "config"
  "style.css"
  "wofi_trans.sh"
  "wofi_deepl.sh"
  )
for i in "${wofi_files[@]}"; do
  if [ -d "$script_dir/.git" ]; then
    ln -sfv $script_dir/wofi/${i} $base_config/wofi/${i}
  else
    wget -O $base_config/wofi/${i} $base_url/wofi/${i}
  fi
done

echo "Create symlinks for fish."
fish_files=(
  "config.fish"
  "functions"
  )
for i in "${fish_files[@]}"; do
  if [ -d "$script_dir/.git" ]; then
    ln -sfv $script_dir/fish/${i} $base_config/fish/${i}
  else
    wget -O $base_config/fish/${i} $base_url/fish/${i}
  fi
done

echo "Create fonts symlinks"
font_files=(
  "TerminessNerdFont-Regular.ttf"
  "FiraCodeNerdFontMono-Regular.ttf"
  )
for i in "${font_files[@]}"; do
  if [ -d "$script_dir/.git" ]; then
    ln -sfv $script_dir/fonts/${i} ~/.local/share/fonts/${i}
  else
    wget -O ~/.local/share/fonts/${i} $base_url/fonts/${i}
  fi
done

echo "Dotfiles have been linked."

