# Jenkins Container Service

Powered by Jenkins.

  - Deploy with docker-compose 
  - Login to Jenkins
  - Use build pipelines

## Features

You can:
  - Easy Configuration
  - Available Plugins
  - Extensible
  - Easy Distribution
  - Free Open Source
  
## Tech

Uses a number of open source projects to work properly:

* [jenkins] - open source continuous integration and continuous delivery, automation tool.

## Installation

#### Install

Open your favorite Terminal and run these commands.

First, if necessary:
```sh
$ mkdir ./cicd 
```
Second:
```sh
$ git cicd
```
Third:
```sh
$ git clone git@github.com:molupini/jenkinsBuiler.git
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
$ vi ./.env/app.env
# # TERRAFORM
# SEED DOCKER FILE

# # JENKINS
TZ=Africa/Johannesburg

# # AWS
AWS_ACCESS_KEY=?
AWS_SECRET_KEY=?
AWS_REGION=?

# # PYTHON SCRIPTS, WEB SERVICES FOR IAC BUILDS 
IAC_ENDPOINT_PROTOCOL=?
IAC_ENDPOINT_HOSTNAME=?
IAC_ENDPOINT_PORT=?
```


#### Deploy

Easily done in a Docker container.
Make required changes within Dockerfile + compose files if necessary. When ready, simply use docker-compose to build your environment.
This will create the *ocean-blue, ...* services with necessary dependencies.

For dev, docker compose:
```sh
$ docker-compose build
$ docker-compose up
```

Verify the deployment by navigating to your address in your preferred browser. Enter the password in the requested location. 
```sh
$ curl http://localhost:8080
$ docker-compose exec ocean-blue cat /var/jenkins_home/secrets/initialAdminPassword
```

For prod, build:
```sh
$ docker build -f blue.Dockerfile -t mauriziolupini/ocean-blue:prod .
```

Commit prod, push docker builds:
```sh
$ docker push mauriziolupini/ocean-blue:prod
```

Get prod, pull docker builds:
```sh
$ docker pull mauriziolupini/ocean-blue:prod
```

Run prod, either docker run:
```sh
docker network create --driver bridge jenkins_network
docker run -d -p 8080:8080 mauriziolupini/ocean-blue:prod
```

Run prod, or docker swarm:
```sh
docker stack deploy -c builder.yml IAC
```


## Kubernetes + Google Cloud

See [KUBERNETES.md] coming soon.


## Future Release

  - TBD.


## Instructions
If making use of a private [git] repository. 
*await plug-in installation, container restart*

[git] is a distributed version-control system for tracking changes in source code during software development.
Pre-installed within *ocean-blue, ...* will require ssh authentication. 
Follow, https://docs.gitlab.com/ee/ssh/; https://gitlab.com/help/ssh/README#generating-a-new-ssh-key-pair
Note, similar with GitHub
Used majority of pipeline(s). 

Two options
1. 
New ssh key *must add to git repository*, within container
See example below, preferred
```sh
# ACCEPT DEFAULT FILE PATH 
# jenkins container will login with the same user. 
$ docker exec -it ocean-blue_1 bash
# ED25519 SSH KEYS ARE PREFERRED AND BEST PRACTICE. 
$ ssh-keygen -t ed25519 -C "mlupini.dev@gmail.com"
# RSA WHICH ONLY RECOMMENDED IF ISSUES WITH ABOVE. 
# $ ssh-keygen -o -t rsa -b 4096 -C "mlupini.dev@gmail.com" 
# ADD BELOW OUTPUT TO YOUR GIT REPO
$ cat /var/jenkins_home/.ssh/id_rsa.pub
# VERIFY SSH CONNECTIVITY 
$ ssh -T ssh@gitlab.com
```

2. 
Existing ssh key *must add to git repository*, copy to container
Follow, https://gitlab.com/help/ssh/README#generating-a-new-ssh-key-pair
See example below 
```sh
$ docker cp ./.key/. ocean-blue_1:/var/jenkins_home/.ssh/.
```

3. 
Assign permissions, Using chown command to change the user/group ownership of the *jenkins_home* directory.
If not followed you can expect to get the following Error, *java.nio.file.AccessDeniedException: /var/jenkins_home/workspace/item-name* with your pipelines

```
$ docker exec -u root ocean-blue_1 chown -R jenkins:jenkins /var/jenkins_home
```

### License

MIT


### Author
**Want to contribute? Great! See repo [git-repo-url] from [Maurizio Lupini][mo]    -Author, Working at [...][linkIn]**


   [mo]: <https://github.com/molupini>
   [linkIn]: <https://za.linkedin.com/in/mauriziolupini>
   [git-repo-url]: <git@github.com:molupini/jenkinsBuiler.git>
   [python]: <https://www.python.org/>
   [jenkins]: <https://jenkins.io/
   [terraform]: <https://www.terraform.io/>
   [git]: <https://git-scm.com/>