#!/bin/bash

# Update APT
echo "Updating APT"
sleep 10
apt-get update


##### Unifi install
echo "Downloading and Installing Unifi Controller"
sleep 10

# Download latest Unifi controller script from 
wget https://get.glennr.nl/unifi/install/unifi-6.0.43.sh

# Install unifi
bash unifi-6.0.43.sh


##### pi-hole
echo "Downloading and Installing Pi-hole"
sleep 10

# Download and install pihole
apt-get install curl -y

curl -sSL https://install.pi-hole.net | bash

# Change password
pihole -a -p

# Change Pi-hole port
sed -i 's/80/33331/' /etc/lighttpd/lighttpd.conf

# restart pihole lighttpd
systemctl restart lighttpd


##### apache2
echo "Downloading and Installing Apache Web Server"
sleep 10

apt-get install apache2 -y

# Download my default webpage from github
git clone https://github.com/khaledkcara/myweb.git

# Move web to Apache directory
mv myweb/* /var/www/html


##### Guacamole
echo "Downloading and Installing Guacamole"
sleep 10

# Downloading and Installing Guacamole
wget https://git.io/fxZq5 -O guac-install.sh

# make the script excutable
chmod +x guac-install.sh

# run the script
bash guac-install.sh

# Change port
sed -i 's/8080/33333/' /etc/tomcat9/server.xml

# restart the server
systemctl restart guacd
systemctl restart tomcat9

##### Downloading and Installing FOGProject
echo "Downloading and Installing FOGProject"
sleep 10

# Downloading FOGProject
wget https://github.com/FOGProject/fogproject/archive/1.5.9.tar.gz

# Unzip
tar -xzvf 1.5.9.tar.gz

# move to bin directory
cd fogproject-1.5.9/bin

# run the script
./installfog.sh

# change directory
cd

#### Clean up
echo "Cleaning up script...."
sleep 15

rm -fdr /home/khalid/1.5.9.tar.gz
rm -fdr /home/khalid/guac-install.sh
rm -fdr /home/khalid/fogproject-1.5.9
rm -fdr /home/khalid/myweb
exec rm /home/khalid/prodvm.sh
exit
