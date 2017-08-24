FROM php:5.6-apache
LABEL maintainer="Marc Bria Ramírez <marc.bria@uab.cat>"

# PHP Dependencies
RUN apt-get update \
    && apt-get install zlib1g-dev libxml2-dev -y \
    && docker-php-ext-install mysqli mysql zip soap

# Cloning and Cleaning OJS and PKP-LIB git repositories
RUN apt-get install git -y \
    && git config --global url.https://.insteadOf git:// \
    && rm -fr /var/www/html/* 

# Dev stuff
RUN apt-get install nano net-tools

ENV OJS_BRANCH=ojs-stable-3_0_2
RUN git clone -v --recursive --progress -b ${OJS_BRANCH} --single-branch https://github.com/pkp/ojs.git /var/www/html

WORKDIR /var/www/html
RUN cd lib/pkp \
    && curl -sS https://getcomposer.org/installer | php \
    && php composer.phar update 

RUN cd /var/www/html \
    && find . | grep .git | xargs rm -rf \
    && apt-get remove git -y \
    && apt-get autoremove -y \
    && apt-get clean -y


# Configuring OJS
RUN cp config.TEMPLATE.inc.php config.inc.php \
    && chmod ug+rw config.inc.php \
    && mkdir -p /var/www/files/ \
    && chown -R www-data:www-data /var/www/

# Setting Apache
COPY default.htaccess /var/www/html/.htaccess
RUN a2enmod rewrite
RUN service apache2 restart 
