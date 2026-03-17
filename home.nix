{
  config,
  lib,
  pkgs,
  ...
}:

let
  mkRecursive = source: {
    inherit source;
    recursive = true;
  };

  mkLinkFarm =
    name: dir:
    pkgs.linkFarm name (
      lib.mapAttrsToList (entry: _: {
        name = entry;
        path = dir + "/${entry}";
      }) (lib.filterAttrs (_: type: type != "directory") (builtins.readDir dir))
    );

  localBin = pkgs.symlinkJoin {
    name = "dotfiles-local-bin";
    paths = [
      (mkLinkFarm "shell-local-bin" ./shell/.local/bin)
      (mkLinkFarm "hyprland-local-bin" ./hyprland/.local/bin)
    ];
  };
in
{
  home.username = "love";
  home.homeDirectory = "/home/love";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bat
    brightnessctl
    cliphist
    dunst
    firefox
    flatpak
    ghostty
    git
    git-lfs
    glib
    gnome-keyring
    grim
    hypridle
    hyprland
    hyprlock
    hyprpaper
    jq
    libsecret
    mpv
    networkmanagerapplet
    odt2txt
    papirus-icon-theme
    playerctl
    python3
    qt5ct
    qt6ct
    ristretto
    rofi
    slurp
    socat
    thunar
    thunderbird
    tmux
    waybar
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    zathura
    zsh
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  home.file = {
    ".config/dunst" = mkRecursive ./hyprland/.config/dunst;
    ".config/git" = mkRecursive ./shell/.config/git;
    ".config/ghostty" = mkRecursive ./ghostty/.config/ghostty;
    ".config/gtk-2.0" = mkRecursive ./hyprland/.config/gtk-2.0;
    ".config/gtk-3.0" = mkRecursive ./hyprland/.config/gtk-3.0;
    ".config/gtk-4.0" = mkRecursive ./hyprland/.config/gtk-4.0;
    ".config/hypr" = mkRecursive ./hyprland/.config/hypr;
    ".config/Kvantum" = mkRecursive ./hyprland/.config/Kvantum;
    ".config/kdeglobals.themes" = mkRecursive ./hyprland/.config/kdeglobals.themes;
    ".config/mimeapps.list".source = ./hyprland/.config/mimeapps.list;
    ".config/qt5ct" = mkRecursive ./hyprland/.config/qt5ct;
    ".config/qt6ct" = mkRecursive ./hyprland/.config/qt6ct;
    ".config/rofi" = mkRecursive ./hyprland/.config/rofi;
    ".config/shell" = mkRecursive ./shell/.config/shell;
    ".config/systemd/user" = mkRecursive ./hyprland/.config/systemd/user;
    ".config/waybar" = mkRecursive ./hyprland/.config/waybar;
    ".config/xdg-desktop-portal" = mkRecursive ./hyprland/.config/xdg-desktop-portal;
    ".gtkrc-2.0".source = ./hyprland/.gtkrc-2.0;
    ".local/bin" = mkRecursive localBin;
    ".local/share/applications" = mkRecursive ./hyprland/.local/share/applications;
    ".local/share/color-schemes" = mkRecursive ./hyprland/.local/share/color-schemes;
    ".tmux.conf".source = ./tmux/.tmux.conf;
    ".zshrc".source = ./shell/.zshrc;
  };
}
