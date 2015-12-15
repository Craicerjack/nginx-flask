############################################################
# Dockerfile to build Flask App
# Based on
############################################################

# Set the base image
FROM debian:latest

# File Author / Maintainer
MAINTAINER Carlos Tighe

COPY ./nginx_signing.key /var/www/app/nginx_signing.key
RUN apt-key add /var/www/app/nginx_signing.key
RUN echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list
RUN echo "deb-src http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y nginx \
    build-essential \
    python \
    python-dev\
    python-pip \
    vim \
 && apt-get clean \
 && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/*

 # Copy over and install the requirements
COPY ./app/requirements.txt /var/www/app/app/requirements.txt
RUN pip install -r /var/www/app/app/requirements.txt

COPY ./run.py /var/www/app/run.py
COPY ./app /var/www/app/app/
WORKDIR /var/www/app
CMD ["/bin/bash", "-c", "uwsgi --http 0.0.0.0:80 --wsgi-file ./run.py"]


# RUN rm /etc/nginx/conf.d/default.conf
# COPY ./nginx.conf /etc/nginx/conf.d/
# COPY ./uwsgi.ini /var/www/app/

# RUN echo "daemon off;" >> /etc/nginx/nginx.conf



# COPY ./run.py /var/www/app/run.py
# COPY ./app /var/www/app/app/
# RUN mkdir -p /var/log/uwsgi
# RUN chown -R www-data:www-data /var/www/app

# EXPOSE 80

# # RUN /etc/init.d/nginx start

# CMD ["/bin/bash", "-c", "uwsgi -s /tmp/uwsgi.sock --module app --callable run"]
# Set the default command to execute
# when creating a new container
