module "networks" {
  source             = "./network"
  Vpccidr            = var.VPC_CIDR
  publicsubnet1cider = var.publicsubnet1_cider
  publicsubnet2cider = var.publicsubnet2_cider
  privsubnet1cider   = var.privatesubnet1_cider
  privsubnet2cider   = var.privatesubnet2_cider
  AvaZone_1          = var.AZ_1
  AvaZone_2          = var.AZ_2
}
