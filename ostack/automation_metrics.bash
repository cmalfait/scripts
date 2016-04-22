#!/bin/bash

mkdir 00_deploy

pushd 00_deploy
rm -rf ./cookbooks
rm -rf ./data*
rm iaas*

#install chef client
yum -y install http://192.168.0.100/packages/chef-12.5.1-1.el6.x86_64.rpm

yum install -y wget telnet nc mlocate

#pull our cookbooks
wget http://192.168.0.100/data_bags/data_bags.tgz

wget http://192.168.0.100/cookbooks/latest/iaas_chef_repo_cookbook.tar.gz
wget http://192.168.0.100/cookbooks/latest/iaas_dns_cookbook.tar.gz 
wget http://192.168.0.100/cookbooks/latest/iaas_collectd_cookbook.tar.gz
wget http://192.168.0.100/cookbooks/latest/iaas_graphite_cookbook.tar.gz
wget http://192.168.0.100/cookbooks/latest/iaas_grafana_cookbook.tar.gz

#zero run
tar -xvf data_bags.tgz
tar -xvf iaas_chef_repo_cookbook.tar.gz
tar -xvf iaas_dns_cookbook.tar.gz
tar -xvf iaas_collectd_cookbook.tar.gz
tar -xvf iaas_graphite_cookbook.tar.gz
tar -xvf iaas_grafana_cookbook.tar.gz

ln -s ./cookbooks/iaas_chef_repo/environments
chef-client -z -Edevelopment -o recipe[iaas_dns::powerdns]
chef-client -z -Edevelopment -o recipe[iaas_collectd::yum]
chef-client -z -Edevelopment -o recipe[iaas_graphite::epel]
chef-client -z -Edevelopment -o recipe[iaas_graphite::default]
chef-client -z -Edevelopment -o recipe[iaas_graphite::firewall]
chef-client -z -Edevelopment -o recipe[iaas_graphite::postgresql]
chef-client -z -Edevelopment -o recipe[iaas_graphite::carbon]
chef-client -z -Edevelopment -o recipe[iaas_graphite::graphite]
chef-client -z -Edevelopment -o recipe[iaas_grafana::firewall]
chef-client -z -Edevelopment -o recipe[iaas_grafana::default]
chef-client -z -Edevelopment -o recipe[iaas_collectd::default]
chef-client -z -Edevelopment -o recipe[iaas_collectd::firewall]
chef-client -z -Edevelopment -o recipe[iaas_collectd::server]
chef-client -z -Edevelopment -o recipe[iaas_collectd::postgres]

popd
#rm -rf 00_deploy

#reboot

#yum -y install salt-minion

#if [[ ! $(grep "salt-master1.autodesk.internal" /etc/salt/minion) ]]; then
#  echo "master:" >> /etc/salt/minion
#  echo "  - salt-master1.autodesk.internal" >> /etc/salt/minion
#  echo "  - salt-master2.autodesk.internal" >> /etc/salt/minion
#else
#  echo "salt-masters found in /etc/salt/minion"
#fi

#service salt-minion start
