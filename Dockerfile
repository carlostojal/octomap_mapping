FROM ros:noetic-ros-base

# environment variables
ENV DEBIAN_FRONTEND=noninteractive

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