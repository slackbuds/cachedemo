# Elasticache Demo

* Create a valkey cache and ec2 bastion
* Enable SSH access to bastion
* Enable cache access from bastion

Serverless Cache is accessible only with its VPC.

### IaC

```shell
terraform init
terraform plan -var-file variables.tfvars
terraform apply -var-file variables.tfvars -auto-approve
terraform output
terraform destroy -var-file variables.tfvars -auto-approve
```

### AWS Resources

* serverless cache valkey
* ec2 ubuntu bastion
* bastion user data to install valkey-cli
* security group for bastion
* security group ingress to bastion from external ssh
* security group egress from bastion to external
* security group egress from bastion to cache
* security group for cache
* security group ingress to cache from bastion

### Commands

SSH from host

```shell
ssh -i "${HOME}/.ssh/badadmin-key-pair-1-uw2.pem" -l ubuntu ec2-35-88-249-194.us-west-2.compute.amazonaws.com
```

valkey-cli to elasticache

```shell
valkey-cli --tls -h cache-demo-jnsblr.serverless.usw2.cache.amazonaws.com -p 6379 ping
```
