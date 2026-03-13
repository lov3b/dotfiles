export ZSH="${ZSH:-$HOME/.local/share/oh-my-zsh}"
export ZSH_CACHE_DIR="$HOME/.cache/oh-my-zsh"

if [ -z "$SHELL_DEVICE" ]; then
  case "$(uname -s)" in
    Darwin) SHELL_DEVICE="macos" ;;
    Linux) SHELL_DEVICE="linux" ;;
  esac
fi

if [ ! -d "$ZSH" ]; then
  export RUNZSH=no
  export CHSH=no
  export KEEP_ZSHRC=yes
  if command -v curl >/dev/null 2>&1; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  elif command -v wget >/dev/null 2>&1; then
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
fi

ZSH_THEME="afowler"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 13 # Frequency in days
DISABLE_MAGIC_FUNCTIONS="false" # Makes pasting urls escaped
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="false"

plugins=(git ssh sudo)
case $SHELL_DEVICE in
  macos)
    plugins+=(macos)
    ;;
  linux)
    if [[ -r /etc/os-release ]]; then
      case $(awk -F= '/^ID=/{gsub(/"/, "", $2); print $2; exit}' /etc/os-release) in
        arch)   plugins+=(archlinux) ;;
        debian) plugins+=(debian) ;;
        ubuntu) plugins+=(ubuntu) ;;
        fedora) plugins+=(dnf) ;;
      esac
    fi
    ;;
esac

[ -f "$HOME/.config/shell/paths.zsh" ] && source "$HOME/.config/shell/paths.zsh"

if [ -d "$ZSH" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

[ -f "$HOME/.config/shell/aliases.zsh" ] && source "$HOME/.config/shell/aliases.zsh"

[ -n "$SHELL_DEVICE" ] && [ -f "$HOME/.config/shell/devices/${SHELL_DEVICE}.zsh" ] && \
  source "$HOME/.config/shell/devices/${SHELL_DEVICE}.zsh"
[ -f "$HOME/.config/shell/interactive.zsh" ] && source "$HOME/.config/shell/interactive.zsh"

[ -f "$HOME/.config/shell/device.zsh" ] && source "$HOME/.config/shell/device.zsh"
