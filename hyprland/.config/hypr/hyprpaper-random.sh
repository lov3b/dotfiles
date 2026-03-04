#!/usr/bin/env bash
set -euo pipefail

wallpaper_dir="$HOME/Pictures/wallpapers"
config_path="$HOME/.config/hypr/hyprpaper.conf"

if [[ ! -d "$wallpaper_dir" ]]; then
    exit 0
fi

mapfile -d '' -t files < <(
    find "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0
)

if (( ${#files[@]} == 0 )); then
    exit 0
fi

random_file="${files[RANDOM % ${#files[@]}]}"

printf 'preload = %s\nwallpaper = ,%s\n' "$random_file" "$random_file" > "$config_path"

pkill hyprpaper >/dev/null 2>&1 || true
hyprpaper &
