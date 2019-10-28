FROM jenkinsci/blueocean:latest as base

ENV PORT=8080
ENV TERRAFORM_INST_VERSION=0.12.12
ENV PACKER_INST_VERSION=1.4.4
ENV TZ=Africa/Johannesburg

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

# TODO PLUGIN SPECIFIC SCRIPTS, WHEN PRODUCTION RELEASE WILL NEED TO ENSURE ALL IS AUTOMATED
# RUN /usr/local/bin/install-plugins.sh terraform 
# ansicolor blueocean nodejs oauth-credentials

# TODO TINI FOR CLEAN SHUTDOWNS, VERIFY IF NECESSARY 
# VERIFY IF NECESSARY
# RUN apk add --no-cache tini

# WORKDIR /terraform/app
# ENTRYPOINT ["/sbin/tini", "--"]

USER jenkins


# dev
FROM base as dev

WORKDIR /terraform/app

# CMD [ "/bin/bash" ]


# prod
FROM base as prod

WORKDIR /terraform/app

COPY --chown=jenkins:jenkins ./build/. .
COPY ./build/. .

# CMD [ "/bin/bash" ]
