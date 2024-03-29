#!/bin/bash
source /etc/profile.d/maven.sh
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
export INSTANCE_ID
PRODUCT_VERSION=$version$
export PRODUCT_VERSION
# connect logs file system
AWS_REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
LOGS_FILESYSTEM_URL=fs-6ce4cdd9.efs.${AWS_REGION}.amazonaws.com
mkdir -p /mnt/efs/logs
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${LOGS_FILESYSTEM_URL}:/ /mnt/efs/logs
mkdir -p /mnt/efs/logs/www/${INSTANCE_ID}
ln -s /mnt/efs/logs/www/${INSTANCE_ID} /logs
# download resources
DEPLOYER_ROOT=https://raw.githubusercontent.com/prompto/prompto-deploy/master
export DEPLOYER_ROOT
mkdir ~/.m2
curl $DEPLOYER_ROOT/maven/nexus-settings.xml -o ~/.m2/settings.xml
curl $DEPLOYER_ROOT/aws/deploy.py -o deploy.py
curl $DEPLOYER_ROOT/aws/prompto-docs/config.yml -o config.yml
curl $DEPLOYER_ROOT/certificates/prompto-org/keystore.jks -o keystore.jks
curl $DEPLOYER_ROOT/certificates/prompto-org/truststore.jks -o truststore.jks
# run deployer
python deploy.py WebSite $PRODUCT_VERSION latest
# notify deployer service
curl --insecure  "https://deploy.prompto.cloud/ec2/installed?instanceId=${INSTANCE_ID}&component=prompto-docs&addressId=eipalloc-05afcae7941044687"
