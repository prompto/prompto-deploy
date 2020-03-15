#!/usr/bin/env bash

scp -i ~/Development/prompto/prompto-keys/aws/prompto-admin.pem root@eric.prompto.cloud:/var/log/cloud-init-output.log ../logs/cloud-init-output.log
