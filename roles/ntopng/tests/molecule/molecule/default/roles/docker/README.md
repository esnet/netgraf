## `docker` role

This role installs, and configure docker instances in tests. Unlike
`virtualbox` VMs, the docker images used in tests are a generic base image. As
such, some packages, commonly installed during OS installation, are missing.
The role fixes these differences between `virtualbox` images and `docker`
images.
