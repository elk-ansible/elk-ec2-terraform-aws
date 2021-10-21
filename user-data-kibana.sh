#! /bin/bash
amazon-linux-extras install -y  java-openjdk11
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "This is the Kibana Node" | sudo tee /var/www/html/index.html

sudo amazon-linux-extras install -y  java-openjdk11
