#!/bin/bash

yum -y update
yum -y install epel-release
yum -y install autoconf autoconf-archive automake ncurses-devel curl-devel erlang erlang-asn1 erlang-erts erlang-eunit erlang-os_mon erlang-xmerl gcc-c++ help2man js-devel libicu-devel libtool perl-Test-Harness wget


wget http://www-us.apache.org/dist/couchdb/source/2.0.0/apache-couchdb-2.0.0.tar.gz
tar -xvf apache-couchdb-2.0.0.tar.gz
cd apache-couchdb-2.0.0
./configure
make && make install


adduser -r --home /usr/local/var/lib/couchdb -M --shell /bin/bash --comment "CouchDB Administrator" couchdb
chown -R couchdb:couchdb /usr/local/var/lib/couchdb /usr/local/var/log/couchdb /usr/local/var/run/couchdb /usr/local/etc/couchdb
chmod 0770 /usr/local/etc/couchdb /usr/local/var/lib/couchdb /usr/local/var/log/couchdb /usr/local/var/run/couchdb

ln -sf /usr/local/etc/rc.d/couchdb /etc/init.d/couchdb
chkconfig --add couchdb
chkconfig couchdb on


# get a list of active zones.. you might have more.
firewall-cmd --get-active-zones

# firewalld command to allow this port open to dmz
firewall-cmd --zone=public --add-port=5984/tcp   --permanent

# Restart the firewalld service
firewall-cmd --reload

# Start couchdb as a daemon
/usr/local/etc/rc.d/couchdb start
