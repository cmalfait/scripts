#!/bin/bash

echo "Installing requirements..."
yum -y install epel-release
yum -y install python-pip
pip install -U pip
yum -y install python-devel libffi-devel gcc openssl-devel libselinux-python
yum -y install ansible
pip install -U ansible
yum -y erase PyYAML
pip install kolla-ansible
pip install python-heatclient python-openstackclient python-glanceclient python-neutronclient python-swiftclient python-magnumclient python-designateclient --ignore-installed
yum -y install PyYAML ansible vdo
echo "Done installing requirements..."
sleep 5
clear

echo "copying configs..."
cp -r /usr/share/kolla-ansible/etc_examples/kolla /etc/
cp /usr/share/kolla-ansible/ansible/inventory/* .

cp globals.yml /etc/kolla/
kolla-genpwd
echo "Done copying configs..."
sleep 5
clear

echo "Creating swift ring..."
./swift_ring.bash
echo "Done creating swift ring..."
sleep 5
clear

echo "deploying kolla"
kolla-ansible -i ./all-in-one bootstrap-servers
kolla-ansible -i ./all-in-one prechecks
kolla-ansible -i ./all-in-one deploy 
echo "Done deploying..."
sleep 5
clear

echo "post deploy..."
kolla-ansible post-deploy
cp /etc/kolla/admin-openrc.sh .

source /etc/kolla/admin-openrc.sh

. ./init-runonce
echo "Done with post..."
sleep 5

####TROUBLESHOOT
#docker ps -a
#docker exec -it fluentd bash
#
##The logs from all services in all containers may be read from /var/log/kolla/SERVICE_NAME
#
#If the stdout logs are needed, please run:
#docker logs <container-name>
