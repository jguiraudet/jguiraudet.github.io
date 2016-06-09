---
layout: post
title:  "Installing ZFS (draft)"
date:   2016-01-18 00:00:00 +0000
categories: draft
---

# ZFS


I recently bought a 6TB drive and decided it was the right time to try to use this file system I discovered some time ago, ***ZFS***, since I wanted to use a it for storing a farely large amount of data and to have the option to take snapshots.
I followed the instruction from http://serverascode.com/2014/07/01/zfs-ubuntu-trusty.html .

See https://github.com/zfsonlinux/pkg-zfs/wiki/HOWTO-install-Ubuntu-to-a-Native-ZFS-Root-Filesystem for provisionning a mirror with a single disk.


{% highlight bash %}



sudo apt-get install software-properties-common
sudo add-apt-repository ppa:zfs-native/stable
sudo apt-get update
sudo apt-get install -y ubuntu-zfs
sudo modprobe zfs
lsmod | grep zfs
ls -la /dev/disk/by-id

truncate -s 6TB /tmp/sparsefile
sudo zpool create  data mirror /dev/disk/by-id/ata-WDC_WD60EZRX-00MVLB1_WD-WX11D153XENZ-part1 /tmp/sparsefile
sudo zpool offline data /tmp/sparsefile
sudo zfs list

{% endhighlight %}



