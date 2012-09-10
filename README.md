# Vagrant PHP Development Box #

Generic box to work on various smaller PHP projects that don't deserve their own setup.

The box is based on the latest official Vagrant Ubuntu version and will install:

- Apache2 with mod php
- PHP5 with the following libraries:
  curl, sqlite, mysql, intl, pgsql, xdebug, xsl, xmlprc, imagick
- phpunit
- sqlite CLI
- mysql server and client
- postgresql

## Prerequisites: ##

  - [Virtualbox](https://www.virtualbox.org/)
  - [Vagrant](http://vagrantup.com)

## Getting the repository ##

    git clone git://github.com/waldvogel/vagrant-php-dev.git
    cd vagrant-php-dev

## Accessing the box ##

    vagrant ssh
    
 The box has the IP address 172.99.99.99
 You can setup apache and access it from your host.

## Suspending/Resuming ##

    vagrant suspend

After that, to work with it again:

    vagrant resume

## Destroying ##

To get rid of the box totally:

    vagrant destroy 

To force it (quicker) add `-f`
