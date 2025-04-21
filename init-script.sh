#!/bin/bash

set -e
git clone https://SmithaVerity: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@github.com/SmithaVerity/verityapp.git    
cd verityapp/
sh deployApp.sh
sudo docker-compose up --build
sudo docker start verity
