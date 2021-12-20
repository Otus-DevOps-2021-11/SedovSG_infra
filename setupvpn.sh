#!/bin/bash
apt-get install gnupg2 sudo -y
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" \
| sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
echo "deb http://repo.pritunl.com/stable/apt focal main" > /etc/apt/sources.list.d/pritunl.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 20691EEC35216C63CAF66CE1656408E390CFB1F5
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
apt-get --assume-yes update
apt-get --assume-yes upgrade
apt-get --assume-yes install pritunl mongodb-server
systemctl start pritunl mongodb
systemctl enable pritunl mongodb
