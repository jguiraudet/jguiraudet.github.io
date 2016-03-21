---
layout: post
title:  "Running Raspbian on x86 docker"
date:   2016-03-03 00:00:00 +0000
categories: raspberrypi
---

Setting up a cross compilation environment is quite tedious and it is much easier to rebuild a software natively on raspberry pi, but what if you don't have on pi spare next to you or if you want to automate the build process on a generic x86 server.

Hopefully, the `binfmt_mis` Linux kernel module allows to register interpreters for various binary formats based on a magic number. In conjonction with the `qemu-user-static` user-space emulator for arm, it allows us to create a `docker image` of the arm raspbian distribution which can run on a directly x86 desktop or server.


# Installing Docker on an Ubuntu x86 host

Fist install binfmt-support and qemu-user-static on the x86 host. On Ubuntu LTS 14.04:

{% highlight bash %}
sudo apt-get update && sudo apt-get install -y binfmt-support qemu qemu-user-static 

# check your ability to emulate the binary formats by checking for ARM support 
sudo update-binfmts --enable qemu-arm
sudo update-binfmts --display | grep arm
{% endhighlight %}

# Building arm/raspbian docker image for x86 with qemu

Use the following script to download the image from raspberrypi.org and convert if to a docker image.

Get the [rpi-build-docker-img](https://raw.githubusercontent.com/jguiraudet/jguiraudet.github.io/master/_includes/bin/rpi-build-docker-img) script.
{% highlight bash %}
{% include bin/rpi-build-docker-img %} 
{% endhighlight %}

# Performance

The raw CPU performance on the emulation is slightly slower that when running on the native but has the great advantage to be able to run on any server to automate build or image modification. 

I used sysbench as descripbe bellow to benchmark the three configuration.
 
{% highlight bash %}
sudo apt-get update && sudo apt-get install -y sysbench
sysbench --test=cpu --cpu-max-prime=2000 run
grep Revision /proc/cpuinfo
{% endhighlight %}
(See [table][checking-your-raspberry-pi-board-version] to interpret the /proc/cpuinfo on raspberry-pi)

Results:

| system                                      | sysbench Total time     |
|:------------------------------------------- | -----------------------:|
| Host native (i7 6 cores)                    |                 1.1145s |
| raspeberry-pi native (Model B+ ARMv6/512MB) |                54.3638s |
| qemu-arm                                    |                60.7251s |


# References

* Using qemu-user-static with root for a raspbian image can be found [here][qemu-user-static] and [here][dockerfile-qemu-arm-root]
* [Qemu User Emulation][QemuUserEmulation]
* [How to benchmark your system cpu with sysbench][how-to-benchmark-your-system-cpu-file-io-mysql-with-sysbench]

# Issues

**Update:** I encounter a crash with `tcg.c:1693: tcg fatal error` while cloning a git tree with qemu-user-static 2.0.0+dfsg-2ubuntu1.22. This is apparently a known issue. See: https://patches.linaro.org/patch/32473/. 
The issue doesn't occurs with qemu-arm-static of Ubuntu 15.10 (A copy is stored at [http://jguiraudet.github.io/assests/bin/qemu-arm-static](http://jguiraudet.github.io/assests/bin/qemu-arm-static))



[QemuUserEmulation]: https://wiki.debian.org/QemuUserEmulation
[dockerfile-qemu-arm-root]: https://github.com/dweinstein/dockerfile-qemu-arm-root
[qemu-user-static]: https://wiki.debian.org/RaspberryPi/qemu-user-static
[Raspberry_Pi_Kernel_Compilation]: http://elinux.org/Raspberry_Pi_Kernel_Compilation#Raspbian_and_PiBang
[checking-your-raspberry-pi-board-version]: http://www.raspberrypi-spy.co.uk/2012/09/checking-your-raspberry-pi-board-version/
[how-to-benchmark-your-system-cpu-file-io-mysql-with-sysbench]: https://www.howtoforge.com/how-to-benchmark-your-system-cpu-file-io-mysql-with-sysbench#-cpu-benchmark




