for gnu_program in "grep" "gnu-getopt" "gnu-indent" "gawk" "gnu-sed" "gnu-tar" "findutils" "coreutils"; do
    path_prepend "/opt/homebrew/opt/$gnu_program/libexec/gnubin"
    manpath_prepend "/opt/homebrew/opt/$gnu_program/libexec/gnuman"
done

path_prepend "/opt/homebrew/bin/rsync"
path_prepend "/opt/homebrew/sbin"
path_prepend "/opt/homebrew/bin"

path_append "$HOME/.rustup/toolchains/stable-aarch64-apple-darwin/bin"
path_append "$HOME/.cargo/bin"
path_append "$HOME/Documents/Code/scripts"

mpv() {
  if command -v mac-mpv-ui >/dev/null 2>&1; then
    mac-mpv-ui "$@"
    return
  fi

  command mpv "$@"
}
