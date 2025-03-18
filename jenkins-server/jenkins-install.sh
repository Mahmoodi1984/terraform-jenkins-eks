#!/bin/bash 
set -e  # Exit on error

exec > /var/log/user-data.log 2>&1  # Redirect output for debugging

echo "Starting Jenkins installation script..."

# Wait for any yum processes to finish
while sudo fuser /var/run/yum.pid >/dev/null 2>&1; do
    echo "Waiting for yum lock..."
    sleep 10
done

echo "Updating system..."
sudo yum update -y

echo "Installing Amazon Corretto 17..."
sudo yum install -y java-17-amazon-corretto

echo "Installing dependencies..."
sudo yum install -y git wget unzip

echo "Installing Docker..."
sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker

# Add 'jenkins' user to 'docker' group
echo "Adding Jenkins user to Docker group..."
sudo usermod -aG docker jenkins || true  # Ignore error if user doesn't exist yet

echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm -f kubectl

# Verify kubectl installation
echo "Verifying kubectl installation..."
kubectl version --client

echo "Installing Jenkins..."
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Wait for yum lock to release before installing Jenkins
while sudo fuser /var/run/yum.pid >/dev/null 2>&1; do
    echo "Waiting for yum lock before installing Jenkins..."
    sleep 10
done

sudo yum install -y jenkins

# Ensure Jenkins has proper permissions
echo "Setting Jenkins permissions..."
sudo chown -R jenkins:jenkins /var/lib/jenkins /var/log/jenkins /var/cache/jenkins
sudo chmod -R 755 /var/lib/jenkins

echo "Starting Jenkins..."
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Jenkins installation completed successfully!"