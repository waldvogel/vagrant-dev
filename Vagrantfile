# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'rbconfig'
WINDOWS = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/) ? true : false

# use hostmaster only if not on Windows
require File.dirname(__FILE__) + "/hostmaster/hostmaster.rb" unless WINDOWS

Vagrant::Config.run do |config|

  # common settings
  config.vm.box = "precise32"
  config.vm.customize ["modifyvm", :id, "--memory", 768]
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  config.vm.share_folder "v-root", "/vagrant", "." , :nfs => !WINDOWS

  # php box
  config.vm.define :php do |config|
    box = "php"
    config.hosts.name = box + ".lo" unless WINDOWS
    config.vm.network :hostonly, "172.90.90.90"
    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.log_level = ENV['CHEF_LOG'] || "info"
      chef.add_recipe("common")
      chef.add_recipe(box)
    end
  end

  # ruby box
  config.vm.define :ruby do |config|
    box = "ruby"
    config.hosts.name = box + ".lo" unless WINDOWS
    config.vm.network :hostonly, "172.90.90.91"
    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.log_level = ENV['CHEF_LOG'] || "info"
      chef.add_recipe("common")
      chef.add_recipe(box)
    end
  end
  
end
