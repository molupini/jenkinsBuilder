# TODO VERIFY IF NECEASSARY DOCKER FILE AS BLUE.DOCKERFILE DOES SUPERSEED
# > REMOVE WHEN PRODUCTION CODE IS RELEASED 

FROM hashicorp/terraform:full as base

# ARG ACCESS_KEY
# ARG SECRET_KEY
# ARG AWS_REGION

ENV TF_IN_AUTOMATION=false
ENV BUCKET=bkt-automation-tmp.state
ENV DYNAMODB_TABLE=dyn-automation-tmp.state
# ENV AWS_ACCESS_KEY=${ACCESS_KEY}
# ENV AWS_SECRET_KEY=${SECRET_KEY}
# ENV AWS_REGION=${AWS_REGION}

RUN apk add python3

RUN pip3 install requests

RUN pip3 install fire

RUN pip3 install awscli

RUN apk add --no-cache tini

WORKDIR /terraform/app

ENTRYPOINT ["/sbin/tini", "--"]


# backend state config 
FROM base as state

COPY ./build/. .

WORKDIR /terraform/app/state

RUN terraform init

# RUN terraform plan -var "aws_access_key=${ACCESS_KEY}" -var "aws_secret_key=${SECRET_KEY}" -var "aws_region=${AWS_REGION}" -var-file="../pre/basic.tfvars.json" -var-file="deployment.tfvars.json"

# RUN terraform apply "terraform.tfplan"


# Development 
FROM base as dev

# COPY ./build/. .

CMD [ "/bin/bash" ]


# Prodution, comment out below for testing with compose file.
FROM base as prod

COPY ./build/. .

CMD [ "/bin/bash" ]
