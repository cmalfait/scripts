#!/bin/bash

echo "192.168.0.101 ostack1" >> /etc/hosts

cat /etc/hosts
sleep 5

###Pulling bits and installing openstsck
sudo yum install -y https://rdoproject.org/repos/rdo-release.rpm
#sudo yum install -y https://repos.fedorapeople.org/repos/openstack/openstack-kilo/rdo-release-liberty-1.noarch.rpm
#sudo yum install -y https://repos.fedorapeople.org/repos/openstack/openstack-kilo/rdo-release-kilo-1.noarch.rpm
#sudo yum install -y https://repos.fedorapeople.org/repos/openstack/openstack-juno/rdo-release-juno-1.noarch.rpm

sudo yum update -y
sudo yum install -y openstack-packstack

systemctl stop NetworkManager
systemctl disable NetworkManager
systemctl enable network
chkconfig NetworkManager off

packstack --allinone --provision-demo=n --os-heat-install=y --cinder-volumes-size=300G --os-neutron-lbaas-install=y

###Back up some files before overwriting ...
echo "backing up ..."
BACKUP_DIR="/root/backups"
mkdir -p $BACKUP_DIR

cp /etc/sysconfig/network-scripts/ifcfg* $BACKUP_DIR/
cp /etc/neutron/plugin.ini $BACKUP_DIR/

echo "DONE"

#### Set up the networking correctly ...
echo "Creating new br-ex ..."
cat << BREX > /etc/sysconfig/network-scripts/ifcfg-br-ex
DEVICE=br-ex
DEVICETYPE=ovs
TYPE=OVSBridge
ONBOOT=yes
IPADDR=192.168.0.101
NETMASK=255.255.0.0
GATEWAY=192.168.0.1
DNS1=8.8.8.8
BREX
echo "Done"

echo "Creating new enp8s0 ..."
cat << ETH > /etc/sysconfig/network-scripts/ifcfg-enp8s0
DEVICE=enp8s0
ONBOOT=yes
HWADDR=78:24:af:8f:89:cd
DEVICETYPE=ovs
TYPE=OVSPort
OVS_BRIDGE=br-ex
ETH
echo "Done"
####

clear
echo "Editing .ini ..."
source /root/keystonerc_admin
openstack-config --set /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini ovs bridge_mappings extnet:br-ex
openstack-config --set /etc/neutron/plugin.ini ml2 type_drivers vxlan,flat,vlan
openstack-config --set /etc/neutron/dhcp_agent.ini DEFAULT enable_isolated_metadata True 
openstack-config --set /etc/neutron/dhcp_agent.ini DEFAULT use_namespaces True 
openstack-config --set /etc/neutron/dhcp_agent.ini DEFAULT enable_metadata_network True 
openstack-config --set /etc/neutron/dhcp_agent.ini DEFAULT dhcp_domain murphy.local 
openstack-config --set /etc/neutron/dhcp_agent.ini DEFAULT interface_driver neutron.agent.linux.interface.OVSInterfaceDriver 

echo "Mission Complished...Mherika...Rebootin.."
reboot
