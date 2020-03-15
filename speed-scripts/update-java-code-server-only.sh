#!/usr/bin/env bash

#copy latest CodeServer
cd ~/Development/prompto/prompto-platform/CodeServer
mvn clean install -DskipTests=true
scp -i ~/Development/prompto/prompto-keys/aws/prompto-admin.pem ~/.m2/repository/org/prompto/CodeServer/0.0.1-SNAPSHOT/CodeServer-0.0.1-SNAPSHOT.jar root@eric.prompto.cloud:/v0.0.1/CodeServer-0.0.1-SNAPSHOT.jar

