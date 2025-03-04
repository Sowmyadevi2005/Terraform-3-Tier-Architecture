
# Define a VPC module, which is sourced from a local directory.
module "vpc" {
# Calling a reusable module
  source                   = "./modules/vpc"
  availability_zones       = var.availability_zones
  vpc_cidr                 = var.vpc_cidr
  public_subnets_cidr      = var.public_subnets_cidr
  private_app_subnets_cidr = var.private_app_subnets_cidr
  private_db_subnets_cidr  = var.private_db_subnets_cidr
}

module "security_groups" {
# Calling a reusable module
  source   = "./modules/security_groups"
  vpc_id   = module.vpc.vpc_id
  vpc_cidr = [module.vpc.vpc_cidr]
}

module "loadbalancer" {
# Calling a reusable module
  source               = "./modules/load-balancer"
  vpc_id               = module.vpc.vpc_id
  public_subnets       = module.vpc.public_subnets
  alb_sg_id            = module.security_groups.alb_sg_id
  alb_name             = var.alb_name
  lb_target_group_name = var.lb_target_group_name
}

module "autoscaling" {
# Calling a reusable module
  source              = "./modules/auto_scaling"
  bastion_sg          = module.security_groups.bastion_sg_id
  instance_sg         = module.security_groups.instance_sg_id
  target_group_arn    = module.loadbalancer.target_group_arn
  bastion_subnet      = module.vpc.public_subnets[1]
  private_app_subnets = module.vpc.private_app_subnets
  key_name            = var.key_name
}
module "db-mysql" {
# Calling a reusable module
  source            = "./modules/rdbs-mysql"
  db_subnets        = module.vpc.private_db_subnets
  rds_sg_id         = module.security_groups.rds_sg_id
  db_subnet_gp_name = var.db_subnet_gp_name
  db_name           = var.db_name
  db_identifier = var.db_identifier
}

output "dns_name" {
# Outputting resource attribute
  value = module.loadbalancer.dns_name

}




