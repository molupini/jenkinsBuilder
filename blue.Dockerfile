FROM jenkinsci/blueocean:latest as base

# ARGS
ARG PORT=8080
ARG TERRAFORM_INST_VERSION=0.12.20
ARG PACKER_INST_VERSION=1.5.0
ARG TZ=Africa/Johannesburg
ARG ROOT_EMAIL=molupini.dev@gmail.com

# ENV
ENV PORT=${PORT}
ENV TERRAFORM_INST_VERSION=${TERRAFORM_INST_VERSION}
ENV PACKER_INST_VERSION=${PACKER_INST_VERSION}
ENV TZ=${TZ}
ENV ROOT_EMAIL=${ROOT_EMAIL}

EXPOSE ${PORT}

# CUSTOM SOFTWARE INSTALLATION
USER root

WORKDIR /usr/local/bin/
RUN apk add python3
RUN apk add docker
RUN pip3 install requests
RUN pip3 install fire
RUN pip3 install awscli
RUN pip3 install boto3

# TERRAFORM DOWNLOAD AND INSTALLATION 
# https://releases.hashicorp.com
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_INST_VERSION}/terraform_${TERRAFORM_INST_VERSION}_linux_amd64.zip
RUN unzip terraform_${TERRAFORM_INST_VERSION}_linux_amd64.zip 
RUN wget -q https://releases.hashicorp.com/packer/${PACKER_INST_VERSION}/packer_${PACKER_INST_VERSION}_linux_amd64.zip
RUN unzip packer_${PACKER_INST_VERSION}_linux_amd64.zip 

# IMPORTANT REQUIRED FOR CLEAN INSTALL
# GIVE JENKINS USER ACCESS TO JENKINS_HOME 
# RUN chown -R jenkins:jenkins /var/jenkins_home

# GIVE JENKINS USER PERMISSION TO RUN DOCKER COMMENDS
RUN adduser jenkins docker
# NEED TO ADD BELOW AND ABOVE TO BASH START SEE FOLLOWING
# https://forums.docker.com/t/how-can-i-run-docker-command-inside-a-docker-container/337/11
RUN echo "chown -R jenkins:jenkins /var/run/docker.sock" >> /etc/profile

WORKDIR /var/jenkins_home/workspace

# SWITCH TO DEFAULT USER
USER jenkins

# dev
FROM base as dev
# CMD [ "/bin/bash" ]


# prod
FROM base as prod
# CMD [ "/bin/bash" ]
