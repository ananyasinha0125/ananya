#!/bin/bash

# ========== CONFIGURATION ==========
STACK_NAME="asg-launch-config"
TEMPLATE_FILE="launch-config.yaml"
PARAMS_FILE="launch-config.json"
REGION="us-east-1"  # Change if needed
# ===================================

echo "🔍 Validating CloudFormation template..."
aws cloudformation validate-template \
  --template-body file://$TEMPLATE_FILE \
  --region $REGION

if [ $? -ne 0 ]; then
  echo "Template validation failed. Exiting."
  exit 1
fi

echo "🚀 Creating CloudFormation stack: $STACK_NAME..."
aws cloudformation create-stack \
  --stack-name $STACK_NAME \
  --template-body file://$TEMPLATE_FILE \
  --parameters file://$PARAMS_FILE \
  --capabilities CAPABILITY_NAMED_IAM \
  --region $REGION

if [ $? -ne 0 ]; then
  echo "Stack creation command failed. Exiting."
  exit 1
fi

echo "⏳ Waiting for stack creation to complete..."
aws cloudformation wait stack-create-complete \
  --stack-name $STACK_NAME \
  --region $REGION

if [ $? -eq 0 ]; then
  echo "Stack $STACK_NAME created successfully!"
else
  echo "Stack creation failed. Check CloudFormation events."
  exit 1
fi
