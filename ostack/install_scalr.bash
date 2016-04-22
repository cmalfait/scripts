#!/bin/bash

git clone https://github.com/Scalr/scalr.git

# Install the repository
curl -L https://packagecloud.io/install/repositories/scalr/scalr-server-oss/script.rpm | sudo bash
 
# Install Scalr
sudo yum install -y scalr-server

# Generate (and display) the default configuration files.
sudo /opt/scalr-server/bin/scalr-server-wizard 

# Reload/restart all scalr components with the new configuration
sudo /opt/scalr-server/bin/scalr-server-ctl reconfigure

#/etc/scalr-server/scalr-server-secrets.json, under app.admin_password.
cat /etc/scalr-server/scalr-server-secrets.json


#######3
PLATFORM=openstack 
wget https://my.scalr.net/public/linux/latest/$PLATFORM/install_scalarizr.sh 
sudo bash

#PLATFORM=openstack && curl -L https://my.scalr.net/public/linux/latest/$PLATFORM/install_scalarizr.sh | sudo bash
