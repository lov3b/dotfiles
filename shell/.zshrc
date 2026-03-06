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
plugins=(git tmux ssh sudo)
if [[ "$SHELL_DEVICE" == "macos" ]]; then
  plugins+=(macos)
fi

[ -f "$HOME/.config/shell/paths.zsh" ] && source "$HOME/.config/shell/paths.zsh"

if [ -d "$ZSH" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

[ -f "$HOME/.config/shell/aliases.zsh" ] && source "$HOME/.config/shell/aliases.zsh"
[ -f "$HOME/.config/shell/interactive.zsh" ] && source "$HOME/.config/shell/interactive.zsh"

[ -n "$SHELL_DEVICE" ] && [ -f "$HOME/.config/shell/devices/${SHELL_DEVICE}.zsh" ] && \
  source "$HOME/.config/shell/devices/${SHELL_DEVICE}.zsh"

[ -f "$HOME/.config/shell/device.zsh" ] && source "$HOME/.config/shell/device.zsh"

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
plugins=(git tmux ssh sudo)
if [[ "$SHELL_DEVICE" == "macos" ]]; then
  plugins+=(macos)
fi

[ -f "$HOME/.config/shell/paths.zsh" ] && source "$HOME/.config/shell/paths.zsh"
[ -d "$ZSH" ] && source "$ZSH/oh-my-zsh.sh"
[ -f "$HOME/.config/shell/aliases.zsh" ] && source "$HOME/.config/shell/aliases.zsh"
[ -f "$HOME/.config/shell/interactive.zsh" ] && source "$HOME/.config/shell/interactive.zsh"

[ -n "$SHELL_DEVICE" ] && [ -f "$HOME/.config/shell/devices/${SHELL_DEVICE}.zsh" ] && \
  source "$HOME/.config/shell/devices/${SHELL_DEVICE}.zsh"

[ -f "$HOME/.config/shell/device.zsh" ] && source "$HOME/.config/shell/device.zsh"
