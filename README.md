work-env
========

```
$ cd ~/.env

# run & build workenv
$ docker-compose up -d --build workenv

# go into container
$ docker-compose exec workenv zsh

# or connect with ssh (root:dockerpassword)
$ ssh root@localhost

# stop workenv
$ docker-compose down
```
