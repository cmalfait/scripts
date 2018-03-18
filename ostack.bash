#!/bin/bash

sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo systemctl disable NetworkManager
sudo systemctl stop NetworkManager
sudo systemctl enable network
sudo systemctl start network

sudo yum install -y centos-release-openstack-queens
yum-config-manager --enable openstack-queens
sudo yum update -y
sudo yum install -y openstack-packstack

##create volume group for cinder
yum install lvm2
systemctl enable lvm2-lvmetad.service
systemctl start lvm2-lvmetad.service
pvcreate /dev/sda
vgcreate cinder-volumes /dev/sda

packstack --allinone --provision-demo=n --os-neutron-ovs-bridge-mappings=extnet:br-ex --os-neutron-ovs-bridge-interfaces=br-ex:enp30s0 --os-neutron-ml2-type-drivers=vxlan,flat --cinder-backend=lvm --cinder-volumes-size=250G --cinder-volume-name=cinder-volumes --default-password='Chang3m3' --os-magnum-install=y --os-ceilometer-install=y --os-heat-install=y --os-neutron-lbaas-install=y

cat << EOF > /etc/sysconfig/network-scripts/ifcfg-br-ex
DEVICE=br-ex
DEVICETYPE=ovs
TYPE=OVSBridge
BOOTPROTO=static
IPADDR=192.168.0.10 
NETMASK=255.255.0.0 
GATEWAY=192.168.0.1
DNS1=192.168.0.1  
ONBOOT=yes
EOF

cat << EOF > /etc/sysconfig/network-scripts/ifcfg-enp30s0
DEVICE=enp30s0
TYPE=OVSPort
DEVICETYPE=ovs
OVS_BRIDGE=br-ex
ONBOOT=yes
EOF

reboot

source /root/keystonerc_admin

openstack network create --provider-network-type flat --provider-physical-network extnet --default --external external_network
openstack subnet create --network external_network --dhcp --dns-nameserver 192.168.0.1 --allocation-pool start=192.168.1.100,end=192.168.1.200 --gateway 192.168.0.1 --subnet-range 192.168.0.0/23 external_subnet
openstack router create router1
openstack router set router1 --external-gateway external_network

####################################################################

openstack network create internal_network
openstack subnet create --network internal_network --dhcp --dns-nameserver 192.168.0.1 --allocation-pool start=10.0.0.10,end=10.0.0.250 --subnet-range 10.0.0.0/8 internal_subnet
openstack router add subnet router1 internal_subnet

curl http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img | glance image-create --name='cirros image' --visibility=public --container-format=bare --disk-format=qcow2

curl http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2c | glance image-create --name='centos7' --visibility=public --container-format=bare --disk-format=qcow2

