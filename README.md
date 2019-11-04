work-env
========

```
$ docker build -t workenv --no-cache .

# linux user
$ docker run -it workenv zsh

# windows babun user
$ docker run -d  -v C:/Users/$USER/.babun/cygwin/home/$USER:/volume --name workenv -p 22:22 workenv
$ ssh root@localhost

# stop container
$ docker stop workenv
```
