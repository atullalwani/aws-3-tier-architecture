# 3-tier-application
This repository contains code for a 3 tier architecture. It uses terraform to create Infra over AWS cloud and deploys a basic nginx server on proxy and a node app on Application servers.

Task1: Setup a three-tier architecture having web server, app server and database. (Include all the components like VPC, Subnets, NAT, NACL, ELB, Auto Scaling and any other tools you feel are important. Use of “User Data” to initialize the instances with a web server will be appreciated).

Solution:

Step1: Create a aws profile with name: varun, region=ap-south-1 (This will be used for all 3 tasks.)
Step2: Clone the code from https://git-codecommit.ap-south-1.amazonaws.com/v1/repos/varun-varun repository.
Step3: Go to project root directory
Step4: Put the name of an S3 bucket in TF_VAR_S3_BUCKET_NAME="" variable in run.sh file. Now put the same name for S3_BUCKET_NAME variable in utility_scripts in installApplication.sh and installProxyServers.sh file.
Step5: Run below command
upd

./run.sh -e <ENVIRONMENT_NAME> --confirmation yes --<TERRAFORM_OPERATION>

If you pass --confirmation yes parameter then terraform will not ask before applying or destroying environment

Possible commands:
./run.sh -e dev --confirmation yes --plan
./run.sh -e dev --confirmation yes --apply
./run.sh -e dev --confirmation yes --destroy

Without confirmation:
./run.sh -e dev --plan
./run.sh -e dev --apply
./run.sh -e dev --destroy


For connecting with instances using ssh. Use ssh_config file.

Database connection can be tested using below commands
1 Create tunnel:
ssh -o StrictHostKeyChecking=no -M -S db-deploy-socket -fnNT -L 3306:DB_HOST:3306 ubuntu@<BASTION_IP> -i /home/varun/varun-bhandari/task-1/configs/dev/dev_deploy_key

2 Connect with DB:
mysql -D varun -h 127.0.0.1  -P 3306 -u codiats  --password=varun123#

3 Exit tunnel
ssh -o StrictHostKeyChecking=no -S db-deploy-socket -O exit ubuntu@<BASTION_IP>
