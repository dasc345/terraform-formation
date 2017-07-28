#!/bin/bash

# Usage: ./init.sh once to initialize remote storage for this environment.
# Subsequent tf actions in this environment don't require re-initialization,
# unless you have completely cleared your .terraform cache.
#
# terraform plan  -var-file=./base.tfvars
# terraform apply -var-file=./base.tfvars

#tf_env="base"
tf_env=$(pwd|awk -F\/ '{print $NF}')
echo AWS_DEFAULT_REGION: $AWS_DEFAULT_REGION
terraform init -backend=true -backend-config="bucket=myenterprise-state" \
                        -backend-config="key=${tf_env}.tfstate" \
                        -backend-config="region=${AWS_DEFAULT_REGION}"

#touch ${tf_env}.tfvars
touch terraform.tfvars

echo "set remote s3 state to ${tf_env}.tfstate"
