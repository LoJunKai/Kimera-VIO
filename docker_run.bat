
docker build --rm -t kimera_vio -f ./scripts/docker/Dockerfile.initialise .
docker run --rm -it --ipc=host --net=host --privileged -e DISPLAY=169.254.220.85:0.0 -v /tmp/.X11-unix:/tmp/.X11-unix:rw  kimera_vio
@REM docker run --rm -it --ipc=host --net=host --privileged -e DISPLAY=192.168.48.1:0.0 -v /tmp/.X11-unix:/tmp/.X11-unix:rw  kimera_vio /bin/bash