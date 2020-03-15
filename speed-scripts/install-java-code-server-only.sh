#!/usr/bin/env bash

#bump CodeServer version
cd ~/Development/prompto/prompto-platform/CodeServer
mvn clean install -DskipTests
cp -f ~/.m2/repository/org/prompto/CodeServer/0.0.1-SNAPSHOT/CodeServer-0.0.1-SNAPSHOT.jar ~/Desktop/aws/v0.0.1/CodeServer-0.0.1-SNAPSHOT.jar

