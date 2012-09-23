%w(
openjdk-6-jre-headless
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
php-pear
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
