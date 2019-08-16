work-env
========

```
$ docker build -t workenv --no-cache .

# in linux system
$ docker run -it workenv zsh

# in windows system (for babun user)
$ docker run -d -v C:/Users/[ username ]/.babun/cygwin/home/[ username ]:/volume -p 22:22 workenv

# stop container
$ docker container ls
$ docker stop [container id]
```
