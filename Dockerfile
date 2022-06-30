# Execute it with
# "sudo docker run -it --net=host -e DISPLAY -v /tmp/.X11-unix ip-camera bash"
FROM ubuntu:latest

ENV HOME /root
WORKDIR /root
RUN apt update
RUN apt -y install --fix-missing
RUN apt -y install --fix-missing nano cmake openssh-server
RUN apt -y install --fix-missing python3.10
RUN apt -y install --fix-missing gnome-terminal
RUN apt -y install --fix-missing x11-apps xauth net-tools
##########################################
COPY People-Counting-in-Real-Time-master /home/People-Counting-in-Real-Time-master
RUN apt -y install python3-pip
RUN pip3.10 install -r /home/People-Counting-in-Real-Time-master/requirements.txt
#RUN apt -y install --no-install-recommends psutils
#COPY forDate.sh /home/forDate.sh
RUN apt -y install --fix-missing nmap telnet
################  Lynx Browser Install ###########
RUN apt -y install --fix-missing lynx
################  Brave Browser Install ###########
#RUN apt install apt-transport-https curl
#RUN curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
#RUN echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|tee /etc/apt/sources.list.d/brave-browser-release.list
#RUN apt update
#RUN apt install brave-browser
###################################################################################
RUN echo "Change This String to Push Local/Host Changes to Containers"
COPY sshd_config /etc/ssh/sshd_config
RUN service ssh restart
COPY People-Counting-in-Real-Time-master /home/People-Counting-in-Real-Time-master
##########################################
RUN echo "root:root" | chpasswd
#SHELL ["/bin/bash", "-o", "pipefail", "-c"]

EXPOSE 8887
#ENTRYPOINT /bin/bash
CMD firefox
