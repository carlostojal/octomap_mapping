octomap_mapping ![CI](https://github.com/OctoMap/octomap_mapping/workflows/CI/badge.svg)
===============

ROS stack for mapping with OctoMap, contains the `octomap_server` package.

The main branch for ROS1 Kinetic, Melodic, and Noetic is `kinetic-devel`.

The main branch for ROS2 Foxy and newer is `ros2`.

This fork implements OctoMap clearing each time a new pointcloud arrives, to make the illusion of a robot-centered OctoMap. Not optimal performance wise, but accomplishes our need.

## Docker
- Install Docker. It is recommended to follow the official documentation.
- Setup the NVIDIA Container Toolkit for Docker ([guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#install-guide)).
- Make any changes you want to the configuration on the corresponding launch file `my_octomap.launch`.
- From this directory, run the command ```docker build -t octomap_mapping .```. This may take a while, just wait. It will install all the dependencies and build the core library, install it, and build the package.
- You can start the container with the running nodes with `docker run --rm --runtime=nvidia --gpus all --network=host -it octomap_mapping`.