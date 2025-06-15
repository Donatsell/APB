#!/bin/sh
# Substitute environment variables in Apache configuration
envsubst < /usr/local/apache2/conf/httpd.conf.template > /usr/local/apache2/conf/httpd.conf

# Start Apache
httpd -D FOREGROUND