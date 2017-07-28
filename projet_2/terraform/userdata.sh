#!/bin/bash -v
sudo apt-get update -y
sudo apt-get install -y unzip wget vim locate curl > /tmp/apt.log

wget https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_amd64.zip

sudo unzip terraform_0.9.11_linux_amd64.zip -d /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform
