Docker-RRO
==========

This repo currently contains a Docker file for Revolution R Open on Ubuntu 14.04  

[https://registry.hub.docker.com/u/revolutionanalytics/rro-ubuntu/](https://registry.hub.docker.com/u/revolutionanalytics/rro-ubuntu/)  

For more information please visit the MRAN web site:  
http://mran.revolutionanalytics.com/open

# Installation
Check if docker is running:

    make setup

To build and run the container do

    make run

this will build the container and starts it. The first time you do this it might take a while, as docker needs to download some base images. 

If you only want to build the container and not yet run it, use the

    make build

command.

# Usage
Once the container is build it can be quickly started and stopped thourgh the

    make start

and

    make stop

commands.

RStudio server can now be reached on **http://localhost:8787** (note: on MacOS localhost needs to be replaced with de boot2docker ip), to login use **login: docker** and **password: docker**.

The default directory that is shared with the container is **$HOME/Rdata**.

The port settings and shared directory can be modified in the Makefile. 
