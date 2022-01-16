#!/bin/bash

# Allow X server connection
xhost +local:root

# Run script
cd /home/Kimera-VIO
./scripts/stereoVIOEuroc.bash -p "/root/Euroc/V1_01_easy"

# Disallow X server connection
xhost -local:root
