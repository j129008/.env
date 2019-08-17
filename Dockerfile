FROM ubuntu:16.04
MAINTAINER davidchang

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:jonathonf/vim && \
    apt-get update && \
    apt-get install -y vim git curl zsh python3 cscope tmux htop autojump clang libclang-dev wget openssh-server

RUN git clone git@github.com:j129008/.env.git /root/.env && \
    cd /root/.env && \
    ./zsh_setting.sh && \
    cp .zshrc /root && \
    cp .vimrc /root && \
    vim +PlugInstall +qall

RUN ~/.local/bin/pip3 install ipython autopep8 pandas --user
RUN chsh -s /bin/zsh

# setting ssh-server
RUN mkdir /var/run/sshd && \
    echo 'root:dockerpassword' | chpasswd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
