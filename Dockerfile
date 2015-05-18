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

WORKDIR /app

RUN mkdir -p /root/.ssh/
ADD ssh/ /root/.ssh/
# RUN touch /root/.ssh/known_hosts
RUN chmod -R 600 /root/.ssh/

# RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN git clone https://github.com/eces/hello-ecs.git --branch master /app

WORKDIR /app

RUN npm install

RUN export DEBUG=hello-ecs:*

CMD ["/bin/bash"]

ENTRYPOINT npm start

EXPOSE 9000