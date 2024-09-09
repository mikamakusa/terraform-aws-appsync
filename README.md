## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm"></a> [acm](#module\_acm) | ./modules/terraform-aws-acm | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_appsync_api_cache.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_api_cache) | resource |
| [aws_appsync_api_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_api_key) | resource |
| [aws_appsync_datasource.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_datasource) | resource |
| [aws_appsync_domain_name.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_domain_name) | resource |
| [aws_appsync_domain_name_api_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_domain_name_api_association) | resource |
| [aws_appsync_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_function) | resource |
| [aws_appsync_graphql_api.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_graphql_api) | resource |
| [aws_appsync_resolver.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_resolver) | resource |
| [aws_appsync_type.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_type) | resource |
| [aws_default_tags.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate"></a> [acm\_certificate](#input\_acm\_certificate) | n/a | `any` | `[]` | no |
| <a name="input_api_cache"></a> [api\_cache](#input\_api\_cache) | n/a | <pre>list(object({<br>    id                         = number<br>    api_caching_behavior       = string<br>    api_id                     = any<br>    ttl                        = number<br>    type                       = string<br>    at_rest_encryption_enabled = optional(bool)<br>    transit_encryption_enabled = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | n/a | <pre>list(object({<br>    id          = number<br>    api_id      = any<br>    description = optional(string)<br>    expires     = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_datasource"></a> [datasource](#input\_datasource) | n/a | <pre>list(object({<br>    id          = number<br>    api_id      = any<br>    name        = string<br>    type        = string<br>    description = optional(string)<br>    dynamodb_config = optional(list(object({<br>      table_name             = string<br>      region                 = optional(string)<br>      use_caller_credentials = optional(bool)<br>      versioned              = optional(bool)<br>      delta_sync_config = optional(list(object({<br>        delta_sync_table_name = string<br>        delta_sync_table_ttl  = optional(number)<br>        base_table_ttl        = optional(number)<br>      })))<br>    })))<br>    elasticsearch_config = optional(list(object({<br>      endpoint = string<br>      region   = optional(string)<br>    })))<br>    event_bridge_config = optional(list(object({<br>      event_bus_arn = any<br>    })))<br>    http_config = optional(list(object({<br>      endpoint = string<br>      authorization_config = optional(list(object({<br>        authorization_type = optional(string)<br>        aws_iam_config = optional(list(object({<br>          signing_region       = optional(string)<br>          signing_service_name = optional(string)<br>        })))<br>      })))<br>    })))<br>    lambda_config = optional(list(object({<br>      function_arn = any<br>    })))<br>    opensearchservice_config = optional(list(object({<br>      endpoint = string<br>      region   = optional(string)<br>    })))<br>    relational_database_config = optional(list(object({<br>      source_type = optional(string)<br>      http_endpoint_config = list(object({<br>        aws_secret_store_arn  = any<br>        db_cluster_identifier = any<br>        database_name         = optional(string)<br>        region                = optional(string)<br>        schema                = optional(string)<br>      }))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_datasource_service_role_arn"></a> [datasource\_service\_role\_arn](#input\_datasource\_service\_role\_arn) | n/a | `string` | `null` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | <pre>list(object({<br>    id             = number<br>    certificate_id = any<br>    domain_name    = string<br>    description    = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_domain_name_api_association"></a> [domain\_name\_api\_association](#input\_domain\_name\_api\_association) | n/a | <pre>list(object({<br>    id             = number<br>    api_id         = any<br>    domain_name_id = any<br>  }))</pre> | `[]` | no |
| <a name="input_function"></a> [function](#input\_function) | n/a | <pre>list(object({<br>    id                        = number<br>    api_id                    = any<br>    data_source_id            = any<br>    name                      = string<br>    code                      = optional(string)<br>    max_batch_size            = optional(number)<br>    request_mapping_template  = optional(string)<br>    response_mapping_template = optional(string)<br>    description               = optional(string)<br>    function_version          = optional(string)<br>    runtime = optional(list(object({<br>      name            = string<br>      runtime_version = string<br>    })))<br>    sync_config = optional(list(object({<br>      conflict_detection = optional(string)<br>      conflict_handler   = optional(string)<br>      lambda_conflict_handler_config = optional(list(object({<br>        lambda_conflict_handler_arn = optional(any)<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_graphql_api"></a> [graphql\_api](#input\_graphql\_api) | n/a | <pre>list(object({<br>    id                   = number<br>    authentication_type  = string<br>    name                 = string<br>    query_depth_limit    = optional(number)<br>    resolver_count_limit = optional(number)<br>    schema               = optional(string)<br>    visibility           = optional(string)<br>    xray_enabled         = optional(bool)<br>    additional_authentication_provider = optional(list(object({<br>      authentication_type = string<br>    })))<br>    lambda_authorizer_config = optional(list(object({<br>      authorizer_uri                   = string<br>      authorizer_result_ttl_in_seconds = optional(number)<br>      identity_validation_expression   = optional(string)<br>    })))<br>    log_config = optional(list(object({<br>      cloudwatch_logs_role_arn = any<br>      field_log_level          = string<br>      exclude_verbose_content  = optional(bool)<br>    })))<br>    openid_connect_config = optional(list(object({<br>      issuer    = string<br>      auth_ttl  = optional(number)<br>      iat_ttl   = optional(number)<br>      client_id = optional(string)<br>    })))<br>    user_pool_config = optional(list(object({<br>      default_action      = string<br>      user_pool_id        = any<br>      app_id_client_regex = optional(string)<br>      aws_region          = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_resolver"></a> [resolver](#input\_resolver) | n/a | <pre>list(object({<br>    id                = number<br>    api_id            = any<br>    field             = string<br>    type              = string<br>    code              = optional(string)<br>    request_template  = optional(string)<br>    response_template = optional(string)<br>    data_source       = optional(string)<br>    max_batch_size    = optional(number)<br>    kind              = optional(string)<br>    caching_config = optional(list(object({<br>      caching_keys = optional(set(string))<br>      ttl          = optional(number)<br>    })))<br>    pipeline_config = optional(list(object({<br>      functions_id = any<br>    })))<br>    runtime = optional(list(object({<br>      name            = string<br>      runtime_version = string<br>    })))<br>    sync_config = optional(list(object({<br>      conflict_detection = optional(string)<br>      conflict_handler   = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | n/a | <pre>list(object({<br>    id         = number<br>    api_id     = any<br>    definition = string<br>    format     = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_cache_api_id"></a> [api\_cache\_api\_id](#output\_api\_cache\_api\_id) | n/a |
| <a name="output_api_cache_id"></a> [api\_cache\_id](#output\_api\_cache\_id) | n/a |
| <a name="output_api_cache_type"></a> [api\_cache\_type](#output\_api\_cache\_type) | n/a |
| <a name="output_api_key_api_id"></a> [api\_key\_api\_id](#output\_api\_key\_api\_id) | n/a |
| <a name="output_api_key_id"></a> [api\_key\_id](#output\_api\_key\_id) | n/a |
| <a name="output_api_key_key"></a> [api\_key\_key](#output\_api\_key\_key) | n/a |
| <a name="output_datasource_arn"></a> [datasource\_arn](#output\_datasource\_arn) | n/a |
| <a name="output_datasource_id"></a> [datasource\_id](#output\_datasource\_id) | n/a |
| <a name="output_datasource_name"></a> [datasource\_name](#output\_datasource\_name) | n/a |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | n/a |
| <a name="output_domain_name_api_association_api_id"></a> [domain\_name\_api\_association\_api\_id](#output\_domain\_name\_api\_association\_api\_id) | n/a |
| <a name="output_domain_name_api_association_id"></a> [domain\_name\_api\_association\_id](#output\_domain\_name\_api\_association\_id) | n/a |
| <a name="output_domain_name_id"></a> [domain\_name\_id](#output\_domain\_name\_id) | n/a |
| <a name="output_function_api_id"></a> [function\_api\_id](#output\_function\_api\_id) | n/a |
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | n/a |
| <a name="output_function_id"></a> [function\_id](#output\_function\_id) | n/a |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | n/a |
| <a name="output_graphql_api_arn"></a> [graphql\_api\_arn](#output\_graphql\_api\_arn) | n/a |
| <a name="output_graphql_api_id"></a> [graphql\_api\_id](#output\_graphql\_api\_id) | n/a |
| <a name="output_graphql_api_name"></a> [graphql\_api\_name](#output\_graphql\_api\_name) | n/a |
| <a name="output_resolver_api_id"></a> [resolver\_api\_id](#output\_resolver\_api\_id) | n/a |
| <a name="output_resolver_arn"></a> [resolver\_arn](#output\_resolver\_arn) | n/a |
| <a name="output_resolver_id"></a> [resolver\_id](#output\_resolver\_id) | n/a |
| <a name="output_type_api_id"></a> [type\_api\_id](#output\_type\_api\_id) | n/a |
| <a name="output_type_arn"></a> [type\_arn](#output\_type\_arn) | n/a |
| <a name="output_type_id"></a> [type\_id](#output\_type\_id) | n/a |
| <a name="output_type_name"></a> [type\_name](#output\_type\_name) | n/a |
