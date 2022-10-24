provider "aws" {
  region = "us-west-1"

}

module "my_vpc" {
    source                  = "./modules/vpc"
    vpc_cidr                = "10.0.0.0/16"
    public_subnets_cidr     = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnets_cidr    = ["10.0.3.0/24", "10.0.4.0/24"]
    availability_zone       = ["us-west-1c", "us-west-1b"]
    name                    = "boussad_vpc"
}

module "my_s3" {
    source                  = "./modules/S3"
    bucket_name             = "boussad-S3"
}

module "my_ec2_role_allow_s3" {
    source                  = "./modules/ec2_role_S3"
    name                    = "devops"
    bucket_name             = "boussad-S3"
}