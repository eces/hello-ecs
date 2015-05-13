FROM centos:6
MAINTAINER Jinhyuk Lee <jhlee@yellomobile.com>
 
# install git
RUN yum install -y git

# install node
RUN curl -sL https://rpm.nodesource.com/setup | bash -
RUN yum install -y nodejs

# install global npm dependencies
RUN npm install -g grunt-cli
RUN npm install -g bower
RUN npm install -g forever

# Define mountable directories.
# VOLUME ["/app"]

# Define working directory.

RUN git clone https://github.com/eces/hello-ecs.git --branch master /app

WORKDIR /app

RUN npm install

# Define default command.
CMD ["/bin/bash"]

ENTRYPOINT ["DEBUG=hello-ecs:*", "./bin/www"]

EXPOSE 9000