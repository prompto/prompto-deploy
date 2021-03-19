#!/usr/bin/env bash

#update latest Core
cd ~/Development/prompto/prompto-platform/prompto-java/Core || exit
mvn clean install -DskipTests=true
scp -i ~/Documents/Technical/Certificates/prompto-keys/aws/us-east-1/prompto-admin.pem ~/.m2/repository/org/prompto/Core/0.0.1-SNAPSHOT/Core-0.0.1-SNAPSHOT.jar root@eric.prompto.cloud:/Core-0.0.1-SNAPSHOT.jar

