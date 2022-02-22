#!/bin/bash
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
export INSTANCE_ID
PRODUCT_VERSION=$version$
export PRODUCT_VERSION
# connect logs file system
AWS_REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
LOGS_FILESYSTEM_URL=fs-666f46d3.efs.${AWS_REGION}.amazonaws.com
mkdir -p /mnt/efs/logs
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${LOGS_FILESYSTEM_URL}:/ /mnt/efs/logs
mkdir -p /mnt/efs/logs/eric/${INSTANCE_ID}
ln -s /mnt/efs/logs/eric/${INSTANCE_ID} /logs
# download resources
DEPLOYER_ROOT=https://raw.githubusercontent.com/prompto/prompto-deploy/master
export DEPLOYER_ROOT
mkdir ~/.m2
curl $DEPLOYER_ROOT/maven/nexus-settings.xml -o ~/.m2/settings.xml
curl $DEPLOYER_ROOT/aws/deploy.py -o /deploy.py
curl $DEPLOYER_ROOT/aws/prompto-factory/config.yml -o /config.yml
curl $DEPLOYER_ROOT/certificates/prompto-cloud/keystore.jks -o /keystore.jks
curl $DEPLOYER_ROOT/certificates/prompto-cloud/truststore.jks -o /truststore.jks
# run deployer
source /etc/profile.d/maven.sh
python /deploy.py CodeFactory ${PRODUCT_VERSION} latest
# notify deployer service
curl --insecure  "https://deploy.prompto.cloud/ec2/installed?instanceId=${INSTANCE_ID}&component=prompto-factory&addressId=eipalloc-1f9ad42d"
