#/bin/bash
COOKIE= $(xauth list| awk 'NR==1')
CONTAINER_ID=$(sudo docker ps -a |grep "ip-camera" | awk '{print $1}')
#####################################################################
echo "Cookie="$COOKIE
echo "Container ID="$CONTAINER_ID
#####################################################################
sudo docker exec $CONTAINER_ID touch /root/.Xauthority
sudo docker exec $CONTAINER_ID xauth add $COOKIE