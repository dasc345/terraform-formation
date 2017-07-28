## Projet 5

Se projet une implémentation de module gérant multiples aspects de l'autoscaling chez AWS.


```bash

export AWS_DEFAULT_REGION=eu-central-1
export TF_VAR_env=staging

aws s3api create-bucket --bucket "remote-tf-lls-$AWS_DEFAULT_REGION-$TF_VAR_env" --region ${AWS_DEFAULT_REGION} --create-bucket-configuration LocationConstraint=${AWS_DEFAULT_REGION}

# Always enable versioning of bucket that contain tfstate !
aws s3api put-bucket-versioning --bucket "remote-tf-lls-$AWS_DEFAULT_REGION-$TF_VAR_env" --versioning-configuration Status=Enabled

terraform init -backend-config="bucket=remote-tf-lls-$AWS_DEFAULT_REGION-$TF_VAR_env" -backend-config="key=terraform.tfstate" -backend-config="region=$AWS_DEFAULT_REGION" -backend=true -input=false

terraform plan -var "region=$AWS_DEFAULT_REGION" -out=$AWS_DEFAULT_REGION-$ACCOUNT_ID.plan
```

### Support or Contact

Julien BOULANGER jbo@oxalide.com
