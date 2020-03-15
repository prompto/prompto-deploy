#!/usr/bin/env bash

#copy latest DevCenter
cd ~/Development/prompto/prompto-platform/CodeFactory/
mvn clean install -DskipTests=true
scp -i ~/Development/prompto/prompto-keys/aws/prompto-admin.pem ~/.m2/repository/org/prompto/CodeFactory/0.0.12/CodeFactory-0.0.12.jar root@eric.prompto.cloud:/v0.0.12/CodeFactory-0.0.12.jar

