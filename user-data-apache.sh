#! /bin/bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "The page was created by the user-data" | sudo tee /var/www/html/index.html
mkfs.xfs /dev/nvme1n1
mkdir /opt/data
echo "/dev/nvme1n1 /opt/data xfs defaults,nofail 0 2" >>/etc/fstab
mount -a
