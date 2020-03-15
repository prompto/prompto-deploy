#!/usr/bin/env bash

#copy aws from local
# scp -i ~/Development/prompto/prompto-keys/aws/prompto-admin.pem -r ~/Desktop/aws/AwsClient/ root@eric.prompto.cloud:/
scp -i ~/Development/prompto/prompto-keys/aws/prompto-admin.pem -r root@deploy.prompto.cloud:/AwsClient ~/Desktop/AwsClient/
