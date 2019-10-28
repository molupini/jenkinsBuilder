# base
FROM python:3.8-buster as base

ENV PORT=8080
EXPOSE ${PORT}

WORKDIR /bin/app

# dev
FROM base as dev

# CMD [ "/bin/bash" ]

# prod
FROM base as prod

COPY ./build/. .

# CMD [ "/bin/bash" ]
