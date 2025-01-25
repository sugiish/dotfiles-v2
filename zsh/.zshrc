autoload -Uz colors
colors

HISTFILE=${XDG_CACHE_HOME}/.zsh_history
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

eval "$(starship init zsh)"
eval "$(sheldon source)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_DEFAULT_OPTS='--reverse --border --bind ctrl-k:kill-line'
export FZF_TMUX_HEIGHT='60%'
alias gl='cd $(ghq root)/$(ghq list | fzf)'
function _ghq_list_jump() {
  gl
}
zle -N _ghq_list_jump
bindkey '^G' _ghq_list_jump

export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
eval "$(mise activate zsh --shims)"
