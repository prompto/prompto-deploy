#!/bin/bash
# download resources
export DEPLOYER_ROOT=https://raw.githubusercontent.com/prompto/prompto-deploy/master
mkdir ~/.m2
curl $DEPLOYER_ROOT/maven/nexus-settings.xml -o ~/.m2/settings.xml
curl $DEPLOYER_ROOT/aws/deploy.py -o /deploy.py
curl $DEPLOYER_ROOT/aws/prepare-ami.py -o /prepare-ami.py
# run deployer
python /prepare-ami.py latest
# notify deployer service
export INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
curl --insecure "https://deploy.prompto.cloud/ec2/prepared?instanceId=$INSTANCE_ID&component=prompto-platform&version=$version$"
