#!/bin/bash

########source TeamCity.sh - запуск скрипта  щоб працював експорт #####
cd /home/isakovasvitlana
sudo yum install -y wget uzip
sudo wget https://download.jetbrains.com/teamcity/TeamCity-2019.1.3.tar.gz
sudo tar -xvf TeamCity-2019.1.3.tar.gz
echo "Install java"
sudo yum install -y java
sudo yum install -y java-devel
echo "Export JAVA_HOME PATH"
sudo bash -c 'echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-1.el7_7.x86_64" >> /etc/profile'
sudo bash -c 'echo "export PATH=$PATH:/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-1.el7_7.x86_64/bin" >> /etc/profile'
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-1.el7_7.x86_64 
export PATH=$PATH:/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-1.el7_7.x86_64/bin
echo "Install mysql"
sudo wget http://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo chown isakovasvitlana:isakovasvitlana mysql80-community-release-el7-3.noarch.rpm
sudo rpm -Uvh mysql80-community-release-el7-3.noarch.rpm
sudo yum install -y mysql-server
sudo systemctl start mysqld
root_temp_pass=$(sudo grep 'A temporary password' /var/log/mysqld.log |tail -1 |awk '{split($0,a,": "); print a[2]}')
echo "root_temp_pass:"$root_temp_pass"
echo "Changing default password into Database"
cat > mysql_secure_installation.sql << 'EOF'
# Make sure that NOBODY can access the server without a password
ALTER USER 'root'@'localhost' IDENTIFIED BY 'passwd';
# Kill the anonymous users
DELETE FROM mysql.user WHERE User='';
# disallow remote login for root
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
# Kill off the demo database
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
# Make our changes take effect
FLUSH PRIVILEGES;
_EOF
echo "Creating user teamcity and database teamsity"
mysql -uroot -p"$root_temp_pass" --connect-expired-password <mysql_secure_installation.sql
USER=root
PASSWORD=La#r**cD1111
sudo mysql -u $USER -p$PASSWORD -e "create database teamcity character set UTF8 collate utf8_bin"
sudo mysql -u $USER -p$PASSWORD -e "create user 'teamcityuser'@'localhost' identified by 'k2mk3x8zc0#H'"
sudo mysql -u $USER -p$PASSWORD -e "grant all privileges on teamcity.* to 'teamcityuser'@'localhost'"
echo "Installing Terraform"
cd ..
sudo wget https://releases.hashicorp.com/terraform/0.12.9/terraform_0.12.9_linux_amd64.zip
sudo unzip ./terraform_0.12.9_linux_amd64.zip -d /usr/local/bin/
export PATH=$PATH:/usr/local/bin
sudo bash -c 'echo "export PATH=$PATH:/usr/local/bin" >> /etc/profile'
sudo useradd teamcity
echo "Installing Appache maven"
cd /home/isakovasvitlana/
wget http://www-us.apache.org/dist/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz
sudo tar -xf apache-maven-3.6.2-bin.tar.gz
sudo mv  apache-maven-3.6.2  /opt/apache-maven
sudo chown teamcity:teamcity /opt/apache-maven
echo "Creating directory for TeamCity"
sudo mkdir /opt/jetbrains
sudo  mv /home/isakovasvitlana/TeamCity /opt/jetbrains
sudo chown -R teamcity:teamcity /opt/jetbrains
echo "Creating service teamcity"
cd /etc/systemd/system
sudo touch teamcity.service
sudo chmod 644 teamcity.service
sudo chown isakovasvitlana:isakovasvitlana teamcity.service
sudo cat >teamcity.service<<'_EOF'
[Unit]
Description=JetBrains TeamCity
Requires=network.target
After=syslog.target network.target

[Service]
Type=simple
PIDFile=/opt/jetbrains/TeamCity/logs/teamcity.pid
ExecStart=/opt/jetbrains/TeamCity/bin/teamcity-server.sh run
ExecStop=/opt/jetbrains/TeamCity/bin/teamcity-server.sh stop
User=teamcity

[Install]
WantedBy=multi-user.target
_EOF
sudo chown root:root teamcity.service
echo "Install MySql connector"
cd /home/isakovasvitlana
wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.17.tar.gz -O mysql-connector.tar.gz
tar -zxvf mysql-connector.tar.gz
sudo mv mysql-connector-java-8.0.17/mysql-connector-java-8.0.17.jar /opt/jetbrains/TeamCity/lib/
sudo chown -R teamcity:teamcity /opt/jetbrains
cd /home/isakovasvitlana/
sudo mkdir keys
sudo mv united-aura-252016-a5e385393212.json keys
chown teamcity:teamcity keys
sudo systemctl enable teamcity.service
sudo systemctl start teamcity.service
sudo useradd buildagent
sudo unzip buildAgent.zip -d tcagent/
chown -R buildagent:buildagent tcagent/
sudo mv tcagent.service /etc/systemd/system
sudo systemctl enable tcagent.service
sudo systemctl start tcagent.service
sudo mv id_git.pub id_git config /home/isakovasvitlana/.ssh
sudo chown -R isakovasvitlana:isakovasvitlana /home/isakovasvitlana/.ssh 
