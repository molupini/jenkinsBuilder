# Jenkins IaC Builder

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/)

Is a Infrastructure as Code Builder Pipeline Service.
Powered by Jenkins and Terraform.

  - Deploy with docker-compose 
  - Login to Jenkins
  - Use build pipelines

# Features

You can:
  - Build, release infrastructure
  - Life-cycle management
  

# Tech

iac-builder uses a number of open source projects to work properly:

* [python] - programming language. 
* [jenkins] - open source continuous integration and continuous delivery, automation tool.
* [terraform] - open-source infrastructure as code software tool.

# Installation


#### Install

Open your favorite Terminal and run these commands.

First, if necessary:
```sh
$ mkdir ./iac
```
Second:
```sh
$ git init
```
Third:
```sh
$ git clone git@gitlab.com:bcx-sanlam-group/iacbuilder.git
```

Forth:
```sh
$ mkdir ./.jenkins_vol
$ mkdir ./.sock
```

#### Author

Making any change in your source file will update immediately.

Before we begin, required environment variables:
```sh
$ vi ./.env/app.development.env

# # JENKINS
TZ=Africa/Johannesburg

# # JENKINS, TERRAFORM
AWS_ACCESS_KEY=?
AWS_SECRET_KEY=?
AWS_REGION=eu-west-1

# # JENKINS SERVICE, PYTHON SCRIPTS, NAME SERVICE
IAC_ENDPOINT_PROTOCOL=http
IAC_ENDPOINT_HOSTNAME=192.168.88.13
IAC_ENDPOINT_PORT=3001
```


### Deploy

Easily done in a Docker container.
Make required changes within Dockerfile + compose files if necessary. When ready, simply use docker-compose to build your environment.
This will create the *iac-ocean-blue, ...* services with necessary dependencies.
Once done, simply import postman.json into Postman:

For dev, docker compose:
```sh
$ docker-compose build
$ docker-compose up
```

Verify the deployment by navigating to your address in your preferred browser. Enter the password in the requested location. 
```sh
$ curl http://localhost:8080
$ docker-compose exec iac-ocean-blue cat /var/jenkins_home/secrets/initialAdminPassword
```

For prod, build:
```sh
$ docker build -f blue.Dockerfile -t mauriziolupini/iac-ocean-blue:prod .
```

Commit prod, push docker builds:
```sh
$ docker push mauriziolupini/iac-ocean-blue:prod
```

Get prod, pull docker builds:
```sh
$ docker pull mauriziolupini/iac-ocean-blue:prod
```

Run prod, either docker run:
```sh
docker network create --driver bridge jenkins_network
docker run -d --net=iac_network --name iac-mongo --hostname iac-mongo -e "AWS_ACCESS_KEY=" -e "AWS_SECRET_KEY=" -e "AWS_REGION=" -e "IAC_ENDPOINT_PROTOCOL=" -e "IAC_ENDPOINT_HOSTNAME=" -e "IAC_ENDPOINT_PORT=" -p 8080:8080 mauriziolupini/iac-ocean-blue:prod
```

Run prod, or docker swarm:
```sh
docker stack deploy -c iacbuilder.yml IAC
```


#### Kubernetes + Google Cloud

See [KUBERNETES.md] coming soon.


# Future Release

  - TBD.


### Instructions

#### GIT
*POST BUILD REQUIREMENT*

[git] is a distributed version-control system for tracking changes in source code during software development.
Pre-installed within *iac-ocean-blue, ...* will require ssh authentication. Follow, https://docs.gitlab.com/ee/ssh/ 
Used majority of pipeline(s). 

Option 1. 
New ssh key *must add to added to git repository*, local machine
See example below, preferred

```sh
$ ssh-keygen -t rsa -b 4096 -C "maurizio.lupini@bcx.co.za" -f ./.key/service_id_rsa
$ xclip -sel clip < ./.jenkins_vol/.ssh/service_id_rsa.pub
$ docker cp .key/. iacbuilder_iac-ocean-blue_1:/root/.ssh/.
```

Option 2. 
Existing ssh key *must add to added to git repository*, copy to container
See example below 
```sh
$ docker cp ./.key/. iacbuilder_iac-ocean-blue_1:/var/jenkins_home/.ssh/.
```

# License

MIT


# Author
**Want to contribute? Great! See repo [git-repo-url] from [Maurizio Lupini][mo]    -Author, Working at [...][linkIn]**


   [mo]: <https://github.com/molupini>
   [linkIn]: <https://za.linkedin.com/in/mauriziolupini>
   [git-repo-url]: <https://gitlab.com/bcx-sanlam-group/nameservice.git>
   [python]: <https://www.python.org/>
   [jenkins]: <https://jenkins.io/
   [terraform]: <https://www.terraform.io/>
   [git]: <https://git-scm.com/>