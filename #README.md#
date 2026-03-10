# Dotfiles

Some of the configuration for the software that I use.
This doesn't include _neovim_ as that's in a separate repo.

## How to use?

Clone the repo to your homedirectory.
Then, use [GNU Stow](https://www.gnu.org/software/stow/) to "install" and "uninstall" the configurations.

**To install:**

```bash
stow ghostty
```

**To uninstall:**

```bash
stow -D ghostty
```

## Configs

### ghostty

Ghostty terminal config with Catppuccin themes.

- Dependencies: `ghostty`

```bash
sudo pacman -S --needed ghostty
```

### hyprland

Hyprland compositor config, Waybar, Rofi themes, wallpaper automation, and theme switchers.

- Dependencies: `hyprland`, `hyprpaper`, `waybar`, `rofi`, `dunst`, `nm-applet`,
  `polkit-kde-agent`, `wl-clipboard`, `cliphist`, `grimblast`, `brightnessctl`,
  `pipewire-pulse` or `pulseaudio`, `python3`, `systemd`
- Optional: `ghostty`, `thunar`, `firefox`, `thunderbird`, `zathura`, `ristretto`,
  `flatpak` (Spotify/Discord/Telegram/Bitwarden), `steam`, `mpv`, `wezterm`,
  `hypridle`, `hyprlock`

```bash
sudo pacman -S --needed hyprland hyprpaper waybar rofi dunst network-manager-applet polkit-kde-agent wl-clipboard cliphist brightnessctl pipewire-pulse python systemd noto-fonts thunar catfish gvfs thunar-volman thunar-archive-plugin thunar-media-tags-plugin ristretto libgsf ffmpegthumbnailer
```

```bash
sudo pacman -S --needed ghostty thunar firefox thunderbird zathura ristretto flatpak steam mpv wezterm hypridle hyprlock
```

### paru

Paru AUR helper configuration.

- Dependencies: `paru`

```bash
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru-bin.git /tmp/paru
pushd /tmp/paru
makepkg -si
popd
rm -rf /tmp/paru
```

### shell

Git config and attributes.

- Dependencies: `git`, `bat`, `neovim`, `git-lfs`, `odt2txt`

```bash
sudo pacman -S --needed git bat neovim git-lfs odt2txt
```

### tmux

tmux configuration with vim-style navigation and a custom status bar.

- Dependencies: `tmux`

```bash
sudo pacman -S --needed tmux
```

### wezterm

WezTerm terminal config with Catppuccin schemes.

- Dependencies: `wezterm`

```bash
sudo pacman -S --needed wezterm
```
