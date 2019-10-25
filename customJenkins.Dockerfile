# base
FROM python:3.8-buster as base
# FROM ubuntu:18.04

ENV PORT=8080
EXPOSE ${PORT}

# RUN pip3 install requests
# RUN pip3 install fire
# RUN pip3 install awscli

# RUN apt-get update && apt-get install default-jre -y 
# RUN apt-get update && apt-get install default-jdk -y

# RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -
# RUN echo "deb https://pkg.jenkins.io/debian binary/" >> /etc/apt/sources.list
# RUN apt-get update && apt-get install jenkins && apt-get clean


WORKDIR /terraform/app

# dev
FROM base as dev

# RUN service jenkins start
# CMD [ "/bin/bash" ]

# prod
FROM base as prod

COPY ./build/. .
RUN service jenkins start

# CMD [ "/bin/bash" ]
