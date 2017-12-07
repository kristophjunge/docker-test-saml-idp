FROM php:7.1-apache
MAINTAINER Kristoph Junge <kristoph.junge@gmail.com>

# Utilities
RUN apt-get update && \
    apt-get -y install apt-transport-https git curl vim --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

# SimpleSAMLphp
ARG SIMPLESAMLPHP_VERSION=1.14.15
RUN curl -s -L -o /tmp/simplesamlphp.tar.gz https://github.com/simplesamlphp/simplesamlphp/releases/download/v$SIMPLESAMLPHP_VERSION/simplesamlphp-$SIMPLESAMLPHP_VERSION.tar.gz && \
    tar xzf /tmp/simplesamlphp.tar.gz -C /tmp && \
    rm -f /tmp/simplesamlphp.tar.gz  && \
    ls -al /tmp && \
    mv /tmp/simplesamlphp-* /var/www/simplesamlphp
COPY config/simplesamlphp/config.php /var/www/simplesamlphp/config
COPY config/simplesamlphp/authsources.php /var/www/simplesamlphp/config
COPY config/simplesamlphp/saml20-sp-remote.php /var/www/simplesamlphp/metadata
COPY config/simplesamlphp/server.crt /var/www/simplesamlphp/cert/
COPY config/simplesamlphp/server.pem /var/www/simplesamlphp/cert/
RUN touch /var/www/simplesamlphp/modules/exampleauth/enable

# Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
COPY config/apache/simplesamlphp.conf /etc/apache2/sites-available
COPY config/apache/cert.crt /etc/ssl/cert/cert.crt
COPY config/apache/private.key /etc/ssl/private/private.key
RUN a2enmod ssl
RUN a2dissite 000-default.conf default-ssl.conf
RUN a2ensite simplesamlphp.conf

# Make config writeable by apache so that our testapi can update config
RUN chown -R www-data.www-data /var/www/simplesamlphp/metadata /var/www/simplesamlphp/config

# Copy in scripts that provide an API to adjust SP remotes dynamically in tests.
COPY config/testapi/* /var/www/simplesamlphp/www/testapi/

# Set work dir
WORKDIR /var/www/simplesamlphp

# General setup
EXPOSE 80 443
