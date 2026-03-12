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

### foot

Foot terminal config with Catppuccin themes.

- Dependencies: `foot`

```bash
sudo pacman -S --needed foot
```

### ghostty

Ghostty terminal config with Catppuccin themes.

- Dependencies: `ghostty`

```bash
sudo pacman -S --needed ghostty
```

### foot

Foot terminal config with Catppuccin themes sourced via `include=`.

- Dependencies: `foot`, `ttf-jetbrains-mono`

```bash
sudo pacman -S --needed foot ttf-jetbrains-mono
```

### hyprland

Hyprland compositor config, Waybar, Rofi themes, wallpaper automation, and theme switchers for Hyprland, GTK, and Qt.

**Dependencies:**

- hyprland
- hyprpaper
- waybar
- rofi
- dunst
- nm-applet
- polkit-kde-agent
- wl-clipboard
- cliphist
- grimblast
- brightnessctl
- pipewire-pulse
- python3
- systemd
- qt5ct
- qt6ct
- kvantum
- papirus-icon-theme
- breeze
- jq
- socat
- gnome-keyring
- libsecret
- xdg-desktop-portal
- xdg-desktop-portal-gtk
- gcr-4
- ghostty
- thunar
- firefox
- thunderbird
- zathura
- ristretto
- mpv
- foot
- hypridle
- hyprloc

- Theme assets: install Catppuccin GTK and Kvantum themes so the light/dark switchers can target Latte and Mocha variants.
- If AUR packages are unavailable, run `~/.local/bin/update-catppuccin-themes` to install the Catppuccin GTK and Kvantum assets directly for the current user.

```bash
sudo pacman -S --needed \
    hyprland \
    hyprpaper \
    waybar \
    rofi \
    dunst \
    network-manager-applet \
    polkit-kde-agent \
    wl-clipboard \
    cliphist \
    brightnessctl \
    pipewire-pulse \
    python \
    systemd \
    noto-fonts \
    thunar \
    catfish \
    gvfs \
    thunar-volman \
    thunar-archive-plugin \
    thunar-media-tags-plugin \
    ristretto \
    libgsf \
    ffmpegthumbnailer \
    qt5ct \
    qt6ct \
    kvantum \
    papirus-icon-theme \
    breeze \
    jq \
    socat \
    gnome-keyring \
    libsecret \
    thunar \
    firefox \
    thunderbird \
    zathura \
    ristretto \
    mpv \
    foot \
    hypridle \
    hyprlock \
    gcr-4
```

- Keyring support: the Hyprland session imports `DISPLAY`, `WAYLAND_DISPLAY`,
  and the XDG session variables into the user D-Bus/systemd environment so
  Secret Service prompts can appear correctly.
- Flatpak Secret portal: `~/.config/xdg-desktop-portal/hyprland-portals.conf` explicitly routes
  `org.freedesktop.impl.portal.Secret` to `gnome-keyring`,
  which is needed because the stock Hyprland portal config does not pick it by default.
- SDDM: Arch's default `/etc/pam.d/sddm` setup usually unlocks the login keyring automatically.
  If you customized it, make sure it still includes `pam_gnome_keyring.so`.
- Enable the user socket once after install:
  `systemctl --user enable --now gnome-keyring-daemon.socket`
- After the first enable in an already-running session, fully log out through `SDDM` or reboot.
  Reloading Hyprland alone is not enough for PAM-unlocked `login.keyring`.
- After changing portal config, restart the portal services or log out and back in:
  `systemctl --user restart xdg-desktop-portal.service xdg-desktop-portal-gtk.service`
- Optional SSH agent integration: `systemctl --user enable --now gcr-ssh-agent.socket`
- Optional Git HTTPS credential storage: `git config --global credential.helper /usr/lib/git-core/git-credential-libsecret`
- Electron app wrappers: this repo ships `~/.local/bin/element-desktop`,
  `~/.local/bin/discord`, `~/.local/bin/bitwarden-desktop`, and
  `~/.local/bin/signal-desktop`, all of which force
  `--password-store=gnome-libsecret` and are used by the local desktop entry overrides.

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
