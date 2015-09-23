---
layout: post
title:  "Docker: Host Volumes and Host User/Group identifiers"
date:   2015-09-20
---


# Hard to understand

Even for proficient and experienced Linux/Unix users it is sometimes
not easy to become a Docker-savvy.

Although Docker is all about putting software in a box, it equally
requires you to think outside the box you create and consider the host
context. Especially, if you are aiming for as portable docker
containers as possible.

If one is aiming for portable docker containers a difficulty is
mounting writable host volumes into containers and understand how the
mapping of the user/group identifiers within the container and the
user/group identifiers of the host works. Please be aware that the
best approach is the
[data volume container approach](https://docs.docker.com/userguide/dockervolumes/#creating-and-mounting-a-data-volume-container). However,
by default &ndash; and therefore on allmost all hosts &ndash; the
maximum size of a container is 10GB. You only need host mounted
volumes in cases where you are regularly handling data of sizes beyond
10GB.

I think the most important aspects in a nutshell are:

* Volumes are created **ONCE** during container creation
* The host has its own
[user identifiers](https://en.wikipedia.org/wiki/User_identifier)
(uid) and
[group identifiers](https://en.wikipedia.org/wiki/Group_identifier)
(gid) totally independent from the container's uids and gids
* For bind-mounts the host's uids and gids are taken 'as is' in the
  container and the container writes with the uids and gids of the
  user in the container. This is by default the root user who has
  uid=0 and gid=0.

# Easy practical approach since Docker 1.8

After digging through several approaches, the one that works best for
me is what I call the 
"Container's Host Common Group Approach" to ensure that file access
permissions for users in containers seamlinglessly match the host
settings.

* That is create one are many groups on the host with a certain gid
    * I like to name the host group dockmaster and give it gid 1496
      (ISO standardnumber for real shipping containers ;) )
* Create a directory on host with dockmaster group and set the group
  bit (SETGUID)
* Start a docker container mounting the host drirectory and assign the
host group id to the user within the container by using --group-add
  * This fetaure is only available since docker 1.8 (a feature not
announced by docker!!). See [pull request for details](https://github.com/docker/docker/pull/10717). 

That's about it.

## Detail run through


```bash
$ mkdir -p /tmp/common-group-host-dir

# creating common host group
$ sudo useradd -M --uid 1496 --user-group dockmaster
# setting GUID
$ sudo chmod g+s /tmp/common-group-host-dir/
# make dockmaster owner
$ sudo chown dockmaster:dockmaster /tmp/common-group-host-dir/
$ ls -lha /tmp/common-group-host-dir/

total 16K
drwxr-sr-x  2 dockmaster dockmaster 4.0K Sep 20 13:47 .
drwxrwxrwt 11 root       root        12K Sep 20 13:48 ..

# starting container 
sudo docker run \
-v /tmp/common-group-host-dir:/tmp/common-group-container-dir \
--user 1496 \
--group-add 1496  \
-ti --rm \
debian:jessie /bin/bash

# now in container
I have no name!@d2165449e550:/$ touch /tmp/common-group-container-dir/test-file

# check directory content from within container
I have no name!@d2165449e550:/$ ls -lha /tmp/common-group-container-dir/
total 8.0K
drwxr-sr-x 2 1496 1496 4.0K Sep 20 11:47 .
drwxrwxrwt 3 root root 4.0K Sep 20 11:47 ..
-rw-r--r-- 1 1496 1496    0 Sep 20 11:47 test-file

# now back to host
I have no name!@d2165449e550:/$ exit

# on host
$ ls -lha /tmp/common-group-host-dir/

total 16K
drwxr-sr-x  2 dockmaster dockmaster 4.0K Sep 20 13:47 .
drwxrwxrwt 11 root       root        12K Sep 20 13:48 ..
-rw-r--r--  1 dockmaster dockmaster    0 Sep 20 13:47 test-file
```


# Other more complicated approaches for older Docker versions

## Common user in container and on host

* create user in each image having the same gid as the gid of the host
volume (name of group does not matter)

* create container and/or host volumes and make them group writeable

That works in many cases.

## Container only solution

### Configuring via environmental variables 

Some docker image maintainer/provider already implement some
facilties. E.g. GitLab's docker container allows to configure
container/host id mapping using environmental variables which can be
set at runtime. See
https://github.com/sameersbn/docker-gitlab#host-uid--gid-mapping

### Derived container

What if containers get deployed on hosts where no common group can be
created and or the host group id is different?

* Then create a new container image based on the one you want to use
  within which you create a CONTAINER_USER/GROUP having the same
  UID/GID as the HOST USER/GID owning the volumes you want to write in

### Mount hosts passwd and group files

* mount the /etc/passwd and /etc/group from the container into each
  container which needs to write into HOST volumes

  
# Addtional background reading

* Nice working metaphor for thinking of volumes: poking holes with
  windows i.e. a volume declaration in dockerfile just declares the
  boundaries:
  http://cloud-mechanic.blogspot.de/2014/10/storage-concepts-in-docker.html

* Important sentence from the
[official documentation](https://docs.docker.com/userguide/dockervolumes/):
"A data volume is a specially-designated directory within one or more
containers that bypasses the Union File System."
  * The documentation also clearly states that volumes are created
when containers are created and by default persists even if container
is deleted.

* [This article from computerweekly](http://www.computerweekly.com/feature/Docker-storage-101-How-storage-works-in-Docker)
  clarifies that volumes live in /var/lib/docker/volumes
  * And that "There is no additional security on volumes or data
containers other than standard Unix file permissions and the option to
configure read-only or read-write access. This means file access
permissions for users on the containers needs to match the host
settings."

* Another good explanation of volumes http://container42.com/2014/11/03/docker-indepth-volumes/


* Hinting to the creation reason and pointing that a data volume
  container maybe be based on the same image as the application using
  the container:
  http://container42.com/2014/11/18/data-only-container-madness/
  * However, that might not be the best solution if several dockerized
    applications need accces to same data volume container. Then a
    dedicated data volume container might be a better option.
