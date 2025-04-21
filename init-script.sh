#!/bin/bash

set -e
git clone https://github.com/SmithaVerity/verityapp.git    
SmithaVerity
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
cd verityapp/
sh deployApp.sh
sudo docker-compose up --build
sudo docker start verity
