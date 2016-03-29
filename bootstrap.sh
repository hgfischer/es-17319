#!/bin/bash -vfx

# Disable interactive mode
sudo mv -v /etc/apt/apt.conf.d/70debconf /root/etc-apt-apt.conf.d-70debconf.bak
sudo dpkg-reconfigure debconf -f noninteractive -p critical

# Disable cloud init
echo 'datasource_list: [ None ]' | sudo -s tee /etc/cloud/cloud.cfg.d/90_dpkg.cfg
sudo dpkg-reconfigure -f noninteractive cloud-init

# Uninstall unused software
sudo apt-get purge chef chef-zero puppet puppet-common landscape-client landscape-common -y

# Setup ES repo
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list

# Setup Java
add-apt-repository ppa:webupd8team/java

# Update everything
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove

# Install Java
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get -y install oracle-java8-installer oracle-java8-set-default

# Install locales
sudo apt-get -y install language-pack-en

# Install ES
sudo apt-get -y install elasticsearch 
cat elasticsearch | sudo tee /etc/default/elasticsearch
cat elasticsearch.yml | sudo tee /etc/elasticsearch/elasticsearch.yml
sudo update-rc.d elasticsearch defaults 95 10

# Reboot
sudo reboot
