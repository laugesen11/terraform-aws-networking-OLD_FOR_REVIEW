#Returns the route tables and a map of the input routes
#At this time, cannot return routes from route table

output "route_table" {
  value = aws_route_table.route_tables
}

output "routes" {
  value = module.routes
}
