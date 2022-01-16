# Instructions on how to run Kimera-VIO

## Run with euroc dataset

``` bash
# 1. Build the docker image from Dockerfile.testing
(host) >>> cd Kimera-VIO
(host) >>> docker build --rm -t kimera_vio -f ./scripts/docker/Dockerfile.testing .

# 2. Start X11 server (for windows)
(user) >>> Go download vcxsrv
(user) >>> Start XLaunch
(user) >>> Uncheck "native opengl" (optional) and check "disable access control"
(user) >>> Firewall needs to enable application through both private and public networks
(user) >>> Save configuration so that opening the configuration file would enable it

# 3. Run image (with docker_img_scripts.sh)
(user) >>> Find the "Display IP address" - check the section below. Replace the below DISPLAY command with the IP address found.
(host) >>> docker run --rm -it --ipc=host --net=host --privileged -e DISPLAY=192.168.48.1:0.0 -v /tmp/.X11-unix:/tmp/.X11-unix:rw  kimera_vio

# 3. Run image (open terminal instance for debugging)
(host) >>> docker run --rm -it --ipc=host --net=host --privileged -e DISPLAY=192.168.48.1:0.0 -v /tmp/.X11-unix:/tmp/.X11-unix:rw  kimera_vio /bin/bash

##### Only for terminal instance #####

# 4. Enable xhost in the image
(image) >>> xhost +local:root

# 5. Run script
(image) >>> cd /home/Kimera-VIO
(image) >>> bash ./scripts/stereoVIOEuroc.bash -p "/root/Euroc/V1_01_easy"

# 6. Disable xhost as cleanup
(image) >>> xhost -local:root
```

## Debug

### X11 server

X server is needed to enable GUI applications in a docker container.

``` bash
vtkXOpenGLRenderWindow (0x55864ad647d0): bad X server connection. DISPLAY=172.25.80.1:0.0. Aborting.
```

This means that the X11 server is not setup properly. Check the following:

1. In the image, DISPLAY env var is set to the correct IP address. Go check [display IP address](#display-ip-address).
2. On host, need enable both private and public networks access for firewalll.
3. On host, XLaunch need check `disable access control`.

### xhost command

When running xhost, if it does not print:

``` bash
non-network local connections being added to access control list
```

Run

``` bash
(image) >>> strace xhost + | tail -10
```

You will likely see that it is trying to establish a connection. This means that X11 server is not configured correctly. Go check [X11 server](#x11-server).

### Display IP address

To find out the correct IP address run:

``` bash
(image) >>> export DISPLAY=$(ip route | awk '/^default/{print $3; exit}'):0.0
```

Or:

``` bash
(host) >>> ipconfig
(user) >>> Look at the ip address listed under "(WSL)"
```

Try both methods.

### Additional debug tools

Run the following to install X-apps for debugging.

``` bash
sudo apt-get install x11-apps -y
```

Now we can debug with the X-apps (`xeyes`, `xcalc`, etc)
