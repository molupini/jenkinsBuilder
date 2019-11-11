FROM jenkinsci/blueocean:latest as base

ENV PORT=8080
ENV TERRAFORM_INST_VERSION=0.12.13
ENV PACKER_INST_VERSION=1.4.4
ENV TZ=Africa/Johannesburg
ENV ROOT_EMAIL=maurizio.lupini@bcx.co.za

EXPOSE ${PORT}

# CUSTOM SOFTWARE INSTALLATION
USER root

WORKDIR /usr/local/bin/
RUN apk add python3
RUN pip3 install requests
RUN pip3 install fire
RUN pip3 install awscli

# TERRAFORM DOWNLOAD AND INSTALLATION 
# https://releases.hashicorp.com
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_INST_VERSION}/terraform_${TERRAFORM_INST_VERSION}_linux_amd64.zip
RUN unzip terraform_${TERRAFORM_INST_VERSION}_linux_amd64.zip 
RUN wget -q https://releases.hashicorp.com/packer/${PACKER_INST_VERSION}/packer_${PACKER_INST_VERSION}_linux_amd64.zip
RUN unzip packer_${PACKER_INST_VERSION}_linux_amd64.zip 

# GIVE JENKINS USER ACCESS TO JENKINS_HOME 
# RUN chown -R jenkins:jenkins /var/jenkins_home

WORKDIR /var/jenkins_home/workspace

# SWITCH TO DEFAULT USER
USER jenkins


# dev
FROM base as dev

# CMD [ "/bin/bash" ]


# prod
FROM base as prod

# CMD [ "/bin/bash" ]
