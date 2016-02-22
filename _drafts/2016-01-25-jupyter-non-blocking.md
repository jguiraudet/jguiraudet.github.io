---
layout: post
title:  "Non blocking operation in Ipython/Jupyter notebooks (draft)"
date:   2016-01-25 00:00:00 +0000
categories: draft
---

# Non blocking operation

{% highlight bash %}

kernel = get_ipython().kernel
kernel.do_one_iteration() # Run IPython iteration.  This is the code that
                          # makes this operation non-blocking.  This will
                          # allow widget messages and callbacks to be 
                          # processed.


{% endhighlight %}


# References:
 * Nonblocking Console.ipynb example at [https://github.com/jupyter/ngcm-tutorial](https://github.com/jupyter/ngcm-tutorial/blob/master/Day-2/Nonblocking%20Console.ipynb)


