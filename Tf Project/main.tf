module "network" {
  source = "./modules/network"
}

module "security" {
  source = "./modules/security"

  vpc_id = module.network.vpc_id
}

module "ec2" {
  source = "./modules/ec2"

  subnet_id         = module.network.public_subnet_id
  security_group_id = module.security.sg_id
}