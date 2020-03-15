#!/usr/bin/env bash

#run v0.0.1
cd ~/Desktop/aws/v0.0.1/
java -Xdebug -agentlib:jdwp=transport=dt_socket,address=8000,server=y,suspend=y -jar DevCenter-0.0.1-SNAPSHOT.jar -yamlConfigFile /var/folders/7z/rdw_873x3_s5zr8pb81k9z7c0000gn/T/config-795585507753575808.yml
