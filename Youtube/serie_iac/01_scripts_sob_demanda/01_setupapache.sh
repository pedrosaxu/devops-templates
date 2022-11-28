#!/bin/bash
sudo apt-get update
sudo apt-get install -y php apache2
sudo su - 
sudo echo "Hello World" > /var/www/html/index.html
sudo service apache2 restart




