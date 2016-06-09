---
layout: post
title:  "Using Raspberry PI as home router/server (draft)"
date:   2016-02-23 00:00:00 +0000
categories: draft
---

# Using Raspberry PI as home router/server

I wanted to enable IPv6 on my home network but my internet service provider (free.fr) didn't support any firewall in v6 mode. In addition, I'm starting to have a lot of machine, physical or virtual, around and having a local DNS instead of using IP address to connect to this fauna. I had a spare raspberry PI and decided to use it.


# Installing Docker

The installation of [docker on the Rasbian][docker-on-pi] distribution can be done as following:


{% highlight bash %}

curl -sSL http://downloads.hypriot.com/docker-hypriot_1.10.1-1_armhf.deb >/tmp/docker-hypriot_armhf.deb
sudo dpkg -i /tmp/docker-hypriot_armhf.deb
rm -f /tmp/docker-hypriot_armhf.deb
sudo sh -c 'usermod -aG docker $SUDO_USER'
sudo service docker start

{% endhighlight %}

# Setting up a DNS server with dnsmask

{% highlight bash %}
sudo apt-get install dnsmasq
{% endhighlight %}

Then edit the '''/etc/dnsmasq.conf''' and  '''/etc/hosts''' file.



[docker-on-pi]: https://github.com/umiddelb/armhf/wiki/Get-Docker-up-and-running-on-the-RaspberryPi-(ARMv6)-in-three-steps
[pi-as-IPv6-router]: http://www.goudal.net/?p=6
[dnsmask-on-pi]: http://yiqingsim.net/post/103165692292/setting-up-dnsmasq-as-a-dnsdhcp-server-on-a


