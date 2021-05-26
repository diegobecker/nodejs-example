#!/bin/bash
set -x

sudo apt update -y
sudo apt upgrade -y

sudo apt install nodejs -y
sudo apt install npm -y
sudo npm install --global yarn

git clone https://github.com/budimanfajarf/node-hello-world.git

