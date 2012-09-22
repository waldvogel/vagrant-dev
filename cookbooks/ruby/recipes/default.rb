# install the software we need
%w(
curl
vim
git
sqlite3
mongodb
build-essential
ruby1.9.3
libxml2-dev
libxslt1-dev
libmagickcore-dev
libmagickwand-dev
).each { | pkg | package pkg }

execute "install rails" do
  not_if "gem list --local | grep rails"
  command "gem install rails"
end
