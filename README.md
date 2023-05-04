# Aws Infrastructure using Terraform

A Terraform is a infrasturcture as a Code and Provisiong tool.
I used it to provision aws infrasturcture to then deploy an app
  

## Architecture Diagram
![Aws terrafrorm](https://user-images.githubusercontent.com/64385957/236339127-10e05278-4402-42d2-926b-6826584e4c9c.jpg)

## Variables files 
you have 2 .tfvars files
you can create 2 workspaces and use each of them to provision
## Provider
 - hashicorp/aws
## Remote State File
The terraform State file .tfstate is saved in an S3 bucket to be centralized for the team and easy to collaborate 
## State locking using dynamo db
If someone running 
```bash
    terraform apply --var-file dev.tfvar
    or 
    terraform apply --var-file prod.tfvar

```
no one can run it until you finish provisioning to preserve consistency 
## Resources 
### network module 
- Create VPC with 4 Subnets
    - 2 Public Subnets in 2 AZs
    - 2 Private Subnets in 2 Azs
- Internet Gateway on the VPC to make Public Resources able to connect to the internet send and receive requests 
- Nat Gateway and Elastic IP associated with it to be able to connect to the internet without receiving external requests (requests not within CIDR of VPC)
- 4 Security groups
    - the first one allows ssh from anywhere
    - second one allow ssh from only Resources in VPC and allow port 3000 for the application
    - a Security group allows port 3306 for RDS
    - a Security group allows port 6379 for Elastic Cache
### main 
- RDS instance (Mysql) in Private Subnets (for high availability)
- Elastic Cache (Redis) in Private Subnets
-  4 EC2 instances 
    - 2 bastion hosts in Public Subnets that allow us to ssh to the application host
    - 2 applications in Private Subnets 

