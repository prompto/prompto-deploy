#!/usr/bin/env bash

./webpack-prompto-core.sh
./update-aws-client.sh
./update-java-core-only.sh
./update-java-standalone-only.sh
./update-mongo-store.sh
./update-java-server-only.sh
./update-java-code-server-only.sh
update-codefactory-only.sh
./update-aws-client-dependencies.sh
update-codefactory-dependencies.sh
update-deployer-config.sh
