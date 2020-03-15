#!/bin/bash
export PRODUCT_VERSION=$version$
# download resources
export DEPLOYER_ROOT=https://raw.githubusercontent.com/prompto/prompto-deploy/master
mkdir ~/.m2
curl $DEPLOYER_ROOT/maven/nexus-settings.xml -o ~/.m2/settings.xml
curl $DEPLOYER_ROOT/aws/deploy.py -o deploy.py
curl $DEPLOYER_ROOT/aws/prompto-docs/config.yml -o config.yml
# run deployer
python deploy.py WebSite $PRODUCT_VERSION latest
# notify deployer service
export INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
curl --insecure  "https://deploy.prompto.cloud/ec2/installed?instanceId=$INSTANCE_ID&component=prompto-docs&addressId=eipalloc-63e29051"
