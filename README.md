bidsketch-test
==============================================

[![Build Status](https://travis-ci.org/ywen/bidsketch-test.png?branch=master)](https://travis-ci.org/ywen/bidsketch-test)
[![Code Quality](https://codeclimate.com/badge.png)](https://codeclimate.com/github/ywen/bidsketch-test)


### Design

The following is not supposed to explain all the design concerns, rather something that I feel worth of mentioning.

- A service layer is used for business flow process, in this case, to replace the templates with the real information
- A presenter layer is used for get the data from the database and reformat to present it. In this case, ```formatted_send_date``` is a good example
- With both layers, the controller becomes thin and the view is dumb. The models host only model related information, not be tampered with business flow or presentation logic
- ```nokogiri``` is used for processing HTML only for proposal sections because for proposal related template, it is easier (probably faster) to just do a plain text replacement
- I believe pre-matured performance tuning is evil and unnessary so I didn't pay much attention on this (should it be faster if I find a way to do all string replacements in one pass? the answer is probably a yes, however, the app is running fast enough as is so I did not make any effort to try to get it smarter and faster). A smart approach could make the app faster but it could also make the code harder to udnerstand.

### Screenshots

![Page 1](http://f.cl.ly/items/422P3A1q1j1Z3R0J3S2a/Screen%20Shot%202013-07-15%20at%203.14.20%20PM.png)


![Page 2](http://f.cl.ly/items/1r1G130e2S3u100K1Z0Z/Screen%20Shot%202013-07-15%20at%203.14.32%20PM.png)
