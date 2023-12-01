#!/bin/bash
dnf update -y
dnf install docker -y
systemctl start docker
systemctl enable docker
usermod -a -G docker ec2-user
newgrp docker
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
dnf install git -y
TOKEN=#"GITHUB_TOKEN!!!"
USER=#GITHUB_USER_NAME!!!
cd /home/ec2-user/ && git clone https://$TOKEN@github.com/$USER/books-db.git
cd /home/ec2-user/books-db
docker-compose up -d