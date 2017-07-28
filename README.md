# docker4ojs

Docker images and stacks for OJS (and PKP tools)

# Architecture

```
[   OJS:latest   ]
[ PHP:5.6-apache ]  --- LINK ----> [ MYSQL ]
``` 


# Execute

1) [Install docker compose](https://docs.docker.com/compose/install)

``` 
$ sudo pip install docker-compose
```

2) Download [docker-compose.yml](https://raw.githubusercontent.com/marcbria/docker4ojs/version/docker-compose.yml) file:

```
$ wget https://raw.githubusercontent.com/marcbria/docker4ojs/version/docker-compose.yml
```

3) Run:

```
$ env OJS_BRANCH=ojs-stable-3_0_2
$ docker-compose up
```


4) Visit your OJS at: http://localhost:8080


# Tags

* **latest:** Last OJS version from pkp's github (master branch).
* **version:** Build an specific branch. You need to specify -e param with the pkp's specific branch name.
