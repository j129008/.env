FROM ubuntu:16.04
MAINTAINER davidchang

RUN apt-get update
RUN apt-get install -y vim git curl zsh python3 cscope
RUN git clone https://github.com/j129008/.env /root/.env
WORKDIR /root/.env
RUN ./zsh_setting.sh
RUN cp .zshrc /root
RUN cp .vimrc /root
RUN pip3 install ipython --user
