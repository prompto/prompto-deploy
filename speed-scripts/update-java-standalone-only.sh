#!/usr/bin/env bash

#copy latest Standalone
cd ~/Development/prompto/prompto-platform/prompto-java/Standalone
mvn clean install -DskipTests=true
scp -i ~/Development/prompto/prompto-keys/aws/prompto-admin.pem ~/.m2/repository/org/prompto/Standalone/0.0.1-SNAPSHOT/Standalone-0.0.1-SNAPSHOT.jar root@eric.prompto.cloud:/v0.0.1/Standalone-0.0.1-SNAPSHOT.jar

