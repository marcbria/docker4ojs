# docker4ojs

Docker images and stacks for OJS (and PKP tools)
(This readme is underconstruction and is not full functional)

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

2) Clone localy the [singldb branch](https://raw.githubusercontent.com/marcbria/docker4ojs/singledb):

```
$ mkdir docker4ojs
$ git clone -b singledb --single-branch https://github.com/marcbria/docker4ojs.git opencv-2.4
```

3) Run:

```
$ ./runJournal.sh journal
```

4) Visit your new OJS at: http://localhost:8080

5) Fill the forms as you wish but the DB data need to fit with mysql docker as defined in docker-compose.yml:

* Database driver: MySQLi
* Host: dbnet
* Username: ojs
* Password: ojs
* Database name: ojs
* Unckeck "Create new database"


# Tags

* **latest:** Last DEV OJS version from pkp's github (master branch).
* **version:** Build an specific branch. You need to modify the the docker-compose file with the pkp's specific branch name or use the -e param.
