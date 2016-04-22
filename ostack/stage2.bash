#! /bin/bash
#
# runonce       runonce
# chkconfig: 2345 55 25
# description: runonce to configure openstack networks
#
### BEGIN INIT INFO
# Provides: runonce
### END INIT INFO

case "$1" in
  start)
	source /root/keystonerc_admin

	##Create public shit
        neutron net-create public --router:external

        neutron subnet-create public 192.168.0.0/16 --name vlan --enable_dhcp=False --allocation_pool start=192.168.1.10,end=192.168.1.250 --gateway 192.168.0.1

        neutron router-create router1
        neutron router-gateway-set router1 public

	##Create private shit
	neutron net-create private_network
	neutron subnet-create --name private_subnet --allocation-pool=start=10.0.0.10,end=10.0.0.250 --dns-nameserver 192.168.100.15 private_network 10.0.0.0/8 

	##Connect it up
	neutron router-interface-add router1 private_subnet

	##get an image
	curl http://192.168.0.100/images/cirros-0.3.4-x86_64-disk.img | glance image-create --name='cirros' --container-format=bare --disk-format=qcow2

	curl http://192.168.0.100/images/CentOS-6-x86_64-GenericCloud-1510.qcow2 | glance image-create --name='centos-6.7' --container-format=bare --disk-format=qcow2

	curl http://192.168.0.100/images/CentOS-7-x86_64-GenericCloud-1510.qcow2 | glance image-create --name='centos-7.1' --container-format=bare --disk-format=qcow2

	curl http://192.168.0.100/images/trusty-server-cloudimg-amd64-disk1.img | glance image-create --name='ubuntu-14.04' --container-format=bare --disk-format=qcow2

	echo "Done"
	##
	echo "Mission Complished...Mherika"
#        chkconfig runonce off
        ;;
  *)
        echo $"Usage: $0 {start|stop|restart}"
        exit 2
esac
exit $rc
