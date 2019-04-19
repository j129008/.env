#!/bin/bash
cp ./.zshrc ~

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
cp ./.zshrc ~

# copy gitconfig
cp ./.gitconfig ~

# link tmux config
cp ./.tmux.conf ~/.tmux.conf
