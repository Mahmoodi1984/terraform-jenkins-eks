#!/bin/bash
set -e  # Exit on error

# Update system
sudo yum update -y

# Install Amazon Corretto 17 (latest LTS Java)
sudo amazon-linux-extras enable corretto17
sudo yum install -y java-17-amazon-corretto

# Install required dependencies
sudo yum install -y git wget unzip

# Install Docker (latest version)
sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker

# Add 'jenkins' user to 'docker' group to run Docker without sudo
sudo usermod -aG docker jenkins

# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install -y jenkins

# Ensure Jenkins has proper permissions
sudo chown -R jenkins:jenkins /var/lib/jenkins /var/log/jenkins /var/cache/jenkins
sudo chmod -R 755 /var/lib/jenkins

# Reload systemd, enable and start Jenkins
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Check Jenkins service status
sudo systemctl status jenkins --no-pager