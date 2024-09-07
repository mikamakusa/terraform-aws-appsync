resource "aws_appsync_api_cache" "this" {
  count                      = length(var.graphql_api) == 0 ? 0 : length(var.api_cache)
  api_caching_behavior       = lookup(var.api_cache[count.index], "api_caching_behavior")
  api_id                     = try(element(aws_appsync_graphql_api.this.*.id, lookup(var.api_cache[count.index], "api_id")))
  ttl                        = lookup(var.api_cache[count.index], "ttl")
  type                       = lookup(var.api_cache[count.index], "type")
  at_rest_encryption_enabled = lookup(var.api_cache[count.index], "at_rest_encryption_enabled")
  transit_encryption_enabled = lookup(var.api_cache[count.index], "transit_encryption_enabled")
}

resource "aws_appsync_api_key" "this" {
  count       = length(var.graphql_api) == 0 ? 0 : length(var.api_key)
  api_id      = try(element(aws_appsync_graphql_api.this.*.id, lookup(var.api_key[count.index], "api_id")))
  description = lookup(var.api_key[count.index], "description")
  expires     = lookup(var.api_key[count.index], "expires")
}

resource "aws_appsync_datasource" "this" {
  count            = length(var.graphql_api) == 0 ? 0 : length(var.datasource)
  api_id           = try(element(aws_appsync_graphql_api.this.*.id, lookup(var.datasource[count.index], "api_id")))
  name             = lookup(var.datasource[count.index], "name")
  type             = lookup(var.datasource[count.index], "type")
  description      = lookup(var.datasource[count.index], "description")
  service_role_arn = var.datasource_service_role_arn

  dynamic "dynamodb_config" {
    for_each = ""
    content {
      table_name             = ""
      region                 = ""
      use_caller_credentials = true
      versioned              = true

      dynamic "delta_sync_config" {
        for_each = ""
        content {
          delta_sync_table_name = ""
          delta_sync_table_ttl  = 0
          base_table_ttl        = 0
        }
      }
    }
  }

  dynamic "elasticsearch_config" {
    for_each = ""
    content {
      endpoint = ""
      region   = ""
    }
  }

  dynamic "event_bridge_config" {
    for_each = ""
    content {
      event_bus_arn = ""
    }
  }

  dynamic "http_config" {
    for_each = ""
    content {
      endpoint = ""

      dynamic "authorization_config" {
        for_each = ""
        content {
          authorization_type = ""

          dynamic "aws_iam_config" {
            for_each = ""
            content {
              signing_region       = ""
              signing_service_name = ""
            }
          }
        }
      }
    }
  }

  dynamic "lambda_config" {
    for_each = ""
    content {
      function_arn = ""
    }
  }

  dynamic "opensearchservice_config" {
    for_each = ""
    content {
      endpoint = ""
      region   = ""
    }
  }

  dynamic "relational_database_config" {
    for_each = ""
    content {
      source_type = ""

      dynamic "http_endpoint_config" {
        for_each = ""
        content {
          aws_secret_store_arn  = ""
          db_cluster_identifier = ""
          database_name         = ""
          region                = ""
          schema                = ""
        }
      }
    }
  }
}

resource "aws_appsync_domain_name" "this" {
  count           = length(var.acm_certificate) == 0 ? 0 : length(var.domain_name)
  certificate_arn = try(element(module.acm.*.acm_certificate_arn, lookup(var.domain_name[count.index], "certificate_id")))
  domain_name     = lookup(var.domain_name[count.index], "domain_name")
  description     = lookup(var.domain_name[count.index], "description")
}

resource "aws_appsync_domain_name_api_association" "this" {
  count       = (length(var.graphql_api) && length(var.domain_name)) == 0 ? 0 : length(var.domain_name_api_association)
  api_id      = try(element(aws_appsync_graphql_api.this.*.id, lookup(var.domain_name_api_association[count.index], "api_id")))
  domain_name = try(element(aws_appsync_domain_name.this.*.domain_name, lookup(var.domain_name_api_association[count.index], "domain_name_id")))
}

