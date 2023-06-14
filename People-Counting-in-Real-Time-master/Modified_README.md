## Running Inference
If you want to run the application on local machine, run through following commands:
- Install all the required Python dependencies:
```
pip install -r requirements.txt
```
- To run inference on a test video file, head into the directory/use the command: 
```
python Run.py --prototxt mobilenet_ssd/MobileNetSSD_deploy.prototxt --model mobilenet_ssd/MobileNetSSD_deploy.caffemodel --input videos/example_01.mp4
```
> To run inference on an IP camera:
- Setup your camera url in 'mylib/config.py':

```
# Enter the ip camera url (e.g., url = 'http://191.138.0.100:8040/video')
url = ''
```
- Then run with the command:
```
python3 Run.py --prototxt mobilenet_ssd/MobileNetSSD_deploy.prototxt --model mobilenet_ssd/MobileNetSSD_deploy.caffemodel
```
> Set url = 0 for webcam.


If you want to run it as a docker container, run through following commands:
- To create docker image from docker file, run the following command:
```
sudo docker -t build <image-name> .
```

- To check all the docker images, run the following command:
```
sudo docker images
```

- To run the docker image, run the following command:
```
sudo docker run <image-id> 
```
- After you run the docker image, go to mylib/config.py and change the IP address to the IP address of the camera being used.

- Then run with the command:
```
python3 Run.py --prototxt mobilenet_ssd/MobileNetSSD_deploy.prototxt --model mobilenet_ssd/MobileNetSSD_deploy.caffemodel
```
