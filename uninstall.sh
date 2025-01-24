#!/usr/bin/env bash
set -veuo pipefail

SCRIPT_DIR=$(realpath)

#
# zsh
#
/bin/rm -fr $HOME/.config/zsh
sudo rm /etc/zshenv

#
# mise
#
if which mise; then
    mise implode -y
fi

#
# Git
#
rm -fr $HOME/.config/git

#
# Homebrew
#
if which brew; then
    echo 'Y' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
fi
[[ -e /opt/homebrew ]] && sudo /bin/rm -fr /opt/homebrew

#
# General
#
/bin/rm -fr $HOME/.cache
