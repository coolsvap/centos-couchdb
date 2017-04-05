FROM centos:7

COPY scripts/install-couchdb.sh /tmp
RUN ["chmod", "+x", "/tmp/install-couchdb.sh" ]
RUN ["./tmp/install-couchdb.sh"]
