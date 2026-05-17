# Setup Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ZSH Plugins (autosuggestions and completions deferred until after prompt)
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting

# Setup history searching
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styles (compinit itself is handled by fast-syntax-highlighting's atinit)
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose true
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Custom Alias
alias ls="ls --color='always'"

# Key bindings
bindkey "\e[1;5C" forward-word   # Ctrl + →
bindkey "\e[1;5D" backward-word  # Ctrl + ←
bindkey "\e[H" beginning-of-line  # Home
bindkey "\e[F" end-of-line        # End

# Oh My Posh (cached — avoids subprocess on every shell start)
export PATH="$PATH:$HOME/.local/bin"
_OMP_CACHE="$HOME/.cache/omp_init.zsh"
if [[ ! -f "$_OMP_CACHE" || "${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-posh/ohmyposh.json" -nt "$_OMP_CACHE" ]]; then
  oh-my-posh init zsh --config "${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-posh/ohmyposh.json" > "$_OMP_CACHE"
fi
source "$_OMP_CACHE"

# Shell integrations
eval "$(fzf --zsh)"

# Load local/private customizations (if present)
if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
