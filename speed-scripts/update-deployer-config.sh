#!/usr/bin/env bash

#copy config
scp -i ~/Development/prompto/prompto-keys/aws/prompto-admin.pem ../aws/prompto-deploy/config.yml root@deploy.prompto.cloud:/config.yml
