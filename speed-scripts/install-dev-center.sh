#!/usr/bin/env bash

#bump dev-center version
cd ~/Development/prompto/prompto-dev-center/DevCenter
mvn clean install -DskipTests
cp -f ~/.m2/repository/org/prompto/DevCenter/0.0.1-SNAPSHOT/DevCenter-0.0.1-SNAPSHOT.jar ~/Desktop/aws/v0.0.1/DevCenter-0.0.1-SNAPSHOT.jar

