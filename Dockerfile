FROM ubuntu:16.04
MAINTAINER davidchang

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:jonathonf/vim && \
    apt-get update && \
    apt-get install -y vim git curl zsh python3 cscope tmux htop autojump

RUN git clone https://github.com/j129008/.env /root/.env && \
    cd /root/.env && \
    ./zsh_setting.sh && \
    cp .zshrc /root && \
    cp .vimrc /root && \
    vim +PlugInstall +qall

RUN ~/.local/bin/pip3 install ipython autopep8 --user
RUN chsh -s /bin/zsh

# install ssh-server
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:dockerpassword' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
