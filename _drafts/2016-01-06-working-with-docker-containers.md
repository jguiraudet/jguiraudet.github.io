---
layout: post
title:  "Working with docker containers (draft)"
date:   2016-01-06 18:44:23 +0000
categories: draft
---



#Motivations

Setting up a working in a Linux environment usually requires to install many tools which turns out to be sometime trick when some of them have undocumented dependencies or when it comes to migrate to another machine or replicate the setup for someone else.

I used to keep track of the installation commands in some shell scripts, but that becomes very quickly untracktable since, without a new machine to reinstall, those scripts are rarely tested and become quickly obsolete.

With the apparition of the containers and tools like [docker][docker], it is now easy to keep the installation procedure in a **Dockerfile**, build container images and keep your host machine unpoluted from any developement tools.

#Installation steps on Ubuntu 14.04 LTS

The base minimun requirements, on a fresh Ubuntu LTS 14.04 host image, is install the following pre-requisites:

{% highlight bash %}
# Install from scratch the tools and a workspace on a new ubuntu desktop machine
sudo apt-get update
sudo apt-get -y upgrade

# Install docker. See: http://docs.docker.com/engine/installation/ubuntulinux/
sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo bash -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-$(lsb_release -sc) main" > /etc/apt/sources.list.d/docker.list'
sudo apt-get purge lxc-docker*   # Purge the old repo if it exists.
sudo apt-get update
apt-cache policy docker-engine   # Verify that apt is pulling from the right repository.
sudo apt-get install -y docker-engine
sudo usermod -aG docker $USER
newgrp docker; newgrp $USER      # Hack to force adding the docker group without logout
{% endhighlight %}

Docker is not easy to use especially for developement environment (See post of Abe Voelker “Why I don’t use Docker much anymore”) but it can be very useful even if it is just to document the installation procedures.


#Running a web server in a container


* [How To Secure Nginx with Let's Encrypt on Ubuntu 14.04][nginx-letsencrypt]
* [nw_isolated example in docker documentation][docker-a-bridge-network]
* [How To Set Up Password Authentication with Nginx on Ubuntu 14.04][nginx-authentication] with a password file
* add jekyll-dev/htpasswd to manage the .htpasswd file from the host. Use -B to force bcrypt encryption of the password for more security.

Check out the [Docker documentations][docker-docs] for more info.

[docker-docs]: https://docs.docker.com/
[docker]: http://www.docker.com/
[nginx-letsencrypt]: https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-14-04
[docker-a-bridge-network]: https://docs.docker.com/engine/userguide/networking/dockernetworks/#a-bridge-network
[letsencrypt]: https://letsencrypt.org/
[nginx-authentication]: https://www.digitalocean.com/community/tutorials/how-to-set-up-password-authentication-with-nginx-on-ubuntu-14-04



