#!/bin/bash
echo ${test} > /test.txt

set -e

sudo -s
apt-get update
apt-get install -y apache2
systemctl enable apache2

git clone https://github.com/SmithaVerity/ABTestingApp.git

echo GITHUB_TOKEN = ${test}
mv ABTestingApp/cafe /var/www/html
