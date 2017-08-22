# docker4ojs

Docker images and stacks for OJS (and PKP tools)

# Architecture

The application is divided in two containers:


```
[ OJS:latest     ]
[ PHP:5.6-apache ]  --- LINK ----> [ MYSQL ]
``` 


# Execute

1) [Install docker compose](https://docs.docker.com/compose/install)

``` 
$ sudo pip install docker-compose
```


2) Download [docker-compose.yml](https://raw.githubusercontent.com/marcbria/docker4ojs/master/docker-compose.yml) file:

```
$ wget https://raw.githubusercontent.com/marcbria/docker4ojs/master/docker-compose.yml
```


3) Run:

```
$ docker-compose up
```


4) Visit your new OJS at: http://localhost:8080


5) Fill the forms as you wish but remember that the DB fields need to fit with mysql docker as defined in docker-compose.yml:

* Database driver: MySQLi
* Host: db
* Username: ojs
* Password: ojs
* Database name: ojs
* Unckeck "Create new database"



# Tags

* **latest:** Last DEV OJS version from pkp's github (master branch).
* **version:** Build an specific branch. By default the last stable (ojs-stable-3_0_2) You need to modify the the docker-compose file with the pkp's specific branch name or use the -e param.
