#!/bin/bash
export PRODUCT_VERSION=$version$
# download resources
export DEPLOYER_ROOT=https://raw.githubusercontent.com/prompto/prompto-deploy/master
mkdir ~/.m2
curl $DEPLOYER_ROOT/maven/nexus-settings.xml -o ~/.m2/settings.xml
curl $DEPLOYER_ROOT/aws/deploy.py -o deploy.py
curl $DEPLOYER_ROOT/aws/prompto-factory/config.yml -o config.yml
curl $DEPLOYER_ROOT/certificates/prompto-cloud/keystore.jks -o keystore.jks
curl $DEPLOYER_ROOT/certificates/prompto-cloud/truststore.jks -o truststore.jks
# run deployer
python deploy.py CodeFactory $PRODUCT_VERSION latest
# notify deployer service
export INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
curl --insecure  "https://deploy.prompto.cloud/ec2/installed?instanceId=$INSTANCE_ID&component=prompto-factory&addressId=eipalloc-1f9ad42d"
