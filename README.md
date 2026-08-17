# GCP Enterprise Landing Zone

## Project Overview

This project implements an enterprise-style Google Cloud Landing Zone using Terraform.

The environment provides a structured foundation for secure and scalable workloads on Google Cloud, including:

- Custom VPC networking
- Dedicated management, application, and database subnets
- Cloud Router and Cloud NAT
- Bastion host and private workloads
- IAM service accounts and project-level IAM bindings
- Firewall security controls
- Secret Manager
- Cloud Storage
- Cloud DNS
- Global static IP
- External HTTPS Load Balancer
- Cloud Monitoring and logging
- VM error and CPU monitoring alerts
- Terraform remote state using Cloud Storage
- GitHub Actions CI/CD

## Architecture

```text
                         Internet
                            |
                            v
                    Cloud DNS / Domain
                            |
                            v
                    Global Static IP
                            |
                            v
                 HTTPS Load Balancer
                            |
                            v
                    Backend Service
                            |
                       Health Check
                            |
                            v
                       Private app-vm
                            |
              +-------------+-------------+
              |                           |
              v                           v
      Application Subnet          Database Subnet
        10.20.0.0/24                10.30.0.0/24
              |                           |
            app-sa                    database-sa


       Management Subnet
          10.10.0.0/24
                |
                v
          Bastion Host
                |
             IAP / SSH


  +---------------------------------------------+
  |              Security & Operations          |
  |                                             |
  | IAM | Firewall | Secret Manager             |
  | OS Login | Shielded VM                      |
  | Cloud Monitoring | Cloud Logging            |
  | CPU Alert | VM Error Alert                  |
  +---------------------------------------------+

                    Terraform
                        |
                 GCS Remote State
                        |
                 GitHub Actions
                  /           \
               Plan           Apply
