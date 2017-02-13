
## Docker for Next Generation Sequence Analysis

![]({{ page.image_repo }}/docker-for-beginners.png)

---

I am [Renzo Kottmann](https://renzok.github.io/about/), the author of following slides.

These slides are online available right now at [https://renzok.github.io/slides/docker/docker-introduction.html](https://renzok.github.ioslides/docker/docker-introduction.html)

<small>
 They are written in [Markdown](https://en.wikipedia.org/wiki/Markdown) and displayed by [Reveal.JS](https://github.com/hakimel/reveal.js), used here.
 The easiest way to navigate this slide deck is by hitting `[space]`on your keyboard.
</small>

---

## Questions?

How many of you have already:
- Used Virtual Machines?
  - Installed? Currently? 
- Heard about Docker?
- Used Docker containers?
- Created a Docker images?

---

## <i class="fa fa-calendar-o"></i> Agenda

1. Why Docker and why in this context? 
1. What is Docker anyway?
2. How to use Docker containers?
3. How to containerize your tools a.k.a. create docker images?

---

### Why Docker and why in this context?

![]({{ page.image_repo }}/docker_whale.png)

----
## Context Ocean Sampling Day

----
## Plethora of tools > 50
![](/img/osd/osd-plethora-tools.png)
----
### High-Performance Compute Clusters


![](/img/osd/osd-european-compute.png)

----
### Bioinformatics tools

* We have to perform compute with
  * many different tools:

    - In many different environments
    - On many different Operating Systems
    - Using many different packaging systems
    - Dealing with many conflicts between tools and versions

<i class="fa fa-long-arrow-right"></i> Impact on usuability and reproducibility

----

### Deployment issue

![]({{ page.image_repo }}/deployment_issue.png)

----

### Deployment issue

Matrix from Hell

![]({{ page.image_repo }}/deployment_issue_matrix.png)

----

### Transport Pre 1960

![]({{ page.image_repo }}/cargo_transport.png)

----

### Transport Pre 1960

Matrix from Hell

![]({{ page.image_repo }}/cargo_transport_matrix.png)

----

### Intermodal shipping container

![]({{ page.image_repo }}/cargo_transport_container.png)

Note: A standard container
- Virtually loading any goods
- Sealed until it reaches final delivery
- Can be 
  - loaded and unloaded
  - stacked
  - transported efficiently over long distances
  - transferred from one mode of transport to another

----

### Docker Container

![]({{ page.image_repo }}/deployment_issue_docker.png)

Note: Docker = An engine that encapsulated any tools as a 
- lightweight
- portable
- self sufficient container
- manipulated using standard operations
- run consistently on virtually any hardware platform

---

What is Docker anyway?

----

# Docker 

> Docker containers wrap a piece of software in a complete filesystem 
> that contains everything needed to run: code, runtime, system tools, 
> system libraries – anything that can be installed on a server. 
> This guarantees that the software will always run the same,
>  regardless of its environment

<div class="small" style="text-align:left;">From <a href="https://www.docker.com/whatisdocker">docker.com</a> (as of 2017-02-11</div>

----

<div class="col2">
<img src="https://databio.org/images/virtualization-icon-300px.png" width="175" height="175" /><br />
<div style="font-size:.7em; padding:10px">
Virtual machines include the application, the necessary binaries and libraries and an <em>entire guest operating system</em> - which may be tens of GBs in size.
</div></div>
<div class="col2">
<img src="https://databio.org/images/what_is_layered_filesystems_sm.png" width="175" height="175" /><br />
<div style="font-size:.7em; padding:10px">
Containers include the application and all of its dependencies, but <em>share the kernel</em> with other containers. They run as an isolated process in userspace on the host operating system.
</div></div>


----
### Virtual machines vs Containers

![]({{ page.image_repo }}/container_vs_vm.png)

Containers more portable and efficient

Note:

A different architectural approach

- VM: application +  necessary binaries and libraries + entire guest operating system 
  - All of which can amount to tens of GBs
- Container: application and all of its dependencies 
  - Share the kernel with other containers
  - Rnning as isolated processes in user space on the host operating system

----

## Docker Terminology

* <em>Image:</em>  A read-only template for containers.
* <em>Container:</em>   An instance of an image (it is created from an image).
* <em>Layer:</em> An image consists of a series of layers, which are merged in the container.
* <em>Dockerfile:</em>  Instructions used to build an image.
* <em>Registry:</em> An image storage center, holding public or private images which can be uploaded or downloaded (DockerHub).
* <em>Repository:</em> A storage area of version-controlled images, like GitHub repositories.
---


## How to use Docker?

![]({{ page.image_repo }}/docker-usage.jpg)

----

### The client

![]({{ page.image_repo }}/docker_command.png)

`docker --help`

----

### Images? Containers?

![]({{ page.image_repo }}/docker_concept_image_container.png)

Note:

Image: 
- recipe that tell how to build your container
- A filesystem and parameters to use at runtime
- snapshot of the content of a container: it doesn’t have state and never changes once built

Container
- a running instance of an image
- you can execute several time the same recipe and if you follow every time the same recipe, you will have the same meal several time. Same for containers

----

### How to get images?

![]({{ page.image_repo }}/docker_concept_pull.png)

Note: Docker Registry: 

- stateless
- highly scalable server side application 

to stores and distribute Docker images

Example: docker hub, quay.io

----

### `docker pull`

```sh
bebatut$ docker pull hello-world
Using default tag: latest
latest: Pulling from library/hello-world
c04b14da8d14: Pull complete
Digest: sha256:0256e8a36e2070f7bf2d0b0763dbabdd67798512411de4cdcf9431a1feb60fd9
Status: Downloaded newer image for hello-world:latest
```

----

### Creation of containers

![]({{ page.image_repo }}/docker_concept_run.png)

----

### `docker run`

```sh
bebatut$ docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker Hub account:
 https://hub.docker.com

For more examples and ideas, visit:
 https://docs.docker.com/engine/userguide/
```

----

### `docker run`

```sh
bebatut$ docker run --help

Usage:	docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

Run a command in a new container

  -a, --attach=[]                 Attach to STDIN, STDOUT or STDERR
  --add-host=[]                   Add a custom host-to-IP mapping (host:ip)
  --cpu-shares                    CPU shares (relative weight)
  ...
  -d, --detach                    Run container in background and print container ID
  -e, --env=[]                    Set environment variables
  --entrypoint                    Overwrite the default ENTRYPOINT of the image
  --env-file=[]                   Read in a file of environment variables
  ...
  -h, --hostname                  Container host name
  -i, --interactive               Keep STDIN open even if not attached
  --name                          Assign a name to the container
  --net=default                   Connect a container to a network
  ...
  -P, --publish-all               Publish all exposed ports to random ports
  -p, --publish=[]                Publish a container's port(s) to the host
  --privileged                    Give extended privileges to this container
  --rm                            Automatically remove the container when it exits
  -t, --tty                       Allocate a pseudo-TTY
  -v, --volume=[]                 Bind mount a volume
  ...
```

----

### Run an interactive container

```sh
bebatut$ docker run -t -i docker/whalesay
root@7de97f8dd5eb:/cowsay#
root@7de97f8dd5eb:/cowsay# cowsay Galaxy
 ________
< Galaxy >
 --------
    \
     \
      \
                    ##        .
              ## ## ##       ==
           ## ## ## ##      ===
       /""""""""""""""""___/ ===
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
       \______ o          __/
        \    \        __/
          \____\______/
root@7de97f8dd5eb:/cowsay#
```

----

### Control during startup

```
bebatut$ docker run -i -t
    -p 8080:80 -p 8021:21 -p 9002:9002
    --privileged=true
    -e "NONUSE=reports"
    -e "GALAXY_CONFIG_ADMIN_USERS=albert@einstein.gov"
    -e "GALAXY_CONFIG_MASTER_API_KEY=83D4jaba7330aDKHkakjGa937"
    -e "GALAXY_CONFIG_BRAND='My own Galaxy flavour'"
    -e "GALAXY_LOGGING=full"

    quay.io/bgruening/galaxy
```

Note: possibility to add many different parameters to control the container when starting it

----

### Management of data

```sh
bebatut$ mkdir data
bebatut$ docker run docker/whalesay cowsay Galaxy > data/cowsay
bebatut$ more data/cowsay
 ________
< Galaxy >
 --------
    \
     \
      \
                    ##        .
              ## ## ##       ==
           ## ## ## ##      ===
       /""""""""""""""""___/ ===
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
       \______ o          __/
        \    \        __/
          \____\______/
bebatut$ docker run -t -i docker/whalesay
root@f4fa8ed32ef8:/cowsay# ls
ChangeLog  INSTALL  LICENSE  MANIFEST  README  Wrap.pm.diff  cows  cowsay  cowsay.1  install.pl  install.sh  pgp_public_key.txt
root@f4fa8ed32ef8:/cowsay# cowsay Hello Galaxy > cowsay2
```

Can we access the `cowsay` file inside the container? <br>And the `cowsay2` file outside the container?

----

### Management of data

![]({{ page.image_repo }}/docker_volume_closed.png)

Note: A container is closed

----

### Management of data

![]({{ page.image_repo }}/docker_volume_open.png)

Note: A container is closed

----

### Data volume

![]({{ page.image_repo }}/docker_volume.png)

Note:

Data volume 
- a specially-designated directory 
- within one or more containers 
- bypasses the Union File System

Data volumes designed to persist data, independent of the container’s life cycle:
- Initialisation when a container is created
- Possibility of sharing and reusing among containers
- Direct changes to a data volume
- Persistence of data volumes even if the container itself is deleted

----

### Data volume

![]({{ page.image_repo }}/docker_run_volume.png)

Note: How to get a data volume?

----

### Data volume

```sh
bebatut$ ls data/
cowsay_Galaxy
bebatut$ docker run -t -i -v $PWD/data:/data docker/whalesay
root@f4fa8ed32ef8:/cowsay# ls /data
cowsay_Galaxy
root@f4fa8ed32ef8:/cowsay# cowsay Galaxy2 > /data/cowsay_Galaxy2
root@f4fa8ed32ef8:/cowsay# ls /data
cowsay_Galaxy  cowsay_Galaxy2
root@f4fa8ed32ef8:/cowsay# exit
bebatut$ ls data/
cowsay_Galaxy	cowsay_Galaxy2
```

----

### Execution of commands <br>inside a running container

![]({{ page.image_repo }}/docker_concept_exec.png)

Note: Run a command in a running container

----

### `docker exec`

```sh
bebatut$ docker run -d docker/whalesay /bin/sh -c "while true; do sleep 1; done"
7179e85085ef14634f8b50f908a255707743dec0a5d1fd7fb3cd9036334d5177
bebatut$ docker exec 7179e85085ef14634f8b50f908a255707743dec0a5d1fd7fb3cd9036334d5177 \
cowsay Galaxy
 ________
< Galaxy >
 --------
    \
     \
      \
                    ##        .
              ## ## ##       ==
           ## ## ## ##      ===
       /""""""""""""""""___/ ===
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
       \______ o          __/
        \    \        __/
          \____\______/
```


----

### Stop/Start containers

![]({{ page.image_repo }}/docker_concept_start_stop.png)

Note: Sending SIGTERM and then SIGKILL after a grace period

----

### `docker stop` & `docker start`

```sh
bebatut$ docker stop 7179e85085ef14634f8b50f908a255707743dec0a5d1fd7fb3cd9036334d5177
7179e85085ef14634f8b50f908a255707743dec0a5d1fd7fb3cd9036334d5177
bebatut$
bebatut$ docker exec 7179e85085ef14634f8b50f908a255707743dec0a5d1fd7fb3cd9036334d5177 \
cowsay Galaxy
Error response from daemon: Container 7179e85085ef14634f8b50f908a255707743dec0a5d1fd7fb3cd9036334d5177 \
is not running
bebatut$
bebatut$ docker start 7179e85085ef14634f8b50f908a255707743dec0a5d1fd7fb3cd9036334d5177
7179e85085ef14634f8b50f908a255707743dec0a5d1fd7fb3cd9036334d5177
bebatut$
bebatut$ docker exec 7179e85085ef14634f8b50f908a255707743dec0a5d1fd7fb3cd9036334d5177 \
cowsay Galaxy
 ________
< Galaxy >
 --------
    \
     \
      \
                    ##        .
              ## ## ##       ==
           ## ## ## ##      ===
       /""""""""""""""""___/ ===
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
       \______ o          __/
        \    \        __/
          \____\______/
```

----

### View all containers

![]({{ page.image_repo }}/docker_concept_ps.png)

----

### `docker ps`

```sh
bebatut$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
7179e85085ef        docker/whalesay     "/bin/sh -c 'while tr"   12 minutes ago      Up 2 seconds                            agitated_lovelace
bebatut$
bebatut$ docker ps -a
CONTAINER ID        IMAGE                  COMMAND                  CREATED             STATUS                          PORTS               NAMES
7de97f8dd5eb        docker/whalesay        "/bin/bash"              4 minutes ago       Exited (0) About a minute ago                       trusting_swanson
9218bbee9c48        docker/whalesay        "/bin/bash"              5 minutes ago       Exited (0) 4 minutes ago                            evil_swirles
7179e85085ef        docker/whalesay        "/bin/sh -c 'while tr"   13 minutes ago      Up 55 seconds                                       agitated_lovelace
ad275579c454        ubuntu                 "/bin/sh -c 'while tr"   15 minutes ago      Exited (137) 13 minutes ago                         condescending_mestorf
66179c4d16da        ubuntu                 "/bin/bash"              About an hour ago   Exited (130) 15 minutes ago                         determined_pasteur
27386c8b69b3        ubuntu                 "/bin/sh"                About an hour ago   Exited (0) About an hour ago                        lonely_ramanujan
4cfefa19e6fa        docker/whalesay        "/bin/bash"              About an hour ago   Exited (0) About an hour ago                        thirsty_chandrasekhar
82687eb94ab9        docker/whalesay        "cowsay Galaxy"          2 hours ago         Exited (0) 2 hours ago                              fervent_babbage
6dbabb9384ad        tmp-bioconda-builder   "/usr/local/bin/tini "   8 days ago          Exited (0) 7 days ago                               tender_bhaskara
5d6f09b94727        tmp-bioconda-builder   "/usr/local/bin/tini "   8 days ago          Exited (0) 8 days ago                               jolly_brattain
4e6f38b4c34c        tmp-bioconda-builder   "/usr/local/bin/tini "   8 days ago          Created                                             angry_colden
b3e6c7412a75        tmp-bioconda-builder   "/usr/local/bin/tini "   8 days ago          Created                                             desperate_visvesvaraya
1ec56c9e37f8        tmp-bioconda-builder   "/usr/local/bin/tini "   8 days ago          Created                                             hopeful_khorana
2b129d00eb10        tmp-bioconda-builder   "/usr/local/bin/tini "   8 days ago          Created                                             gigantic_ptolemy
da45ab698f58        fb77c13d04c0           "/usr/local/bin/tini "   13 days ago         Exited (0) 13 days ago                              jovial_yalow
48dc3ed4e173        fb77c13d04c0           "/usr/local/bin/tini "   13 days ago         Created                                             focused_ritchie
e9195b6512dd        a2107450fdf2           "/usr/local/bin/tini "   2 weeks ago         Created                                             thirsty_bardeen
```

Note: Name of containers and id

----

### Creation of a new image

![]({{ page.image_repo }}/docker_concept_build.png)

Note: Need a Dockerfile. I will describe it later. Here it is just to give you a broad overview of the principles 

----

### View all images

![]({{ page.image_repo }}/docker_concept_image.png)

----

### Push your image on a registry

![]({{ page.image_repo }}/docker_concept_push.png)

---

## How to containerize your tools?

![]({{ page.image_repo }}/docker-container.jpg)

Note: Now I am sure all of you want to containerize his tool :)

----

### How to create your image?

![]({{ page.image_repo }}/docker_build.png)

----

### A Dockerfile?

A text document that contains all the commands a user could call on the command line to assemble an image

```sh
# Comment
INSTRUCTION arguments
```

Note: the paper describing the recipe for you container

Review of the commands

----

### The instructions <br>[`FROM`](https://docs.docker.com/engine/reference/builder/#from)

```sh
# Galaxy - Stable
#
# VERSION       Galaxy-central

FROM toolshed/requirements
...
```

<small>
[Galaxy Dockerfile](https://github.com/bgruening/docker-galaxy-stable/blob/master/galaxy/Dockerfile)
</small>

Note: the Base Image for subsequent instructions

Important in any Dockerfile

- FROM must be the first non-comment instruction in the Dockerfile.
- FROM can appear multiple times within a single Dockerfile in order to create multiple images
  Simply make a note of the last image ID output by the commit before each new FROM command

----

### The instructions <br>[`MAINTAINER`](https://docs.docker.com/engine/reference/builder/#/maintainer)

```sh
...
MAINTAINER Björn A. Grüning, bjoern.gruening@gmail.com
...
```

Note: Author field of the generated images

----

### The instructions <br>[`ENV`](https://docs.docker.com/engine/reference/builder/#env)

```sh
...
ENV GALAXY_RELEASE=release_16.07 \
GALAXY_REPO=https://github.com/galaxyproject/galaxy \
GALAXY_ROOT=/galaxy-central \
GALAXY_CONFIG_DIR=/etc/galaxy
...
```

Note: sets the environment variable <key>=<value>

Value in the environment of all “descendant” Dockerfile commands

----

### The instructions <br>[`RUN`](https://docs.docker.com/engine/reference/builder/#run)

```sh
...
# Create the postgres user before apt-get does (with the configured UID/GID) to facilitate sharing /export/postgresql with non-Linux hosts
RUN groupadd -r postgres -g $GALAXY_POSTGRES_GID && \
    adduser --system --quiet --home /var/lib/postgresql --no-create-home --shell /bin/bash --gecos "" --uid $GALAXY_POSTGRES_UID --gid $GALAXY_POSTGRES_GID postgres

RUN apt-get -qq update && apt-get install --no-install-recommends -y apt-transport-https software-properties-common wget && \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list" && \
    sh -c "echo deb http://research.cs.wisc.edu/htcondor/ubuntu/stable/ trusty contrib > /etc/apt/sources.list.d/htcondor.list" && \
    sh -c "wget -qO - http://research.cs.wisc.edu/htcondor/ubuntu/HTCondor-Release.gpg.key | sudo apt-key add -" && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-add-repository -y ppa:galaxyproject/nginx && \
    apt-get update -qq && apt-get upgrade -y && \
    apt-get install --no-install-recommends -y mercurial python-psycopg2 postgresql-9.3 sudo samtools python-virtualenv \
    nginx-extras=1.4.6-1ubuntu3.4ppa1 nginx-common=1.4.6-1ubuntu3.4ppa1 uwsgi uwsgi-plugin-python supervisor lxc-docker-1.9.1 slurm-llnl slurm-llnl-torque libswitch-perl \
    slurm-drmaa-dev proftpd proftpd-mod-pgsql libyaml-dev nodejs-legacy npm ansible \
    nano nmap lynx vim curl python-crypto python-pip python-gnuplot python-rpy2 python-psutil condor python-ldap \
    gridengine-common gridengine-drmaa1.0 && \
    pip install --upgrade pip && \
    pip install ephemeris && \
    apt-get purge -y software-properties-common && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
...
```

Note: 

- Execution of any commands in a new layer on top of the current image and commit the results
- shell form
- \ (backslash) to continue a single RUN instruction onto the next line

----

### The instructions <br>[`ADD`](https://docs.docker.com/engine/reference/builder/#add)/[`COPY`](https://docs.docker.com/engine/reference/builder/#copy)

```sh
...
ADD ./bashrc $GALAXY_HOME/.bashrc
...
```

<i class="fa fa-exclamation-triangle"></i> `COPY` is functionally similar to `ADD` but is preferred

Note: copies new files, directories or remote file URLs from <src> and adds them to the filesystem of the container at the path <dest>

- <src> path inside the context of the build
- <dest> an absolute path, or a path relative to WORKDIR

Numerous rules

COPY

- more transparent than ADD
- only supports the basic copying of local files into the container,

Some features for ADD has some features: local-only tar extraction and remote URL support

Consequently, the best use for ADD is local tar file auto-extraction into the image

----

### The instructions <br>[`USER`](https://docs.docker.com/engine/reference/builder/#user)


```sh
...
# The following commands will be executed as User galaxy
USER galaxy
...
```

Note: 

Sets the user name or UID to use  
- when running the image
- for any `RUN`, `CMD` and `ENTRYPOINT` instructions that follow it in the Dockerfile

----

### The instructions <br>[`WORKDIR`](https://docs.docker.com/engine/reference/builder/#workdir)

```sh
...
WORKDIR $GALAXY_ROOT
...
```

Note: 

- Sets the working directory for any `RUN`, `CMD`, `ENTRYPOINT`, `COPY` and `ADD` instructions that follow it in the Dockerfile
- Created if it doesn’t exist
- Possible multiple times

----

### The instructions <br>[`EXPOSE`](https://docs.docker.com/engine/reference/builder/#expose)

```sh
...
# Expose port 80 (webserver), 21 (FTP server), 8800 (Proxy), 9002 (supvisord web app)
EXPOSE :80
EXPOSE :21
EXPOSE :8800
EXPOSE :9002
...
```

Note: 

- Informs Docker that the container listens on the specified network ports at runtime
- Does not make the ports of the container accessible to the host. 
  `-p` flag to publish a range of ports or the `-P` flag to publish all of the exposed ports when `docker run

----

### The instructions <br>[`VOLUME`](https://docs.docker.com/engine/reference/builder/#volume)

```sh
...
# Mark folders as imported from the host.
VOLUME ["/export/", "/data/", "/var/lib/docker"]
...
```

Note: 

- Creates a mount point with the specified name
- Marks it as holding externally mounted volumes from native host or other containers

Accessible from outside `docker inspect container_name` but not directly linked

Data volume: specially-designated directory within one or more containers that bypasses the Union File System

----

### The instructions <br>[`VOLUME`](https://docs.docker.com/engine/reference/builder/#volume)
#### Dockerfile example

```sh
FROM ubuntu
RUN mkdir /myvol
RUN echo "hello world" > /myvol/greeting
VOLUME /myvol
```

Note: 

Creation of an image that causes docker run, 
- to create a new mount point at /myvol 
- copy the greeting file into the newly created volume

----

### The instructions <br>[`CMD`](https://docs.docker.com/engine/reference/builder/#cmd)

```sh
...
# Autostart script that is invoked during container start
CMD ["/usr/bin/startup"]
```

Note:
- only be one CMD instruction in a Dockerfile
- Provide defaults for an executing container


----

### Creating the image

```sh
bebatut$ docker build .
Sending build context to Docker daemon  2.56 kB
Step 1 : FROM biocontainers/biocontainers:latest
 ---> 78f76aa0b4ab
Step 2 : LABEL base.image "biocontainers:latest"
 ---> Running in bb45efa8fc7b
 ---> 50804d9e831c
Removing intermediate container bb45efa8fc7b
Step 3 : LABEL version "2"
 ---> Running in 5511ea44083a
 ---> 675c5b11b226
Removing intermediate container 5511ea44083a
Step 4 : LABEL software "Samtools"
 ---> Running in efdd16353421
 ---> 4349329b8832
Removing intermediate container efdd16353421
Step 5 : LABEL software.version "1.3.1"
 ---> Running in c698fe4a1bbe
 ---> 8cb8534ed3cc
Removing intermediate container c698fe4a1bbe
Step 6 : LABEL description "Tools for manipulating next-generation sequencing data"
 ---> Running in 3b64527a6f2e
 ---> 097ee57996fa
...
```
----

### Dockerfile & Layers

![]({{ page.image_repo }}/dockerfile_layers.png)


----

### [Best practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/)

- Containers should be ephemeral
- Use a `.dockerignore` file
- Avoid installing unnecessary packages
- Run only one process per container
- Minimize the number of layers
- Sort multi-line arguments
- Build cache

Note:
- Containers should be ephemeral
    The container produced by the image your Dockerfile defines should be as ephemeral as possible. By “ephemeral,” we mean that it can be stopped and destroyed and a new one built and put in place with an absolute minimum of set-up and configuration.
- `.dockerignore` file
    In most cases, it’s best to put each Dockerfile in an empty directory. Then, add to that directory only the files needed for building the Dockerfile. To increase the build’s performance, you can exclude files and directories by adding a .dockerignore file to that directory as well. This file supports exclusion patterns similar to .gitignore files. For information on creating one, see the .dockerignore file.
- unnecessary packages
    In order to reduce complexity, dependencies, file sizes, and build times, you should avoid installing extra or unnecessary packages just because they might be “nice to have.” For example, you don’t need to include a text editor in a database image.
- Run only one process per container
    In almost all cases, you should only run a single process in a single container. Decoupling applications into multiple containers makes it much easier to scale horizontally and reuse containers. If that service depends on another service, make use of container linking.
- Minimize the number of layers
    You need to find the balance between readability (and thus long-term maintainability) of the Dockerfile and minimizing the number of layers it uses. Be strategic and cautious about the number of layers you use.
- Sort multi-line arguments
    Whenever possible, ease later changes by sorting multi-line arguments alphanumerically. This will help you avoid duplication of packages and make the list much easier to update. This also makes PRs a lot easier to read and review. Adding a space before a backslash (\) helps as well.
- Build cache

----
  
### <i class="fa fa-pencil"></i> Hands on!

Create an image for your favorite tool

---

### Thank You!

![]({{ page.image_repo }}/docker_concept.png)

