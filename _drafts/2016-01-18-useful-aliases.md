---
layout: post
title:  "Collection of useful aliases (draft)"
date:   2016-01-18 00:00:00 +0000
categories: draft
---


Here is a list of linux command and aliases that I found handy.


{% highlight bash %}

# Generate a random password
randpw(){ < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;}

{% endhighlight %}

