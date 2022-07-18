#!/bin/bash
# last minute patch, added 20 Aug. 2021
# added supprt for M1 Mac, Ubuntu on Parallels
# currently only supported on Ubuntu 20.04 LTS

sudo apt-get update -y
sudo apt-get install apt-transport-https ca-certificates curl gnupg gnupg-agent lsb-release software-properties-common -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/arm64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-arm64
sudo install minikube-linux-arm64 /usr/local/bin/minikube
####
echo the script is now ready
echo manually run minikube start --vm-driver=docker to start minikube

sudo usermod -aG docker $USER
newgrp docker

minikube start --vm-driver=docker
