#!/bin/bash

S3_BUCKET_NAME="varunthreetierbucket"
apt-get update
apt-get -y install nginx
apt-get -y install awscli
cd /etc/nginx/
aws s3 cp s3://${S3_BUCKET_NAME}/proxy_conf/proxy_nginx.conf ./nginx.conf --region ap-south-1
cd /etc/nginx/conf.d
aws s3 cp s3://${S3_BUCKET_NAME}/proxy_conf/app_proxy.conf ./proxy.conf --region ap-south-1
systemctl restart nginx.service
sleep 300
systemctl restart nginx.service
