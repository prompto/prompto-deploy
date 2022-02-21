#!/bin/bash
sudo su root
# wget
yum install -y wget
# mongo
echo "[mongodb-org-4.4]" >> /etc/yum.repos.d/mongodb-org-4.4.repo
echo "name=MongoDB Repository" >> /etc/yum.repos.d/mongodb-org-4.4.repo
echo "baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.4/x86_64/" >> /etc/yum.repos.d/mongodb-org-4.4.repo
echo "gpgcheck=1" >> /etc/yum.repos.d/mongodb-org-4.4.repo
echo "enabled=1" >> /etc/yum.repos.d/mongodb-org-4.4.repo
echo "gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc" >> /etc/yum.repos.d/mongodb-org-4.4.repo
yum install -y mongodb-org-tools
# maven
yum install -y maven2
# java
// corretto installed by maven2
echo export JAVA_HOME=/usr/java/jdk-17.0.2/ >> /etc/environment
