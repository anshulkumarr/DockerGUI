# Execute it with
# "sudo docker run -it --name ip_camera --user $(id root -u):$(id root -g) -p 5901:5901 -p 6901:6901 consol/ubuntu-xfce-vnc bash"
FROM consol/ubuntu-xfce-vnc
USER root
ENV HOME /headless
#WORKDIR /root
RUN apt -y purge python2.7 python3.5
RUN apt update
RUN apt -y install --fix-missing
RUN apt -y install --fix-missing nano cmake openssh-server
RUN apt -y install --fix-missing x11-apps xauth net-tools
RUN apt -y autoremove
################  Python & Modules Install ###########
RUN apt -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget
COPY Python-3.7.4.tgz /headless/Python-3.7.4.tgz
#RUN wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz
RUN tar xzf Python-3.7.4.tgz
RUN cd Python-3.7.4; ./configure; make; make install
COPY People-Counting-in-Real-Time-master /headless/People-Counting-in-Real-Time-master
#RUN pip3.7 cache purge
RUN pip3.7 install --upgrade pip setuptools wheel
RUN pip3.7 install --no-cache-dir argparse		#1.4.0
RUN pip3.7 install --no-cache-dir schedule		#1.2.0
RUN pip3.7 install --no-cache-dir numpy			#1.21.6
RUN pip3.7 install --no-cache-dir opencv-python	#4.7.0.72
RUN pip3.7 install --no-cache-dir scipy			#1.7.3
RUN pip3.7 install --no-cache-dir imutils		#0.5.4
#RUN pip3.7 install --no-cache-dir dlib			#19.24.0
#RUN pip3.10 install --no-cache-dir -r /headless/People-Counting-in-Real-Time-master/requirements.txt
################  Debug Tools Install ###########
RUN apt -y install --no-install-recommends psutils
#COPY forDate.sh /home/forDate.sh
RUN apt -y install --fix-missing nmap telnet
RUN apt -y install --fix-missing lynx
RUN apt -y install --fix-missing gdb
#RUN apt -y install --fix-missing python3.7-dbg
RUN apt -y install --fix-missing xterm
################  Brave Browser Install ###########
#RUN apt install apt-transport-https curl
#RUN curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
#RUN echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|tee /etc/apt/sources.list.d/brave-browser-release.list
#RUN apt update
#RUN apt install brave-browser
###################################################################################
RUN echo "Change This String to Push Local/Host Changes to Containers"
COPY sshd_config /etc/ssh/sshd_config
#RUN service ssh restart
COPY People-Counting-in-Real-Time-master /headless/People-Counting-in-Real-Time-master
##########################################
COPY startPeopleCount.sh /headless/startPeopleCount.sh
##########################################
COPY dlib /headless/dlib
RUN mkdir /headless/dlib/build
RUN cd /headless/dlib/build; cmake ..; cmake --build .; cd ..; python3.7 setup.py install --no USE_AVX_INSTRUCTIONS --no DLIB_USE_CUDA
##########################################
RUN echo "root:root" | chpasswd
#SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo "root:root" > /etc/ssh/ssh
EXPOSE 8887
CMD ['service', 'ssh', 'restart']
WORKDIR "/headless"
CMD ["--wait"]
Entrypoint ["/dockerstartup/vnc_startup.sh"]
RUN echo "python3 Run.py --prototxt mobilenet_ssd/MobileNetSSD_deploy.prototxt --model mobilenet_ssd/MobileNetSSD_deploy.caffemodel" > /headless/People-Counting-in-Real-Time-master/run.sh
# `cd /home/People-Counting-in-Real-Time-master; python3 Run.py --prototxt mobilenet_ssd/MobileNetSSD_deploy.prototxt --model mobilenet_ssd/MobileNetSSD_deploy.caffemodel`
