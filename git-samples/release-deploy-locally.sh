#!/usr/bin/env bash
curl --header "Content-Type: application/json" --data @release-deploy.json -X POST http://localhost:8080/git/release