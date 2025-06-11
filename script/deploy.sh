#!/bin/bash

# CONFIGURATION
SERVER_URL="http://localhost:8153/go"
PIPELINE_NAME="launch-asg-pipeline"

# TRIGGER THE PIPELINE
curl -X POST \
     "$SERVER_URL/api/pipelines/$PIPELINE_NAME/schedule" \
     -H "Accept: application/vnd.go.cd.v1+json" \
     -H "Content-Type: application/json"

echo "Triggered pipeline '$PIPELINE_NAME'"
