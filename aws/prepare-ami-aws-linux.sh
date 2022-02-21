#!/bin/bash
sudo su root
yum -y update
yum install -y amazon-efs-utils
yum install -y nfs-utils
cd /tmp
# java
wget https://download.oracle.com/java/17/archive/jdk-17.0.2_linux-x64_bin.rpm
yum -y localinstall jdk-17.0.2_linux-x64_bin.rpm
echo export JAVA_HOME=/usr/java/jdk-17.0.2/ >> /etc/environment
# maven
wget https://www-eu.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
tar xf /tmp/apache-maven-*.tar.gz -C /opt
ln -s /opt/apache-maven-3.6.3 /opt/maven
echo "export JAVA_HOME=/usr/java/jdk-17.0.2/" >> /etc/profile.d/maven.sh
echo "export M2_HOME=/opt/maven" >> /etc/profile.d/maven.sh
echo "export MAVEN_HOME=/opt/maven" >> /etc/profile.d/maven.sh
echo "export PATH=\${M2_HOME}/bin:\${PATH}" >> /etc/profile.d/maven.sh
chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
# mongo
echo "[mongodb-org-4.4]" >> /etc/yum.repos.d/mongodb-org-4.4.repo
echo "name=MongoDB Repository" >> /etc/yum.repos.d/mongodb-org-4.4.repo
echo "baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.4/x86_64/" >> /etc/yum.repos.d/mongodb-org-4.4.repo
echo "gpgcheck=1" >> /etc/yum.repos.d/mongodb-org-4.4.repo
echo "enabled=1" >> /etc/yum.repos.d/mongodb-org-4.4.repo
echo "gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc" >> /etc/yum.repos.d/mongodb-org-4.4.repo
yum install -y mongodb-org-tools
