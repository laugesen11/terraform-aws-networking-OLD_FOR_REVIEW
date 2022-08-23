#Returns the route tables and the routes

output "route_table" {
  value = aws_route_table.route_tables
}

output "routes" {
  value = module.routes
}
