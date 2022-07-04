# List of Useful Docker commands 
## Create Docker Images
### Create docker Image from dockerhub
`sudo docker pull <DockerfileName>`
### Create docker Image from Docker file
`sudo docker build <Dockerfile Location> -t <ImageName>`

## Docker Start up
### Docker Start up without TTY (Background)
`sudo docker run -d <ImageName>`
### Basic start up with TTY attached
`sudo docker run --name <InstanceName> -it <EntryPointCMD>`
### Docker Start up with specific TTY (e.g. stdin/stdout/stderr) attached
`sudo docker run -a stdin -a stdout -i -t <ImageName> <CMD>`
### Docker Exec a command
`sudo docker exec <InstanceName/ID> -it <CMD>`
### Start up with a name
`sudo docker run -it --name <InstanceName/ID> <ImageName> <EntryPointCMD>`
### Start with common PID namespace
`sudo docker run -it --name <InstanceName/ID> --pid=host <ImageName> <EntryPointCMD>`
### Start with common IPC
`sudo docker run -it --name <InstanceName/ID> --ipc=host <ImageName> <EntryPointCMD>`

## Docker monitoring
### list of all Instances
`sudo docker ps -a`
### List of process(es) running inside container
`sudo docker top <InstanceName/ID>`

## Docker with X11
### Without python support
* In Host `xauth list| awk 'NR==1'` to get the COOKIE
* In container 
	- `touch /root/.Xauthority`
	- `xauth add <COOKIE>`
	- `xauth list`

### Alternate
`sudo python3 -m pip install dockerx --user`
`sudo python3 -m dockerx.run --image <ImageName> --command 'sleep infinity'`

## Docker termination
### Kill "Exited" Instances
`sudo docker ps -a |grep Exited |awk '{ print $1 }' > /tmp/out.tmp ; xargs --null sudo docker rm < <(tr \\n \\0 </tmp/out.tmp)`
### Terminate and remove an Instance
`sudo docker kill <InstanceName/ID>; sudo docker rm <InstanceName/ID>`
### Terminate and remove all Instances
`sudo docker kill $(sudo docker ps -q); sudo docker rm $(sudo docker ps -a -q)`


****
## Container ip-camera setup
### Build
* `cd DockerGUI`
* `sudo docker build -t ip-camera .`
### Run
* `sudo docker run -d -p 5901:5901 -p 6901:6901 consol/ubuntu-xfce-vnc`
* `sudo docker run -it --name ip_camera --net=host -e DISPLAY -v /tmp/.X11-unix ip-camera bash`
* `sudo docker run -it --name ip_camera --user $(id root -u):$(id root -g) -p 5901:5901 -p 6901:6901 ip-camera:latest bash`
* `sudo docker run -it --name ip_camera --net=host --user $(id root -u):$(id root -g) --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" ip-camera bash`
### Save image in Source PC
* `sudo docker save ip-camera:latest > ip-camera.tar`
### Load image at Target PC
* `sudo docker load < ip-camera.tar`
### SSH to container
### For each container run
* @Container `echo "root:root" | chpasswd`
* @Container `service ssh restart` or @Host `sudo docker exec ip_camera service ssh restart`
### IP Camera app deployment
* `ssh root@<HOST_IP> -p 8887 -X`
* `cd /home/People-Counting-in-Real-Time-master`
* `python3 Run.py --prototxt mobilenet_ssd/MobileNetSSD_deploy.prototxt --model mobilenet_ssd/MobileNetSSD_deploy.caffemodel`