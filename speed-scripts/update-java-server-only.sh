#!/usr/bin/env bash

#copy latest Server
cd ~/Development/prompto/prompto-platform/Server
mvn clean install -DskipTests=true
scp -i ~/Development/prompto/prompto-keys/aws/prompto-admin.pem ~/.m2/repository/org/prompto/Server/0.0.1-SNAPSHOT/Server-0.0.1-SNAPSHOT.jar root@eric.prompto.cloud:/v0.0.1/Server-0.0.1-SNAPSHOT.jar
