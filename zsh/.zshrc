autoload -Uz colors
colors

HISTFILE=${XDG_CACHE_HOME}/zsh/history
HISTSIZE=10000
SAVEHIST=100000
setopt share_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_reduce_blanks
HIST_STAMPS="yyyy-mm-dd"

bindkey -e

alias ls='ls -FG'
alias la='ls -aFG'
alias ll='ls -alFG'

# zsh-completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit -i -d "$XDG_CACHE_HOME/zsh/compdump"
fi

fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure
eval "$(sheldon source)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_DEFAULT_OPTS='--reverse --border --bind ctrl-k:kill-line --color=pointer:#e67172'
export FZF_TMUX_HEIGHT='60%'
function _ghq_list_jump() {
  jump_dir=$(ghq list | fzf)
  if [ -n "$jump_dir" ]; then
    cd "$(ghq root)/$jump_dir"
  fi
}
zle -N _ghq_list_jump
bindkey '^G' _ghq_list_jump

export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
eval "$(mise activate zsh --shims)"

[ -f "$XDG_CONFIG_HOME/zsh/.zshrc.local" ] && source "$XDG_CONFIG_HOME/zsh/.zshrc.local"
