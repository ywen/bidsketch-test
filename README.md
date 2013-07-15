bidsketch-test
==============================================

[![Build Status](https://travis-ci.org/ywen/bidsketch-test.png?branch=master)](https://travis-ci.org/ywen/bidsketch-test)
[![Code Quality](https://codeclimate.com/badge.png)](https://codeclimate.com/github/ywen/bidsketch-test)


### Screenshots

![Page 1](http://f.cl.ly/items/422P3A1q1j1Z3R0J3S2a/Screen%20Shot%202013-07-15%20at%203.14.20%20PM.png)


![Page 2](http://f.cl.ly/items/1r1G130e2S3u100K1Z0Z/Screen%20Shot%202013-07-15%20at%203.14.32%20PM.png)

### Design

The following is not supposed to explain all the design concerns, rather something that are not found in a typical "traditional" Rails application

- A service layer is used for business flow process, in this case, to replace the templates with the real information
- A presenter layer is used for get the data from the database and reformat to present it. In this case, ```formatted_send_date``` is a good example
- With both layers, the controller becomes thin and the view is dumb. The models host only model related information, not be tampered with business flow or presentation logic
