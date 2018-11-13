#!/bin/bash

S3_BUCKET_NAME="varunthreetierbucket"
apt-get update
apt-get -y install nodejs
apt-get -y install tar
apt-get -y install awscli
mkdir /opt/node
cd /opt/node
aws s3 cp s3://${S3_BUCKET_NAME}/application/nodeapp.tar.gz . --region ap-south-1
tar -xzvf nodeapp.tar.gz -C /opt/node/
node /opt/node/nodeapp/server.js &
