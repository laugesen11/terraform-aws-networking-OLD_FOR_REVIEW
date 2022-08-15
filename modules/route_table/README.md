# Terraform module to create route tables

- variable.tf                - Sets values forroute table and associated routes. Please read carefully for each tpe of route you want to set up
- ouput.tf                   - Returns route table resource and route inputs to parent module
- main.tf                    - Creates route table and assigns dynamically generated routes
