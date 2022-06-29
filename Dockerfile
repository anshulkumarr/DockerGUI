FROM ubuntu:latest

ENV HOME /root
WORKDIR /root
RUN apt update
RUN apt install --fix-missing
RUN apt install -y --no-install-recommends nano cmake
RUN apt install -y --no-install-recommends firefox
RUN apt install -y --no-install-recommends python3.10
COPY People-Counting-in-Real-Time-master /home/People-Counting-in-Real-Time-master
RUN apt install -y python3-pip
RUN pip3.10 install -r /home/People-Counting-in-Real-Time-master/requirements.txt
RUN apt install -y --no-install-recommends gnome-terminal
RUN apt install -y --no-install-recommends openssh-server
RUN apt install -y x11-apps
RUN apt-get -y install xauth
#RUN apt-get install -y --no-install-recommends psutils
#COPY forDate.sh /home/forDate.sh
#subhrendu-HP-ProDesk-600-G2-SFF/unix:  MIT-MAGIC-COOKIE-1  7faa42a057346e7ed3a1c0b941e0f259
#########################################################################################

EXPOSE 8887
#ENTRYPOINT /bin/bash
CMD firefox
