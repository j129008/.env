work-env
========

```
$ docker build -t workenv --no-cache .

# linux user
$ docker run -it workenv zsh

# windows babun user
$ docker run -d --name workenv -v C:/Users/[ username ]/.babun/cygwin/home/[ username ]:/volume -p 22:22 workenv
$ ssh root@localhost

# stop container
$ docker stop workenv
```
