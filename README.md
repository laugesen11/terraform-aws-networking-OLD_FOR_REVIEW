# Terraform stack to design private network boundaries and gateways in AWS

To update internal_network configuration (VPC, subnets, network gateways), modify network.auto.tfvars.

To update route tables, update route_tables.auto.tfvars

Due to the dynamic nature of the 'route_tables' module, you must build these modules separately, a simple 'terraform apply' command will fail if you try to create route tables

It is recommended to use the below base commands:

terraform apply -target=module.network_boundaries
terraform apply -target=module.route_tables
