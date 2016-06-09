---
layout: post
title:  "Unreal engine/Torch plugin"
date:   2016-02-02 00:00:00 +0000
categories: draft
---


# Building
https://github.com/facebook/UETorch
https://wiki.unrealengine.com/Building_On_Linux#Prerequisites

```bash

# Create a sudoer user
adduser user
usermod -a -G sudo user
bash -c 'echo "user ALL=(ALL:ALL) ALL" | (EDITOR="tee -a" visudo)'
su user

cat /etc/*-release
apt-get install -y git wget
time git clone -b 4.11 git@github.com:EpicGames/UnrealEngine.git
ssh-keygen
cat ~/.ssh/id_rsa.pub 
cd UnrealEngine/
time ./Setup.sh
time ./GenerateProjectFiles.sh
time make
./Engine/Binaries/Linux/UE4Editor --version
```


[1]: https://github.com/EpicGames


