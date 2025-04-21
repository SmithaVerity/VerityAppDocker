#!/bin/bash

set -e
git clone https://SmithaVerity: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@github.com/SmithaVerity/verityapp.git    
cd verityapp/
sh deployApp.sh
sudo docker-compose up --build
sudo docker start verity
