---
title: "rule one"
categories: docker
author: Renzo Kottmann
from: https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/
name: "Ephemeral containers"
---

A container should be as ephemeral as possible.


That is, it is self-contained and by runing it with `--rm` the container is fully removed from the system after termination.
