#!/usr/bin/env bash

#copy Devcenter to v0.0.1
rm -f ~/Desktop/aws/v0.0.1/*
rmdir ~/Desktop/aws/v0.0.1/
mkdir ~/Desktop/aws/v0.0.1/
mvn dependency:copy-dependencies -f ~/.m2/repository/org/prompto/DevCenter/0.0.1-SNAPSHOT/DevCenter-0.0.1-SNAPSHOT.pom -DoutputDirectory=$HOME/Desktop/aws/v0.0.1/
cp -f ~/.m2/repository/org/prompto/DevCenter/0.0.1-SNAPSHOT/DevCenter-0.0.1-SNAPSHOT.jar ~/Desktop/aws/v0.0.1/
