# Terraform Private network layout module

- variable.tf                     - Declares variables that define entires network setup
- ouput.tf                        - file for output configuration
- provider.tf                     - file for provider configuration
- terraform.auto.tfvars           - file where we define default values for variables in variables.tf 
- main.tf                         - Attaches subnets to route tables and verifies input
- egress_only_internet_gateway.tf - Creates egress only internet gateways for IPv6 addresses
- internet_gateway.tf             - Creates internet gateways
- nat_gateway.tf                  - Creates NAT gateways and EIPs 
- route_tables.tf                 - Creates route tables
- subnet.tf                       - Creates subnets 
- vpc.tf                          - Creates VPCs
- vpn_gateway.tf                  - Creates VPN Gateways 
