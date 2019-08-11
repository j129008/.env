FROM ubuntu:16.04
MAINTAINER davidchang

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:jonathonf/vim && \
    apt-get update && \
    apt-get install -y vim git curl zsh python3 cscope tmux htop

RUN git clone https://github.com/j129008/.env /root/.env && \
    cd /root/.env && \
    ./zsh_setting.sh && \
    cp .zshrc /root && \
    cp .vimrc /root && \
    vim +PlugInstall +qall

RUN ~/.local/bin/pip3 install ipython autopep8 --user
RUN chsh -s /bin/zsh
