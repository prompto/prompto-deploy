#!/usr/bin/env bash

#copy latest AwsClient
cd ~/Development/prompto/prompto-platform/AwsClient
mvn clean install -DskipTests=true
scp -i ~/Development/prompto/prompto-keys/aws/prompto-admin.pem ~/.m2/repository/org/prompto/AwsClient/0.0.1-SNAPSHOT/AwsClient-0.0.1-SNAPSHOT.jar root@eric.prompto.cloud:/AwsClient/AwsClient-0.0.1-SNAPSHOT.jar
