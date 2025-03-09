#!/bin/bash
set -e  # Exit on error

# Update and install Java (Java 11)
sudo yum update -y
sudo amazon-linux-extras enable corretto11
sudo yum install -y java-17-amazon-corretto

sudo yum install -y java-11-amazon-corretto


# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install -y jenkins

# Ensure Jenkins has proper permissions
sudo chown -R jenkins:jenkins /var/lib/jenkins /var/log/jenkins /var/cache/jenkins
sudo chmod -R 755 /var/lib/jenkins

# Start Jenkins with delay to ensure installation is complete
sleep 10

# Reload systemd, enable and start Jenkins
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
=======
sudo systemctl start jenkins

# Check for any errors in logs
sudo journalctl -xe -u jenkins