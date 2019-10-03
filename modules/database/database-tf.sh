#!/bin/bash

echo "Creating yum list  for mongodb"
sudo yum update -y
sudo cd /etc/yum.repos.d
sudo touch mongodb-org.repo
sudo chmod 644 mongodb-org.repo
sudo chown isakovasvitlana:isakovasvitlana mongodb-org.repo
sudo cat >mongodb-org.repo<<'_EOF'
[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc

_EOF
sudo chown root:root mongodb-org.repo
echo " Installing Mongo "
sudo yum install -y mongodb-org
sudo systemctl start mongod
echo "Changing bindip parameter for mongod"
cd /etc
sudo sed -i -e 's/bindIp: 127.0.0.0/bindIp: 0.0.0.0/g' mongod.conf
echo "Restarting mongod service"
sudo systemctl stop mongod
sudo systemctl start mongod

