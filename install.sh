#!/usr/bin/env bash
set -veuo pipefail

# https://dev.classmethod.jp/articles/dotfiles-reconstruct-termina-env/

SCRIPT_DIR=$(realpath)
# スクリプト中で使われるPATHを予め通しておく
PATH="$PATH:/opt/homebrew/bin"
PATH="$PATH:$HOME/.local/share/mise/installs/python/latest/bin"
PATH="$PATH:$HOME/.local/share/mise/installs/node/latest/bin"

# ディレクトリのsymlinkを作る
function symlink_dir() {
    src=$1
    dst=$2
    [[ -L "$dst" ]] && rm -fr "$dst"
    ln -sf "$src" "$dst"
}

#
# Homebrew
#
if ! which brew; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

#
# Git
#
mkdir -p $HOME/.config/
symlink_dir $SCRIPT_DIR/git $HOME/.config/git

#
# mise
#
if ! which mise; then
    brew install mise
fi

#
# zsh
#
if [ ! -e /etc/zshenv ]; then
    echo "export ZDOTDIR=$HOME/.config/zsh" | sudo tee -a /etc/zshenv
    sudo chmod 444 /etc/zshenv
    source /etc/zshenv
fi
symlink_dir $SCRIPT_DIR/zsh $HOME/.config/zsh

#
# zsh plugins
#
brew install sheldon
symlink_dir $SCRIPT_DIR/sheldon $HOME/.config/sheldon
brew install pure

#
# brew packages
#
brew install fzf
brew install ghq

