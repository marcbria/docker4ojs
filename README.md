# docker4ojs
Docker images and stacks for OJS (and PKP tools)

# Architecture

``` 
[  OJS   ]
[  PHP   ]  --- LINK ----> [ MYSQL ]
[ APACHE ]
``` 

# Run

Create a docker-compose.yml file with:

``` 
# File: docker-compose.yml
# Access via "http://localhost:8080"
#   (or "http://$(docker-machine ip):8080" if using docker-machine)
#
# Database type: MySQL
# Database name: ojs
# Database username: ojs
# Database password: ojs

ojs:
  image: docker4ojs/pkp-ojs:latest
  ports:
    - 8080:80
  links:
    - mysql:db
mysql:
  image: mysql
  environment:
    - MYSQL_ROOT_PASSWORD=root
    - MYSQL_DATABASE=ojs
    - MYSQL_USER=ojs
    - MYSQL_PASSWORD=ojs
```

Then run docker-compose:

``` 
$ docker-compose up
```

# Tags

* latest: Last OJS version from pkp's github.
