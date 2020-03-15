#!/usr/bin/env bash

#bump server version
cd ~/Development/prompto/prompto-platform/Server
mvn clean install -DskipTests
cp -f ~/.m2/repository/org/prompto/Server/0.0.1-SNAPSHOT/Server-0.0.1-SNAPSHOT.jar ~/Desktop/aws/v0.0.1/Server-0.0.1-SNAPSHOT.jar
