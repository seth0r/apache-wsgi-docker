FROM ubuntu:20.04
MAINTAINER me+docker@seth0r.net

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

RUN apt-get update 
RUN apt-get dist-upgrade -y
RUN apt-get -y install apache2 libapache2-mod-wsgi-py3 libapache2-mod-python vim python3-all python3-cherrypy3 python3-jinja2 python3-pymongo python3-requests

RUN mkdir -p /var/run/apache2

RUN a2enmod rewrite
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod proxy_http2
RUN a2enmod proxy_html
RUN a2enmod wsgi
RUN a2enmod ssl
RUN a2dismod python

RUN ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/1 /var/log/apache2/error.log

EXPOSE 80
EXPOSE 443

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
