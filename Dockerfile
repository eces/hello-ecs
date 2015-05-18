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

ADD .ssh/ /root/.ssh/

RUN ls -alF /root/.ssh

RUN eval "$(ssh-agent -s)"
RUN chown -R root:root /root/.ssh/
RUN chmod -R 600 /root/.ssh/
RUN ssh-add /root/.ssh/id_circleci_github
RUN ssh -T git@github.com

RUN git clone git@github.com:eces/hello-ecs.git --branch master /app

WORKDIR /app

RUN npm install

RUN export DEBUG=hello-ecs:*

CMD ["/bin/bash"]

ENTRYPOINT npm start

EXPOSE 9000


# RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
# RUN echo "IdentityFile /root/.ssh/*" >> /etc/ssh/ssh_config
# RUN echo "Host *\n\tIdentityFile /root/.ssh/*" >> /etc/ssh/ssh_config
# RUN restorecon -Rv ~/.ssh
# RUN restorecon -Rv /root/.ssh

# docker run -it -v $(pwd)/.ssh:/root/.ssh centos:6 /bin/bash
# ssh -T git@github.com