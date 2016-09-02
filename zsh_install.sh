#!/bin/bash

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install zsh-autosuggestions
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
cp $ZSH_CUSTOM/plugins/zsh-autosuggestions/src/config.zsh $ZSH_CUSTOM
vim +9 $ZSH_CUSTOM/config.zsh

# copy gitconfig
cp ./.gitconfig ~

# link tmux config
ln -s ./.tmux.conf ~/.tmux.conf

# install autojump
git clone git://github.com/joelthelion/autojump.git /tmp
./tmp/install.py
