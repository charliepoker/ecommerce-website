#!/bin/bash

# This script will install Docker and create a user account for Docker to run with root privileges on an Ubuntu virtual machine

# Remove any old versions of Docker
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  sudo apt-get remove -y $pkg
done

# Update the package list and install prerequisites
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the Docker repository to APT sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list again and install Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify Docker installation
sudo docker run hello-world

# Check the status of the Docker service to ensure it is running
sudo systemctl status docker

# Add the 'jenkins' user to the 'docker' group so that Jenkins can run Docker commands
sudo usermod -aG docker jenkins

# Restart Jenkins to apply the group changes
sudo systemctl restart jenkins