#!/usr/bin/env bash

#copy Devcenter to v0.0.1
rm -f ~/Desktop/aws/AwsClient/*
rmdir ~/Desktop/aws/AwsClient/
mkdir ~/Desktop/aws/AwsClient/
mvn dependency:copy-dependencies -f ~/.m2/repository/org/prompto/AwsClient/0.0.1-SNAPSHOT/AwsClient-0.0.1-SNAPSHOT.pom -DoutputDirectory=$HOME/Desktop/aws/AwsClient/
cp -f ~/.m2/repository/org/prompto/AwsClient/0.0.1-SNAPSHOT/AwsClient-0.0.1-SNAPSHOT.jar ~/Desktop/aws/AwsClient/
