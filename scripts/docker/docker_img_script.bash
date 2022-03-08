#!/bin/bash
# This script takes in 1 argument:
#   - path to Kimera-VIO folder

kimera_vio_path=$1

# Allow X server connection
xhost +local:root

# Run script
cd $kimera_vio_path
# ./scripts/stereoVIOEuroc.bash -p "/root/Euroc/V1_01_easy"
# ./scripts/stereoVIOEuroc.bash -p "/root/euroc"
./scripts/monoVIOEuroc.bash -p "/root/euroc"

# Disallow X server connection
xhost -local:root
