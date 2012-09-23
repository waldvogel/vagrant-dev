# Vagrant Development Boxes (Multi VM) #

Base boxes to work on various smaller projects that don't deserve their own setup.
Based on the latest official Vagrant Ubuntu version.

## Prerequisites: ##

  - [Virtualbox](https://www.virtualbox.org/)
  - [Vagrant](http://vagrantup.com)

## Getting the repository ##

    git clone git://github.com/waldvogel/vagrant-dev.git
    cd vagrant-dev

## Boxes

Currently the setup contains two configurations:

### ruby

- Ruby 1.9.3
- Latest Ruby on Rails (installed with `gem install rails`)
- Devel Libraries to setup:
  * [Locomotive CMS](http://www.locomotivecms.com/)
  * [tentd](https://github.com/tent/tentd/)
  * [tentd-admin](https://github.com/tent/tentd-admin/)

### php

- Apache2 with mod php
- PHP5 with the following libraries:
  curl, sqlite, mysql, intl, pgsql, xdebug, xsl, xmlprc, imagick
- phpunit
- sqlite CLI
- mysql server and client
- postgresql

## Handling

**Important is to remember that the vagrant commands operate on all the boxes if you don't specify one**

### Starting

Bring the `ruby` box up:

    vagrant up ruby
    
Bring all boxes up:

    vagrant up

### Accessing ##

The hostmaster plugin manages the IP addresses via `/etc/hosts` (except on Windows). Therefore any of the boxes should be reachable through the **name** plus `.lo`. So for example:

<http://ruby.lo/>

ssh access works like this:

    vagrant ssh <boxname>
    

### Suspending/Resuming ##

    vagrant suspend <boxname>

After that, to work with it again:

    vagrant resume <boxname>

### Destroying ##

To get rid all the boxes:

    vagrant destroy 

To force it (quicker) add `-f`

To destroy only `ruby`:

    vagrant destroy ruby -f
