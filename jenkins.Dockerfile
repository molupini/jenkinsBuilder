# TODO VERIFY IF NECEASSARY DOCKER FILE AS BLUE.DOCKERFILE DOES SUPERSEED
# > REMOVE WHEN PRODUCTION CODE IS RELEASED 

FROM jenkins/jenkins:lts as base

ENV PORT=8080
EXPOSE ${PORT}

# CUSTOM SOFTWARE INSTALLATION
USER root

RUN apt-get update && apt-get install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget -y

# TODO COPY IF ABOVE FAILS TO PULL FROM SOURCE 
# RUN curl -O https://www.python.org/ftp/python/3.7.5/Python-3.7.5.tar.xz
COPY ./.pkg/. .
RUN tar -xf Python-3.7.5.tgz
WORKDIR /Python-3.7.5
RUN ./configure --enable-optimizations
RUN make -j 8
# RUN make altinstall

# PLUGIN SPECIFIC SCRIPTS 
# RUN /usr/local/bin/install-plugins.sh terraform 
# ansicolor blueocean nodejs oauth-credentials

# TODO Need tini for clean shutdowns

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
