path_prepend() {
  local dir="$1"
  [ -n "$dir" ] || return 0
  [ -d "$dir" ] || return 0
  case ":$PATH:" in
    *":$dir:"*) ;;
    *) PATH="$dir:$PATH" ;;
  esac
}

path_append() {
  local dir="$1"
  [ -n "$dir" ] || return 0
  [ -d "$dir" ] || return 0
  case ":$PATH:" in
    *":$dir:"*) ;;
    *) PATH="$PATH:$dir" ;;
  esac
}

manpath_prepend() {
  local dir="$1"
  [ -n "$dir" ] || return 0
  [ -d "$dir" ] || return 0
  case ":$MANPATH:" in
    *":$dir:"*) ;;
    *) MANPATH="$dir:$MANPATH" ;;
  esac
}

path_append "$HOME/.local/bin"
