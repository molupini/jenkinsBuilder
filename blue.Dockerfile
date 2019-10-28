FROM jenkinsci/blueocean:latest as base

ENV PORT=8080
ENV TZ=Africa/Johannesburg

EXPOSE ${PORT}

# CUSTOM SOFTWARE INSTALLATION
USER root

RUN apk add python3
RUN pip3 install requests
RUN pip3 install fire
RUN pip3 install awscli

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
