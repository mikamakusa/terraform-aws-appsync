output "api_cache_id" {
  value = try(aws_appsync_api_cache.this.*.id)
}

output "api_cache_type" {
  value = try(aws_appsync_api_cache.this.*.type)
}

output "api_cache_api_id" {
  value = try(aws_appsync_api_cache.this.*.api_id)
}

output "api_key_id" {
  value = try(aws_appsync_api_key.this.*.id)
}

output "api_key_key" {
  value = try(aws_appsync_api_key.this.*.key)
}

output "api_key_api_id" {
  value = try(aws_appsync_api_key.this.*.api_id)
}

output "datasource_id" {
  value = try(aws_appsync_datasource.this.*.id)
}

output "datasource_name" {
  value = try(aws_appsync_datasource.this.*.name)
}

output "datasource_arn" {
  value = try(aws_appsync_datasource.this.*.arn)
}

output "domain_name_id" {
  value = try(aws_appsync_domain_name.this.*.id)
}

output "domain_name" {
  value = try(aws_appsync_domain_name.this.*.domain_name)
}

output "domain_name_api_association_id" {
  value = try(aws_appsync_domain_name_api_association.this.*.id)
}

output "domain_name_api_association_api_id" {
  value = try(aws_appsync_domain_name_api_association.this.*.api_id)
}

output "function_id" {
  value = try(aws_appsync_function.this.*.id)
}

output "function_api_id" {
  value = try(aws_appsync_function.this.*.api_id)
}

output "function_arn" {
  value = try(aws_appsync_function.this.*.arn)
}

output "function_name" {
  value = try(aws_appsync_function.this.*.name)
}

output "graphql_api_id" {
  value = try(aws_appsync_graphql_api.this.*.id)
}

output "graphql_api_name" {
  value = try(aws_appsync_graphql_api.this.*.name)
}

output "graphql_api_arn" {
  value = try(aws_appsync_graphql_api.this.*.arn)
}

output "resolver_id" {
  value = try(aws_appsync_resolver.this.*.id)
}

output "resolver_arn" {
  value = try(aws_appsync_resolver.this.*.arn)
}

output "resolver_api_id" {
  value = try(aws_appsync_resolver.this.*.api_id)
}

output "type_id" {
  value = try(aws_appsync_type.this.*.id)
}

output "type_api_id" {
  value = try(aws_appsync_type.this.*.api_id)
}

output "type_arn" {
  value = try(aws_appsync_type.this.*.arn)
}

output "type_name" {
  value = try(aws_appsync_type.this.*.name)
}