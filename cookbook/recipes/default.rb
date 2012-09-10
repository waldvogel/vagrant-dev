# Run apt-get update to create the stamp file
execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  not_if do ::File.exists?('/var/lib/apt/periodic/update-success-stamp') end
end

# For other recipes to call to force an update
execute "apt-get update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end

# provides /var/lib/apt/periodic/update-success-stamp on apt-get update
package "update-notifier-common" do
  notifies :run, resources(:execute => "apt-get-update"), :immediately
end

execute "apt-get-update-periodic" do
  command "apt-get update"
  ignore_failure true
  only_if do
    File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
    File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  end
end

# install the software we need
%w(
openjdk-6-jre-headless
curl
tmux
vim
emacs23-nox
git
libapache2-mod-php5
mysql-server
postgresql
php5-cli
php5-curl
php5-intl
php5-sqlite
php5-mysql
php5-pgsql
php5-gd
php5-xmlrpc
php5-imagick
sqlite3
).each { | pkg | package pkg }


service "apache2" do
  supports :restart => true, :reload => true, :status => true
  action [ :enable, :start ]
end

execute "date.timezone = UTC in php.ini?" do
  user "root"
  not_if "grep 'date.timezone = UTC' /etc/php5/cli/php.ini"
  command "echo -e '\ndate.timezone = UTC\n' >> /etc/php5/cli/php.ini"
end

# install additional php modules, enable apache2 rewrite
bash "install PHPUnit via pear" do
  not_if "pear list -a | grep PHPUnit"
  code <<-PEAR
  set -e
  pear config-set auto_discover 1
  pear install --alldeps pear.phpunit.de/PHPUnit
  PEAR
end
