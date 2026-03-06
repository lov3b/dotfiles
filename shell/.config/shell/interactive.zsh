setopt HIST_IGNORE_SPACE
set -o vi

autoload bashcompinit
bashcompinit

if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

if command -v fortune >/dev/null 2>&1 && command -v cowsay >/dev/null 2>&1 && command -v lolcat >/dev/null 2>&1; then
  fortune | cowsay -f dragon | lolcat --seed=15
fi
