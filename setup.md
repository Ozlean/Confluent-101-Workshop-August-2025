# Confluent 101 Workshop August 2025
Confluent 101 workshop - Using connectors to move data between 2 postgreSQL databases

## Keys and variables

Terraform needs an API keypair to create resources in your AWS environment.
Create an AWS IAM user with the AdministerativeAccess policy and create a 3rd party service access key for this use.
Create a file 'keys.tfvars' and in it put the following, replacing key and secret with your IAM keypair:

AWS_workshop_terraform_user_key = <KEY>
AWS_workshop_terraform_user_secret = <SECRET>

You can also change the AMI used by adding the following to the .tfvars file

WEBAPP_AMI = <AMI> 

"ami-071299e36e4bb550c" - The default AMI


## Creating the workshop

In /terraform/aws run the following commands to create the AWS infrastructure:
terraform init 

terraform apply -var-file=<Path-to-keys.tfvars>

When you run this the console should output the webapp url, and RDS information used to interact with the workshop
RDS1 is the source database that should send data to your kafka cluster and RDS2 is the sink database that should have data consumed from kafka


In /terraform/postgresql run the following commands once the AWS infrastructure has been fully created to initialise databases required for the workshop:

terraform init

terraform apply



## Tearing down the workshop

In /terraform/postgresql run the following to 

terraform destroy


In /terraform/aws run the following:

terraform destroy -var-file=<Path to keys.tfvars>