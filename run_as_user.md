# Running as non-root user

If you want to mount a persistant volume external to the container, as docker doesn't provide
yet a way to remap the uid, the files written on the volume will be owner by root if the user in
the container is root.

A way to avoid this is to create a non-root user and to switch to it prior to execute any command in the container.
The following example shows how to start a bash shell with the original user of the host:

```bash
docker run --name $USER -ti -v $HOME:$HOME ubuntu:14.04.3 bash -c "adduser --disabled-password --gecos \"$(getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1)\" --uid $UID --ingroup users $USER && adduser $USER sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers ; cd $HOME && su $USER"
```

To start the bash command within the same container use:

```bash
docker start -i $USER
```

