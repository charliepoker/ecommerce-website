#!/bin/bash

# Update your package index
sudo apt update

# Install Java (required for Jenkins):
sudo apt install fontconfig openjdk-17-jre -y

# Import the GPG key and add the repository
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list >/dev/null

# Update the package index
sudo apt-get update

# Install Jenkins
sudo apt-get install jenkins -y

# Start Jenkins Service
sudo systemctl start jenkins

# Enable Jenkins to start at boot
sudo systemctl enable jenkins
