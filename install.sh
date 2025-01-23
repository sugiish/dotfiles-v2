#!/usr/bin/env bash
set -veuo pipefail

# https://dev.classmethod.jp/articles/dotfiles-reconstruct-termina-env/

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
# mise
#
if [[ ! -e "$HOME/.local/bin/mise" ]]; then
    curl https://mise.run | sh
fi

#
# zsh
#
mkdir -p $HOME/.config/zsh
ln -sf $SCRIPT_DIR/zsh/zprofile $HOME/.zprofile
ln -sf $SCRIPT_DIR/zsh/zshenv $HOME/.zshenv
ln -sf $SCRIPT_DIR/zsh/zshrc $HOME/.zshrc
brew install coreutils gnu-sed
