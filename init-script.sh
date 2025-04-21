#!/bin/bash

set -e
export GITHUB_TOKEN=${GITHUB_TOKEN}
git clone https://SmithaVerity:${GITHUB_TOKEN}@github.com/SmithaVerity/verityapp.git    

cd verityapp/
sh deployApp.sh
sudo docker-compose up --build
sudo docker start verity
