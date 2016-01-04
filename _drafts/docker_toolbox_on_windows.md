---
title: "Docker Toolbox on Windows"
layout: post
date: 2015-10-20
---

# A dream about to come true 

From the very first time I encountered Docker, 
I dreamed about how cool it would be to run Linux containers on Windows OS. Why? Simply my work requires me to equally work on Windows machines as well as on Linux based systems. Basically, windows for all communication and writing activities and Linux for all my development activities. Of course I tried all solutions: Only working on Windows, only working on Linux, Dual Boot, CYGWIN... you name it. 
My current best solution is a Debian Virtual Machine as guest on my Windows host. Although this solution needs a lot of CPU and RAM to work smooth enough. Being able to dockerize all my tools and run *the same tools the same way* on Windows as well as on Linux would be my ultimate dream of combining the best of the two worlds.

Now, several month after Docker and Microsoft announced Docker on Windows, 
I thought it is time to give it a try and see if my dream came true.

## Definition of done

There are two major requirements for me that need to be fulfilled in order to make me a happy Docker on Windows user and announce the dream came true.

1. Being able to also run dockerized application in need of a GUI
2. Mount any Windows folder as host volumes
3. Being able to continue working after 
  1. Switching Internet connections on host
  1. Relative frequent shutdowns, sleeps, and hibernations
  

## Using the toolbox

I do almost all my work on my laptop with a Windows 7 and a VirtualBox 4.3 installed.

The first time installation of docker-toolbox 1.8.3 is easy. I just had to make sure, I do a custom installation and make sure to **not** install another VirtualBox. Afterwards, one has a folder with the docker-machine executable, the boot2docker iso image and some helper scripts. Additionally, and that can not be configured in this version, one has all other settings, configurations and the virtual machine named *default* in the `C:\Users\% your username %/.docker` folder.
 
### Issue 1: Installation and De-Installation

As it later turned out, proper de-installation to restart from scratch has little pitfalls, some of which seem to be related to Issue 3. Only after some fiddling, my de-installation procedure is as follows:

1. Shutdown the virtual machine
1. Delete the virtual machine including deleting all related files
1. Uninstall using the uninstall script of docker-toolbox
1. Delete whole *.docker* folder in your users home folder

### Issue 2: Mounting Host Volumes

The data container pattern just is just my preferred way. However, I often have to big stuff in my folders and therefore need to mount folders directly from the host.

It seems that with the current docker-toolbox one can only mount host folders from the Windows user folder. Which is in my case `C:\Users\% my username %`.

In general I want to be able to choose any Windows folder from any partition. In particular my `C:` drive is already 95% full. But I have enough space on another drive. Everyone, should be able to configure this.

### Issue 3: Error After System Sleep

After Windows went into sleeping mode, I could not start the *default* virtual machine from the Docker Quickstart Terminal no more.

I am still not sure what the cause is or causes were. Maybe:

  * Stale *docker-machine* processes? I had some stale processes running during my re-installation endeavours. 
  * Errors in the installation procedure? To check for this, I did some re-installations.
  * Bugs in how Docker Quickstart Terminal interacts with the virtual machine?
  
After digging through some GitHub issues, blogs and forum entries it seems that, Windows manages the VirtualBox Host Adapter such that it [changes the IP Address to a private IP](http://lyngtinh.blogspot.ca/2011/12/how-to-disable-autoconfiguration-ipv4.html) which causes Docker-machine some hiccups.

See steps for the solution/work-around below (adapted from [Stackoverflow](http://stackoverflow.com/a/32997115/1934976))


## My Recommended Installation Procedure

1. Make sure to **first** install latest VirtualBox version (time of writing version 5.0.6 r103037)
  * Before upgrading, make sure to close all VMs with shutdown. 'Save State' will cause errors.
1. Install docker-toolbox (version 1.8.3) 
1. Start Docker Quickstart Terminal
1. Check that all works with e.g. running `docker images`
1. While the terminal is running apply the following configuration changes to your VirtualBox Host Adapter:
  1. Start a command prompt as Administrator (e.g. cmd.exe)
  1. Show all adapters: `ipconfig /all.`
		1. Find the name of the "VirtualBox Host-Only Ethernet Adapter" that does not have a private ip (i.e. not starting with 169.*) but instead a public IP.
  1. Run `netsh interface ipv4 show inter` 
    1. Note the "Idx" of the adapter with a public IP e.g. 11
  1. Run `netsh interface ipv4 set interface 11 dadtransmits=0 store=persistent`, but change 11 to your Idx. This disables the IP auto configuration. 
1. Exit Docker Quickstart Terminal
1. Stop *default* virtual machine
1. Restart Windows

## Minor Issues Using Docker on Windows
 
* The current Docker Quickstart Terminal does not support interactive docker container sessions:
  Reading the start up message is key:
  
  > "NOTE: When using interactive commands, prepend winpty. Examples: 'winpty docker run -it ...', 'winpty docker exec -it ...'."

* It appears that winpty adds additional complexity to the POSIX path conversion, when mounting Windows folders .
	* Workaround is creating a data volume container which itself mounts the windows folder ([see GitHub issue](https://github.com/rprichard/winptyhttps://github.com/docker/toolbox/issues/241)) and correpsonding [Stackoverflow](http://stackoverflow.com/a/33151452/1934976) 
* As you read this, I am using a dockerized jekyll for local writing. And on Windows you need to start jekyll with *--force_polling*. [From the README](https://github.com/jekyll/docker#boot2docker-caveats): "If you are on Windows or OS X using Boot2Docker you will need to --force_polling because there is no built-in support for NTFS/HFS notify events to inotify and the verse, you'll be on two different file systems so only the basic API's are implemented."
 
## Running GUI Applications

With a Linux OS it is easy to connect your hosts X server to a docker container. You simply mount the X server socket and add the DISPLAY environment variable into the container.

E.g. for an Emacs all you need to do:

~~~bash
docker run --rm \
  -e DISPLAY=${DISPLAY} \
  -v /tmp/.X11-unix:/tmp/.X11-unix  \
  -v /tmp/:/workdir \
  renzok/emacs
~~~

That reminded me that some years ago when I was working on something completely different, I had to install an X Server on a Windows machine. Therefore, I thought, it might be possible to let a docker container on a Windows machine speak to an X Server on the same Windows machine.

And hack, it works!! 

I have to write another post about this!


# Major steps closer to the dream

Docker nearly made my dream come true. The fact that I can not mount any Windows folder is the last piece missing. Despite the installation and configuration issues, it is definitely possible to nicely use Docker on a Windows machine including running GUI applications. This post was written using a Windows Notepad++ installation and running the [docker jekyll container on Windows](https://hub.docker.com/r/jekyll/jekyll/). 
However, given the issues I had and the amount of related and other issues currently reported, I will not fully switch my development environment to be based on Docker running on Windows. But it is just a matter of time. The Docker community is simply awesome which makes me confident that my dream will fully come true sooner than later.

