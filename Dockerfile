FROM carlostojal/cuda-ros:noetic-cuda12.1.1-ubuntu20.04

# environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
ENV PATH=/usr/local/cuda/bin:$PATH

# install dependencies
RUN apt update
RUN apt install -y \
    build-essential \
    python3 \
    python3-catkin-tools \
    python3-rosdep \
    vim \
    git \
    xauth \
    wget

# init rosdep
RUN rosdep init
RUN rosdep update

# copy the ros package and build it
RUN mkdir -p /catkin_ws/src
COPY . /catkin_ws/src
WORKDIR /catkin_ws
# install dependencies
RUN rosdep install --from-paths /catkin_ws --ignore-src --rosdistro noetic -y
# build
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
    cd /catkin_ws && \
    catkin_make"

# launch the aggregator
CMD /bin/bash -c "source /opt/ros/noetic/setup.bash && \
    source /catkin_ws/devel/setup.bash && \
    roslaunch octomap_server my_octomap.launch"