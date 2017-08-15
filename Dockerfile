FROM php:5.6-apache
LABEL maintainer="Marc Bria Ramírez <marc.bria@uab.cat>"

ENV OJS_BRANCH ojs-stable_3_0_2

# PHP Dependencies
RUN apt-get update \
    && apt-get install zlib1g-dev libxml2-dev -y \
    && docker-php-ext-install mysqli mysql zip soap

# Cloning and Cleaning OJS and PKP-LIB git repositories
RUN apt-get install git -y \
    && git config --global url.https://.insteadOf git:// \
    && rm -fr /var/www/html/* 

# RUN git clone -v --recursive --progress -b ${OJS_BRANCH} https://github.com/pkp/ojs.git /var/www/html
# RUN git clone -v --recursive --progress -b ojs-stable_3_0_2 https://github.com/pkp/ojs.git /var/www/html

RUN echo OJS_BRANCH is: ${OJS_BRANCH}
RUN git clone -v --recursive --progress https://github.com/pkp/ojs.git /var/www/html
RUN git checkout -b ${OJS_BRANCH} origin/${OJS_BRANCH}

RUN cd /var/www/html/lib/pkp \
    && curl -sS https://getcomposer.org/installer | php \
    && php composer.phar update \
    && cd /var/www/html \
    && find . | grep .git | xargs rm -rf \
    && apt-get remove git -y \
    && apt-get autoremove -y \
    && apt-get clean -y


# Configuring OJS
RUN cp config.TEMPLATE.inc.php config.inc.php \
    && chmod ug+rw config.inc.php \
    && mkdir -p /var/www/files/ \
    && chown -R www-data:www-data /var/www/ 

# Dev stuff
RUN apt-get install nano net-tools
