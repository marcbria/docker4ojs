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

2) Download [docker-compose.yml](https://raw.githubusercontent.com/marcbria/docker4ojs/master/latest/docker-compose.yml) file with:

```
$ wget https://raw.githubusercontent.com/marcbria/docker4ojs/master/latest/docker-compose.yml
```

3) Run:

``` 
$ docker-compose up
```

4) Visit your OJS at: http://localhost:8080

# Tags

* **latest:** Last OJS version from pkp's github (master branch).
* **branch:** Build an specific branch.
