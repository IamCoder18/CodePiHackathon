#!/bin/bash

# Check if docker is not installed
if ! which docker >/dev/null 2>&1; then
  echo "Installing docker..."
  # Update package lists and install dependencies
  sudo apt-get update -y &> /dev/null
  sudo apt-get install ca-certificates curl -y &> /dev/null

  # Install GPG key for Docker repository
  sudo install -m 0755 -d /etc/apt/keyrings &> /dev/null
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc &> /dev/null
  sudo chmod a+r /etc/apt/keyrings/docker.asc &> /dev/null

  # Add Docker repository to sources.list
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Update package lists again and install Docker
  sudo apt-get update -y &> /dev/null
  sudo apt-get install docker.io -y &> /dev/null
fi

# Download docker-compose.yaml file
echo "Downloading docker-compose.yaml..."
sudo curl -O https://raw.githubusercontent.com/IamCoder18/CodePiHackathon/refs/heads/master/docker-compose.yaml &> /dev/null

# Run docker compose up -d
echo "Starting docker containers..."
sudo docker compose up -d &> /dev/null

echo "Done! Web server started on 0.0.0.0:3000"