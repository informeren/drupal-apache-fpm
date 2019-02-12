FROM phusion/baseimage:0.11

# Basic install of apache
RUN install_clean apache2 ssl-cert

# Add custom apache configuration and prepare services.
COPY files/etc/ /etc/

# Switch docroot from html to web to be docker-compose compatible
RUN \
  mv /var/www/html /var/www/web

# Enable needed apache modules and configuration added above
RUN \
  a2enmod rewrite && \
  a2enmod proxy_fcgi && \
  a2enmod remoteip && \
  a2enmod expires && \
  a2enmod ssl && \
  a2ensite ssl && \
  a2enconf allow-override-all && \
  a2enconf php-fpm

EXPOSE 80
EXPOSE 443
