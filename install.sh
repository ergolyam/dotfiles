#!/usr/bin/env bash

set -e

if [[ -n "$BASH_SOURCE" && "$BASH_SOURCE" != "/dev/stdin" ]]; then
    script_path="$BASH_SOURCE"
elif [[ -n "$0" && "$0" != "bash" ]]; then
    script_path="$0"
else
    script_path=""
fi

if [[ -n "$script_path" ]]; then
    script_dir=$(dirname "$(realpath "$script_path")")
else
    script_dir=$(pwd)
fi

if [ -d "$script_dir/.git" ]; then
  echo "Script dir: $script_dir"
  expected_url="github.com:grisha765/dotfiles.git"
  remote_short_url=""
  if git -C "$script_dir" remote get-url origin &>/dev/null; then
    remote_url="$(git -C "$script_dir" remote get-url origin)"
    remote_short_url="$(echo "$remote_url" | sed -E 's#(git@|https://)github\.com(:|/)#github.com:#')"
  fi
fi

if command -v wget >/dev/null 2>&1; then
  download_cmd='wget -q -O'
elif command -v curl >/dev/null 2>&1; then
  download_cmd='curl -sSf -o'
else
  echo "Error: wget or curl not found." >&2
  exit 1
fi

base_config="$HOME/.config"
base_url="https://raw.githubusercontent.com/grisha765/dotfiles/main"

available_configs=(
  "hypr"
  "waybar"
  "dunst"
  "kitty"
  "wlogout"
  "wofi"
  "fish"
  "fonts"
)

selected_configs=()

if [ $# -eq 0 ]; then
  selected_configs=("${available_configs[@]}")
else
  for arg in "$@"; do
    case $arg in
      --hypr) selected_configs+=("hypr") ;;
      --waybar) selected_configs+=("waybar") ;;
      --dunst) selected_configs+=("dunst") ;;
      --kitty) selected_configs+=("kitty") ;;
      --wlogout) selected_configs+=("wlogout") ;;
      --wofi) selected_configs+=("wofi") ;;
      --fish) selected_configs+=("fish") ;;
      --fonts) selected_configs+=("fonts") ;;
      --help|-h)
        echo "Usage: $0 [--hypr] [--waybar] [--dunst] [--kitty] [--wlogout] [--wofi] [--fish] [--fonts]"
        exit 0
        ;;
      *)
        echo "Unknown option: $arg"
        exit 1
        ;;
    esac
  done
fi

setup_hypr() {
  echo "Setting up Hyprland config"
  mkdir -pv $base_config/hypr/plugins
  local files=(
    "hyprland.conf"
    "hyprpaper.conf"
    "wallapaper.png"
    "keys.conf"
    "monitors.conf"
    "startup.conf"
    "wm.conf"
    "wmrules.conf"
    "plugins/hyprscroller.so"
    "record_screen.sh"
    "set_workspace.sh"
    "toggle_overview_mode.sh"
    "set_scroller_mode.sh"
    "screenshot.sh"
  )
  for i in "${files[@]}"; do
    if [ -d "$script_dir/.git" ] && [ "$remote_short_url" = "$expected_url" ]; then
      ln -sfv "$script_dir/hyprland/$i" "$base_config/hypr/$i"
    else
      echo "Download $i..."
      $download_cmd "$base_config/hypr/$i" "$base_url/hyprland/$i"
    fi
  done
}

setup_waybar() {
  echo "Setting up Waybar config"
  mkdir -pv $base_config/waybar
  local files=(
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
  for i in "${files[@]}"; do
    if [ -d "$script_dir/.git" ] && [ "$remote_short_url" = "$expected_url" ]; then
      ln -sfv "$script_dir/waybar/$i" "$base_config/waybar/$i"
    else
      echo "Download $i..."
      $download_cmd "$base_config/waybar/$i" "$base_url/waybar/$i"
    fi
  done
}

setup_dunst() {
  echo "Setting up Dunst config"
  mkdir -pv $base_config/dunst
  local files=(
    "dunstrc"
    "battery_check.sh"
    "battery_low.mp3"
    "battery_full.ogg"
  )
  for i in "${files[@]}"; do
    if [ -d "$script_dir/.git" ] && [ "$remote_short_url" = "$expected_url" ]; then
      ln -sfv "$script_dir/dunst/$i" "$base_config/dunst/$i"
    else
      echo "Download $i..."
      $download_cmd "$base_config/dunst/$i" "$base_url/dunst/$i"
    fi
  done
}

setup_kitty() {
  echo "Setting up Kitty config"
  mkdir -pv $base_config/kitty
  local files=(
    "kitty.conf"
    "newtab_kitty_choice.sh"
  )
  for i in "${files[@]}"; do
    if [ -d "$script_dir/.git" ] && [ "$remote_short_url" = "$expected_url" ]; then
      ln -sfv "$script_dir/kitty/$i" "$base_config/kitty/$i"
    else
      echo "Download $i..."
      $download_cmd "$base_config/kitty/$i" "$base_url/kitty/$i"
    fi
  done
}

setup_wlogout() {
  echo "Setting up Wlogout config"
  mkdir -pv $base_config/wlogout
  local files=(
    "layout"
  )
  for i in "${files[@]}"; do
    if [ -d "$script_dir/.git" ] && [ "$remote_short_url" = "$expected_url" ]; then
      ln -sfv "$script_dir/wlogout/$i" "$base_config/wlogout/$i"
    else
      echo "Download $i..."
      $download_cmd "$base_config/wlogout/$i" "$base_url/wlogout/$i"
    fi
  done
}

setup_wofi() {
  echo "Setting up Wofi config"
  mkdir -pv $base_config/wofi
  local files=(
    "config"
    "style.css"
    "wofi_trans.sh"
    "wofi_deepl.sh"
  )
  for i in "${files[@]}"; do
    if [ -d "$script_dir/.git" ] && [ "$remote_short_url" = "$expected_url" ]; then
      ln -sfv "$script_dir/wofi/$i" "$base_config/wofi/$i"
    else
      echo "Download $i..."
      $download_cmd "$base_config/wofi/$i" "$base_url/wofi/$i"
    fi
  done
}

setup_fish() {
  echo "Setting up Fish config"
  mkdir -pv $base_config/fish/functions
  local files=(
    "config.fish"
    "functions/fish_prompt.fish"
    "functions/loadenv.fish"
  )
  for i in "${files[@]}"; do
    if [ -d "$script_dir/.git" ] && [ "$remote_short_url" = "$expected_url" ]; then
      ln -sfv "$script_dir/fish/$i" "$base_config/fish/$i"
    else
      echo "Download $i..."
      $download_cmd "$base_config/fish/$i" "$base_url/fish/$i"
    fi
  done
}

setup_fonts() {
  echo "Setting up fonts"
  mkdir -pv ~/.local/share/fonts
  local files=(
    "TerminessNerdFont-Regular.ttf"
    "FiraCodeNerdFontMono-Regular.ttf"
  )
  for i in "${files[@]}"; do
    if [ -d "$script_dir/.git" ] && [ "$remote_short_url" = "$expected_url" ]; then
      ln -sfv "$script_dir/fonts/$i" $HOME/.local/share/fonts/$i
    else
      echo "Download $i..."
      $download_cmd $HOME/.local/share/fonts/$i "$base_url/fonts/$i"
    fi
  done
}

for config in "${selected_configs[@]}"; do
  setup_func="setup_$config"
  $setup_func
done

echo "Dotfiles have been installed."

