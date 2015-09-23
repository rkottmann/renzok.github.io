#!/bin/bash

mkdir -p /tmp/common-group-host-dir

# creating common host group
sudo useradd -M --uid 1496 --user-group dockmaster
# setting GUID
sudo chmod g+s /tmp/common-group-host-dir/
# make dockmaster group owner
sudo chown dockmaster:dockmaster /tmp/common-group-host-dir/
ls -lha /tmp/common-group-host-dir/

sudo docker run -v /tmp/common-group-host-dir:/tmp/common-group-contain
er-dir --user 1496 --group-add 1496  -ti  debian:jessie /bin/bash

# now in container
I have no name!@d2165449e550:/$ touch /tmp/common-group-container-dir/test-file

# check directory content from within container
I have no name!@d2165449e550:/$ ls -lha /tmp/common-group-container-dir/
total 8.0K
drwxr-sr-x 2 1496 1496 4.0K Sep 20 11:47 .
drwxrwxrwt 3 root root 4.0K Sep 20 11:47 ..
-rw-r--r-- 1 1496 1496    0 Sep 20 11:47 test-file


$ ls -lha /tmp/common-group-host-dir/

total 16K
drwxr-sr-x  2 dockmaster dockmaster 4.0K Sep 20 13:47 .
drwxrwxrwt 11 root       root        12K Sep 20 13:48 ..
-rw-r--r--  1 dockmaster dockmaster    0 Sep 20 13:47 test-file



