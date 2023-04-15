variable "Vpccidr" {
  type    = string
  default = "10.1.0.0/16"
}
variable "publicsubnet1cider" {
  type = string
  default = "10.1.1.0/24"
}
variable "publicsubnet2cider" {
  type = string
  default = "10.1.2.0/24"
}
variable "privsubnet1cider" {
  type = string
  default = "10.1.3.0/24"
}
variable "privsubnet2cider" {
  type = string
  default = "10.1.4.0/24"
}
variable "AvaZone_1" {
  type = string
}
variable "AvaZone_2" {
  type = string
}