resource "aws_appsync_function" "this" {
  count                     = (length(var.graphql_api) && length(var.datasource)) == 0 ? 0 : length(var.function)
  api_id                    = try(element(aws_appsync_graphql_api.this.*.id, lookup(var.function[count.index], "api_id")))
  data_source               = try(element(aws_appsync_datasource.this.*.name, lookup(var.function[count.index], "data_source_id")))
  name                      = lookup(var.function[count.index], "name")
  code                      = file(join("/", [path.cwd, "code", lookup(var.function[count.index], "code")]))
  max_batch_size            = lookup(var.function[count.index], "max_batch_size")
  request_mapping_template  = lookup(var.function[count.index], "request_mapping_template")
  response_mapping_template = lookup(var.function[count.index], "response_mapping_template")
  description               = lookup(var.function[count.index], "description")
  function_version          = lookup(var.function[count.index], "function_version", "2018-05-29")

  dynamic "runtime" {
    for_each = try(lookup(var.function[count.index], "runtime") == null ? [] : ["runtime"])
    iterator = run
    content {
      name            = lookup(run.value, "name", "APPSYNC_JS")
      runtime_version = lookup(run.value, "runtime_version", "1.0.0")
    }
  }

  dynamic "sync_config" {
    for_each = try(lookup(var.function[count.index], "sync_config") == null ? [] : ["sync_config"])
    iterator = syn
    content {
      conflict_detection = lookup(syn.value, "conflict_detection")
      conflict_handler   = lookup(syn.value, "conflict_handler")

      dynamic "lambda_conflict_handler_config" {
        for_each = lookup(syn.value, "conflict_handler") != "LAMBDA" ? try(lookup(syn.value, "lambda_conflict_handler_config") == null ? [] : ["lambda_conflict_handler_config"]) : []
        iterator = lam
        content {
          lambda_conflict_handler_arn = lookup(lam.value, "lambda_conflict_handler_arn")
        }
      }
    }
  }
}

resource "aws_appsync_graphql_api" "this" {
  count                = length(var.graphql_api)
  authentication_type  = lookup(var.graphql_api[count.index], "authentication_type")
  name                 = lookup(var.graphql_api[count.index], "name")
  query_depth_limit    = lookup(var.graphql_api[count.index], "query_depth_limit")
  resolver_count_limit = lookup(var.graphql_api[count.index], "resolver_count_limit")
  schema               = lookup(var.graphql_api[count.index], "schema")
  visibility           = lookup(var.graphql_api[count.index], "visibility")
  xray_enabled         = lookup(var.graphql_api[count.index], "xray_enabled")

  dynamic "additional_authentication_provider" {
    for_each = try(lookup(var.graphql_api[count.index], "additional_authentication_provider") == null ? [] : ["additional_authentication_provider"])
    iterator = add
    content {
      authentication_type = lookup(add.value, "authentication_type")
    }
  }

  dynamic "lambda_authorizer_config" {
    for_each = try(lookup(var.graphql_api[count.index], "lambda_authorizer_config") == null ? [] : ["lambda_authorizer_config"])
    iterator = lam
    content {
      authorizer_uri                   = lookup(lam.value, "authorizer_uri")
      authorizer_result_ttl_in_seconds = lookup(lam.value, "authorizer_result_ttl_in_seconds")
      identity_validation_expression   = lookup(lam.value, "identity_validation_expression")
    }
  }

  dynamic "log_config" {
    for_each = try(lookup(var.graphql_api[count.index], "log_config") == null ? [] : ["log_config"])
    iterator = log
    content {
      field_log_level          = lookup(log.value, "field_log_level")
      exclude_verbose_content  = lookup(log.value, "exclude_verbose_content")
      cloudwatch_logs_role_arn = lookup(log.value, "cloudwatch_logs_role_arn", false)
    }
  }

  dynamic "openid_connect_config" {
    for_each = try(lookup(var.graphql_api[count.index], "openid_connect_config") == null ? [] : ["openid_connect_config"])
    iterator = ope
    content {
      issuer    = lookup(ope.value, "issuer")
      auth_ttl  = lookup(ope.value, "auth_ttl")
      iat_ttl   = lookup(ope.value, "iat_ttl")
      client_id = lookup(ope.value, "client_id")
    }
  }

  dynamic "user_pool_config" {
    for_each = try(lookup(var.graphql_api[count.index], "user_pool_config") == null ? [] : ["user_pool_config"])
    iterator = use
    content {
      default_action      = lookup(use.value, "default_action")
      user_pool_id        = lookup(use.value, "user_pool_id")
      app_id_client_regex = lookup(use.value, "app_id_client_regex")
      aws_region          = lookup(use.value, "aws_region")
    }
  }
}

resource "aws_appsync_resolver" "this" {
  api_id = ""
  field  = ""
  type   = ""
}

resource "aws_appsync_type" "this" {
  api_id     = ""
  definition = ""
  format     = ""
}