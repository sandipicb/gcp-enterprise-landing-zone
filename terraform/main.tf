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

  service_account_email = module.iam.service_accounts["bastion-sa"]

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

  service_account_email = module.iam.service_accounts["app-sa"]

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

  service_account_email = module.iam.service_accounts["database-sa"]

  instance_name = "db-vm"
  machine_type  = "e2-micro"

  public_ip = false

  tags = [
    "private"
  ]

}

module "iam" {
  source = "./modules/iam"

  project_id = var.project_id

  service_accounts = [
    {
      account_id   = "bastion-sa"
      display_name = "Bastion Host Service Account"
    },
    {
      account_id   = "app-sa"
      display_name = "Application Service Account"
    },
    {
      account_id   = "database-sa"
      display_name = "Database Service Account"
    },
    {
      account_id   = "monitoring-sa"
      display_name = "Monitoring Service Account"
    }
  ]

  iam_bindings = {
    "roles/logging.logWriter" = [
      "serviceAccount:bastion-sa@${var.project_id}.iam.gserviceaccount.com",
      "serviceAccount:app-sa@${var.project_id}.iam.gserviceaccount.com",
      "serviceAccount:database-sa@${var.project_id}.iam.gserviceaccount.com",
      "serviceAccount:monitoring-sa@${var.project_id}.iam.gserviceaccount.com"
    ]
    "roles/monitoring.metricWriter" = [
      "serviceAccount:bastion-sa@${var.project_id}.iam.gserviceaccount.com",
      "serviceAccount:app-sa@${var.project_id}.iam.gserviceaccount.com",
      "serviceAccount:database-sa@${var.project_id}.iam.gserviceaccount.com",
      "serviceAccount:monitoring-sa@${var.project_id}.iam.gserviceaccount.com"

    ]
  }
}

module "secret_manager" {
  source = "./modules/secret_manager"

  project_id = var.project_id

  secrets = [
    {
      secret_id = "db-password"
      value     = "REMOVED_SECRET"
    },
    {
      secret_id = "app-api-key"
      value     = "REMOVED_SECRET"
    }
  ]
  secret_accessors = {
    "db-password" = [
      "serviceAccount:app-sa@${var.project_id}.iam.gserviceaccount.com"
    ]

    "app-api-key" = [
      "serviceAccount:app-sa@${var.project_id}.iam.gserviceaccount.com"
    ]
  }
}

module "monitoring" {
  source = "./modules/monitoring"

  project_id         = var.project_id
  notification_email = "sandipcloudeng@gmail.com"
}

module "storage" {
  source = "./modules/storage"

  project_id = var.project_id
  buckets    = var.storage_buckets
  bucket_iam = var.bucket_iam
}

module "global_ip" {
  source = "./modules/global_ip"

  project_id = var.project_id
  addresses  = var.global_addresses
}