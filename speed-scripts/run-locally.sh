#!/usr/bin/env bash

./webpack-prompto-core.sh
install-java-core.sh
install-java-platform.sh
./bump-java-server-only.sh.sh
install-java-code-server-only.sh
install-dev-center.sh
./copy-aws-client-dependencies.sh
./copy-dev-center-dependencies.sh
./run-dev-center.sh
./debug-dev-center.sh