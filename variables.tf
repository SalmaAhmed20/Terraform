variable "REGION" {
  type        = string
  description = "The Region were your resources deployed"
}
variable "AZ_1" {
  type = string
}
variable "AZ_2" {
  type = string
}
variable "VPC_CIDR" {
  type    = string
  default = "10.1.0.0/16"
}
variable "publicsubnet1_cider" {
  type = string
  default = "10.1.1.0/24"
}
variable "publicsubnet2_cider" {
  type = string
  default = "10.1.2.0/24"
}
variable "privatesubnet1_cider" {
  type = string
  default = "10.1.3.0/24"
}
variable "privatesubnet2_cider" {
  type = string
  default = "10.1.4.0/24"
}
variable "INSTANCE_TYPE" {
  type= string
  default = "t2.micro"
}
variable "AMI" {
  type = string
}
variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}