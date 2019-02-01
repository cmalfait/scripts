#!/bin/bash

yum -y install epel-release
yum -y install python-pip
pip install -U pip
yum -y install python-devel libffi-devel gcc openssl-devel libselinux-python
yum -y install ansible
pip install -U ansible
yum -y erase PyYAML
pip install kolla-ansible
pip install python-openstackclient python-glanceclient python-neutronclient python-swiftclient python-magnumclient --ignore-installed
yum -y install PyYAML ansible vdo

cp -r /usr/share/kolla-ansible/etc_examples/kolla /etc/
cp /usr/share/kolla-ansible/ansible/inventory/* .

cp globals.yml /etc/kolla/

kolla-genpwd

kolla-ansible -i ./all-in-one bootstrap-servers
kolla-ansible -i ./all-in-one prechecks
kolla-ansible -i ./all-in-one deploy 


kolla-ansible post-deploy
cp /etc/kolla/admin-openrc.sh .

source /etc/kolla/admin-openrc.sh
#vi /usr/share/kolla-ansible/init-runonce
#. /usr/share/kolla-ansible/init-runonce
#
####TROUBLESHOOT
#docker ps -a
#docker exec -it fluentd bash
#
##The logs from all services in all containers may be read from /var/log/kolla/SERVICE_NAME
#
#If the stdout logs are needed, please run:
#docker logs <container-name>
