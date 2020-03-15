#!/usr/bin/env bash

#copy latest Mongo
cd ~/Development/prompto/prompto-platform/MongoStore
mvn clean install -DskipTests=true
scp -i ~/Development/prompto/prompto-keys/aws/prompto-admin.pem ~/.m2/repository/org/prompto/MongoStore/0.0.1-SNAPSHOT/MongoStore-0.0.1-SNAPSHOT.jar root@eric.prompto.cloud:/v0.0.1/MongoStore-0.0.1-SNAPSHOT.jar

