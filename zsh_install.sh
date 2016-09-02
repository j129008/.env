#!/bin/bash

cp ./.zshrc ~

# install zsh-autosuggestions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
cp ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/src/config.zsh ~/.oh-my-zsh/custom
vim +9 ~/.oh-my-zsh/custom/config.zsh

# copy gitconfig
cp ./.gitconfig ~

# link tmux config
ln -s ./.tmux.conf ~/.tmux.conf

# install autojump
git clone git://github.com/joelthelion/autojump.git /tmp/autojump
cd /tmp/autojump/
./install.py
