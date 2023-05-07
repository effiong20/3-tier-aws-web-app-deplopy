module "vpc_module" {
    source = "./module/vpc"

   vpc_name                    = var.vpc_name
   vpc_cidr                    = var.vpc_cidr
   instance_tenancy            = var.instance_tenancy
   map_public_ip_on_launch     = var.map_public_ip_on_launch
   my-publicweb-subnet1-cidr   = var.my-publicweb-subnet1-cidr
   my-publicweb-subnet2-cidr   = var.my-publicweb-subnet2-cidr
   my-privatapp-subnet1-cidr   = var. my-privatapp-subnet1-cidr
   my-privatapp-subnet2-cidr   = var. my-privatapp-subnet2-cidr
   my-privatdb-subnet1-cidr    = var.my-privatdb-subnet1-cidr
   my-privatdb-subnet2-cidr    = var.my-privatdb-subnet2-cidr
   enable_dns_support          = var.enable_dns_support 
   enable_dns_hostname         = var.enable_dns_hostname
}








