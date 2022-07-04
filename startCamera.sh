#!/bin/bash
sudo docker run -it --name ip_camera --user $(id root -u):$(id root -g) -p 5901$


