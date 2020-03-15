#!/usr/bin/env bash

#copy deploy script
scp -i ~/Development/prompto/prompto-keys/aws/prompto-admin.pem ../aws/deploy-stuff.py root@deploy.prompto.cloud:/deploy.py
