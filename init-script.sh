#!/bin/bash

set -e
git clone -b master https://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@github.com/SmithaVerity/verityapp.git    
cd verityapp/
sh deployApp.sh
sudo docker-compose up --build
sudo docker start verity
