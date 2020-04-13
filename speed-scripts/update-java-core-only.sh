#!/usr/bin/env bash

#update latest Core
cd ~/Development/prompto/prompto-platform/prompto-java/Core
mvn clean install -DskipTests=true
scp -i ~/Development/prompto/prompto-keys/aws/prompto-admin.pem ~/.m2/repository/org/prompto/Core/0.0.1-SNAPSHOT/Core-0.0.1-SNAPSHOT.jar root@eric.prompto.cloud:/Core-0.0.1-SNAPSHOT.jar

