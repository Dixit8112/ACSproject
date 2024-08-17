#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://3.238.191.225/latest/meta-data/local-ipv4`
echo "<h1>Welcome to ACS730 ${prefix} Prepared By Sarthak, Dixit, Darshan and Shreyas!This is Private VM! My private IP is $myip<font color="RED"> in ${env} environment</font></h1><br>Built by Terraform!"  >  /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
