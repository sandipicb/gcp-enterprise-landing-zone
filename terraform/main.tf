module "network" {
  source       = "./modules/network"
  network_name = var.network_name
  project_id   = var.project_id
  region       = var.region

  subnets = [
    {
      name                     = "management-subnet"
      cidr                     = "10.10.0.0/24"
      region                   = var.region
      private_ip_google_access = true
    },
    {
      name                     = "application-subnet"
      cidr                     = "10.20.0.0/24"
      region                   = var.region
      private_ip_google_access = true
    },
    {
      name                     = "database-subnet"
      cidr                     = "10.30.0.0/24"
      region                   = var.region
      private_ip_google_access = true
    }
  ]
}
module "firewall" {
  source       = "./modules/firewall"
  project_id   = var.project_id
  network_name = module.network.network_name
}

module "cloud_router" {
  source = "./modules/cloud_router"

  project_id   = var.project_id
  region       = var.region
  network_name = module.network.network_name
  router_name  = var.router_name
}

module "cloud_nat" {
  source = "./modules/cloud_nat"

  project_id  = var.project_id
  region      = var.region
  router_name = module.cloud_router.router_name
  nat_name    = var.nat_name
}

module "bastion" {
  source = "./modules/compute"

  project_id   = var.project_id
  zone         = var.zone
  network_name = module.network.network_name
  subnetwork   = "management-subnet"

  instance_name = "bastion-host"
  machine_type  = "e2-micro"

  public_ip = true

  tags = [
    "management"
  ]
}

module "application_vm" {
  source = "./modules/compute"

  project_id   = var.project_id
  zone         = var.zone
  network_name = module.network.network_name
  subnetwork   = "application-subnet"

  instance_name = "app-vm"
  machine_type  = "e2-micro"

  public_ip = false

  tags = [
    "private"
  ]

}

module "database_vm" {
  source = "./modules/compute"

  project_id   = var.project_id
  zone         = var.zone
  network_name = module.network.network_name
  subnetwork   = "database-subnet"

  instance_name = "db-vm"
  machine_type  = "e2-micro"

  public_ip = false

  tags = [
    "private"
  ]

}