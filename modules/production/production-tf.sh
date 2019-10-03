#!/bin/bash
      ###create buildserver###
sudo apt-get update      
sudo useradd -m buildserver  -s /bin/bash
echo "Copy  javaexe.sh"
sudo mv /home/isakovasvitlana/javaexe.sh /home/buildserver/
sudo chown buildserver:buildserver /home/buildserver/javaexe.sh
sudo mkdir /home/buildserver/.ssh
sudo chmod 700 /home/buildserver/.ssh
sudo mv /home/isakovasvitlana/buildserver.pub /home/buildserver/.ssh
sudo chown -R buildserver:buildserver /home/buildserver/.ssh
sudo mkdir /home/buildserver/Demo_part1_cards
sudo chown buildserver:buildserver /home/buildserver/Demo_part1_cards
sudo apt-get install -y default-jre
cd /etc/systemd/system/
sudo touch carts.service
sudo chmod 644 carts.service
echo "Create carts service"
sudo cat >carts.service<<'_EOF'
[Unit]
Description=Cartsrun
After=network.target

[Service]
WorkingDirectory=/home/buildserver/
Type=simple
ExecStart=/bin/bash javaexe.sh start
User=buildserver

[Install]
WantedBy=multi-user.target
_EOF
sudo apt install -y nginx
cd /etc/nginx/sites-available
sudo mv default default.example
sudo touch carts.com
sudo chmod 644 carts.com
sudo chown isakovasvitlana:isakovasvitlana carts.com
echo "Configure virtual host carts for nginx"
sudo cat >carts.com<<'_EOF'
server {
  listen 0.0.0.0:80;
  listen [::]:80;

  server_name hostname;

  location / {
      proxy_pass http://localhost:8081/;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Real-IP $remote_addr;
  }
 } 
_EOF
sudo ln -s /etc/nginx/sites-available/carts.com  /etc/nginx/sites-enabled/carts.com
sudo chown root:root /etc/nginx/sites-enabled/carts.com
echo "Stop nginx"
sudo systemctl stop nginx
echo "Start nginx"
sudo systemctl start nginx