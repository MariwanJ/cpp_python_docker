#Import Ubuntu image
FROM ubuntu:latest


# update REPO
RUN apt-get update

# Install C and C++ compilers
RUN   apt-get update &&  apt-get install -y build-essential


# Install Python and pip
RUN  apt-get install -y python3 python3-pip


# Install Premake5
RUN  apt-get install -y wget && \
    wget https://github.com/premake/premake-core/releases/download/v5.0.0-alpha15/premake-5.0.0-alpha15-linux.tar.gz && \
    tar -xzf premake-5.0.0-alpha15-linux.tar.gz && \
    mv premake5 /usr/local/bin && \
    rm premake-5.0.0-alpha15-linux.tar.gz

# Install FLTK
RUN apt-get install -y libfltk1.3-dev

# install X server
RUN apt-get install -y libxrender-dev libx11-6 libxext-dev libxinerama-dev libxi-dev libxrandr-dev libxcursor-dev libxtst-dev tk-dev && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the application files
COPY . /app

# Generate the Makefile and project files using Premake5
RUN premake5 gmake2

# Build the application
RUN make 

#To build the docker run the folowing command, change DOCKER_FILE_NAME AND TAG to what your desired values : 
#  docker build -t DOCKER_FILE_NAME:TAG
# to run Xming : go to the path of Xming and run : Xming.exe -ac 
# Then to run the docker : Write the folowing command . Change MACHINE_IP to the computer IP, and IMAGENAME:TAG to the docker image name and tag
#  docker run -it --rm -e DISPLAY=MACHINE_IP:0.0 --network="host" --name gui_container IMAGENAME:TAG


# Define the command to run
# CMD ["ls"]