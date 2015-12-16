# Debian - Python - Nginx

This is the repo for running a python app under `nginx` in a docker container

Many of the docker repo's out there use flask local server in their images.
This repo is for a more production ready environment.

This repo will be built in stages
It will contain a demo app written using the Flask framework

I will be using [this Flask app](http://code.tutsplus.com/tutorials/an-introduction-to-pythons-flask-framework--net-28822) for the repo

## Dockerfile
 * copy nginx key
 * add update sources
 * update and install dependencies

 * copy requirements.txt
 * install pip dependencies
 * copy files across:
    * module file `run.py`
    * uwsgi ini file `uwsgi.ini`
    * nginx config file `app.conf`
    * starting script `start.sh`
* rm nginx default configuration
* simlink `app.conf` to nginx configuration `/etc/nginx/conf.d/`
* copy app
* make `start.sh` executable
* set workdir
* expose port 80
* run cmd