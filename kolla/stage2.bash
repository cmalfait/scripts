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

vi /etc/ansible/ansible.cfg
[defaults]
host_key_checking=False
pipelining=True
forks=100

cp -r /usr/share/kolla-ansible/etc_examples/kolla /etc/
cp /usr/share/kolla-ansible/ansible/inventory/* .

vi /etc/kolla/globals.yml 
interface, magnum, cinder, swift, lbaas, VIP, disable haproxy

index=0
for d in sda sdc sdd; do
    parted /dev/${d} -s -- mklabel gpt mkpart KOLLA_SWIFT_DATA 1 -1
    sudo mkfs.xfs -f -L d${index} /dev/${d}1
    (( index++ ))
done


kolla-genpwd

kolla-ansible -i ./all-in-one bootstrap-servers
kolla-ansible -i ./all-in-one prechecks
kolla-ansible -i ./all-in-one deploy 


kolla-ansible post-deploy
cp /etc/kolla/admin-openrc.sh .

source /etc/kolla/admin-openrc.sh
vi /usr/share/kolla-ansible/init-runonce
. /usr/share/kolla-ansible/init-runonce

###TROUBLESHOOT
docker ps -a
docker exec -it fluentd bash

#The logs from all services in all containers may be read from /var/log/kolla/SERVICE_NAME

If the stdout logs are needed, please run:
docker logs <container-name>


