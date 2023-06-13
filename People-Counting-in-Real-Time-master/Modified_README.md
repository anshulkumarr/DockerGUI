## Running Inference
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
python Run.py --prototxt mobilenet_ssd/MobileNetSSD_deploy.prototxt --model mobilenet_ssd/MobileNetSSD_deploy.caffemodel
```
> Set url = 0 for webcam.