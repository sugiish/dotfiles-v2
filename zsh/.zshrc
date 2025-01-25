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

# fpath+=("$(brew --prefix)/share/zsh/site-functions")
# autoload -U promptinit; promptinit
# prompt pure
eval "$(starship init zsh)"
eval "$(sheldon source)"
