#!/bin/bash
SHORT=d:,h
LONG=daemon:,help
OPTS=$(getopt --alternative --name weather --options $SHORT --longoptions $LONG -- "$@") 
eval set -- "$OPTS"

while :
do
  case "$1" in
    -d | --daemon )
      headless="$1"
      shift 2
      ;;
    -h | --help)
      "Use this script to launch the camera micro-service container, Use -d/--daemon flag for headless mode."
      exit 2
      ;;
    --)
      shift;
      break
      ;;
    *)
      echo "Unexpected option: $1"
      ;;
  esac
done

if [[ $headless = "--daemon" ||  $headless = "-d" ]];
then
	echo "Launch container in headless mode"
	sudo docker run -d --name ip_camera --user $(id root -u):$(id root -g) -p 5901:5901 -p 6901:6901 ip-camera:latest
else 
	echo "Launch container with console"
	sudo docker run -it --name ip_camera --user $(id root -u):$(id root -g) -p 5901:5901 -p 6901:6901 ip-camera:latest bash
fi



