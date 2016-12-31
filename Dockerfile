FROM php:7-apache
MAINTAINER Kristoph Junge <kristoph.junge@gmail.com>

# Utilities
RUN apt-get update && \
    apt-get -y install apt-transport-https git curl --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

ARG SIMPLESAMLPHP_VERSION=1.14.8
ADD https://github.com/simplesamlphp/simplesamlphp/releases/download/v$SIMPLESAMLPHP_VERSION/simplesamlphp-$SIMPLESAMLPHP_VERSION.tar.gz /tmp/simplesamlphp.tar.gz
RUN tar xzf /tmp/simplesamlphp.tar.gz -C /tmp
RUN rm -f /tmp/simplesamlphp.tar.gz
RUN ls -al /tmp
RUN mv /tmp/simplesamlphp-* /var/www/simplesamlphp

COPY config/simplesamlphp/config.php /var/www/simplesamlphp/config
COPY config/simplesamlphp/authsources.php /var/www/simplesamlphp/config
COPY config/simplesamlphp/saml20-sp-remote.php /var/www/simplesamlphp/metadata

COPY config/simplesamlphp/cert.crt /var/www/simplesamlphp/cert/
COPY config/simplesamlphp/private.key /var/www/simplesamlphp/cert/

RUN touch /var/www/simplesamlphp/modules/exampleauth/enable

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY config/apache/simplesamlphp.conf /etc/apache2/sites-available
COPY config/apache/cert.crt /etc/ssl/cert/cert.crt
COPY config/apache/private.key /etc/ssl/private/private.key

COPY config/php/php.ini /usr/local/etc/php/

RUN a2enmod ssl
RUN a2dissite 000-default.conf default-ssl.conf
RUN a2ensite simplesamlphp.conf

# Set work dir
WORKDIR /var/www/simplesamlphp

# General setup
EXPOSE 80 443
