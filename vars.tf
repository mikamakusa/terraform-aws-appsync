## TAGS

variable "tags" {
  type    = map(string)
  default = {}
}

## ROLES

variable "datasource_service_role_arn" {
  type    = string
  default = null
}

## MODULES

variable "acm_certificate" {
  type    = any
  default = []
}

## RESOURCES

variable "api_cache" {
  type = list(object({
    id                         = number
    api_caching_behavior       = string
    api_id                     = any
    ttl                        = number
    type                       = string
    at_rest_encryption_enabled = optional(bool)
    transit_encryption_enabled = optional(bool)
  }))
  default = []

  validation {
    condition     = length([for a in var.api_cache : true if contains(["FULL_REQUEST_CACHING", "PRE_RESOLVER_CACHING"], a.api_caching_behavior)]) == length(var.api_cache)
    error_message = "Caching behavior. Valid values are FULL_REQUEST_CACHING and PER_RESOLVER_CACHING."
  }

  validation {
    condition     = length([for b in var.api_cache : true if contains(["SMALL", "MEDIUM", "LARGE", "XLARGE", "LARGE_2X", "LARGE_4X", "LARGE_8X", "LARGE_12X", "T2_SMALL", "T2_MEDIUM", "R4_LARGE", "R4_XLARGE", "R4_2XLARGE", "R4_4XLARGE", "R4_8XLARGE"], b.type)]) == length(var.api_cache)
    error_message = "Cache instance type. Valid values are SMALL, MEDIUM, LARGE, XLARGE, LARGE_2X, LARGE_4X, LARGE_8X, LARGE_12X, T2_SMALL, T2_MEDIUM, R4_LARGE, R4_XLARGE, R4_2XLARGE, R4_4XLARGE, R4_8XLARGE."
  }
}

variable "api_key" {
  type = list(object({
    id          = number
    api_id      = any
    description = optional(string)
    expires     = optional(string)
  }))
  default = []
}

variable "datasource" {
  type = list(object({
    id          = number
    api_id      = any
    name        = string
    type        = string
    description = optional(string)
    dynamodb_config = optional(list(object({
      table_name             = string
      region                 = optional(string)
      use_caller_credentials = optional(bool)
      versioned              = optional(bool)
      delta_sync_config = optional(list(object({
        delta_sync_table_name = string
        delta_sync_table_ttl  = optional(number)
        base_table_ttl        = optional(number)
      })))
    })))
    elasticsearch_config = optional(list(object({
      endpoint = string
      region   = optional(string)
    })))
    event_bridge_config = optional(list(object({
      event_bus_arn = any
    })))
    http_config = optional(list(object({
      endpoint = string
      authorization_config = optional(list(object({
        authorization_type = optional(string)
        aws_iam_config = optional(list(object({
          signing_region       = optional(string)
          signing_service_name = optional(string)
        })))
      })))
    })))
    lambda_config = optional(list(object({
      function_arn = any
    })))
    opensearchservice_config = optional(list(object({
      endpoint = string
      region   = optional(string)
    })))
    relational_database_config = optional(list(object({
      source_type = optional(string)
      http_endpoint_config = list(object({
        aws_secret_store_arn  = any
        db_cluster_identifier = any
        database_name         = optional(string)
        region                = optional(string)
        schema                = optional(string)
      }))
    })))
  }))
  default = []

  validation {
    condition     = length([for a in var.datasource : true if contains(["AWS_LAMBDA", "AMAZON_DYNAMODB", "AMAZON_ELASTICSEARCH", "HTTP", "NONE", "RELATIONAL_DATABASE", "AMAZON_EVENTBRIDGE", "AMAZON_OPENSEARCH_SERVICE"], a.type)]) == length(var.datasource)
    error_message = "Type of the Data Source. Valid values: AWS_LAMBDA, AMAZON_DYNAMODB, AMAZON_ELASTICSEARCH, HTTP, NONE, RELATIONAL_DATABASE, AMAZON_EVENTBRIDGE, AMAZON_OPENSEARCH_SERVICE."
  }
}

variable "domain_name" {
  type = list(object({
    id             = number
    certificate_id = any
    domain_name    = string
    description    = optional(string)
  }))
  default = []
}

variable "domain_name_api_association" {
  type = list(object({
    id             = number
    api_id         = any
    domain_name_id = any
  }))
  default = []
}

variable "function" {
  type = list(object({
    id                        = number
    api_id                    = any
    data_source_id            = any
    name                      = string
    code                      = optional(string)
    max_batch_size            = optional(number)
    request_mapping_template  = optional(string)
    response_mapping_template = optional(string)
    description               = optional(string)
    function_version          = optional(string)
    runtime = optional(list(object({
      name            = string
      runtime_version = string
    })))
    sync_config = optional(list(object({
      conflict_detection = optional(string)
      conflict_handler   = optional(string)
      lambda_conflict_handler_config = optional(list(object({
        lambda_conflict_handler_arn = optional(any)
      })))
    })))
  }))
  default = []

  validation {
    condition     = length([for a in var.function : true if a.max_batch_size >= 0 && a.max_batch_size <= 200]) == length(var.function)
    error_message = "Maximum batching size for a resolver. Valid values are between 0 and 2000."
  }

  validation {
    condition     = length([for b in var.function : true if contains(["NONE", "OPTIMISTIC_CONCURRENCY", "AUTOMERGE", "LAMBDA"], b.sync_config.conflict_handler)]) == length(var.function)
    error_message = "Conflict Resolution strategy to perform in the event of a conflict. Valid values are NONE, OPTIMISTIC_CONCURRENCY, AUTOMERGE, and LAMBDA."
  }

  validation {
    condition     = length([for c in var.function : true if contains(["NONE", "OPTIMISTIC_CONCURRENCY", "AUTOMERGE", "LAMBDA"], c.sync_config.conflict_detection)]) == length(var.function)
    error_message = "Conflict Detection strategy to use. Valid values are NONE and VERSION."
  }
}

variable "graphql_api" {
  type = list(object({
    id                   = number
    authentication_type  = string
    name                 = string
    query_depth_limit    = optional(number)
    resolver_count_limit = optional(number)
    schema               = optional(string)
    visibility           = optional(string)
    xray_enabled         = optional(bool)
    additional_authentication_provider = optional(list(object({
      authentication_type = string
    })))
    lambda_authorizer_config = optional(list(object({
      authorizer_uri                   = string
      authorizer_result_ttl_in_seconds = optional(number)
      identity_validation_expression   = optional(string)
    })))
    log_config = optional(list(object({
      cloudwatch_logs_role_arn = any
      field_log_level          = string
      exclude_verbose_content  = optional(bool)
    })))
    openid_connect_config = optional(list(object({
      issuer    = string
      auth_ttl  = optional(number)
      iat_ttl   = optional(number)
      client_id = optional(string)
    })))
    user_pool_config = optional(list(object({
      default_action      = string
      user_pool_id        = any
      app_id_client_regex = optional(string)
      aws_region          = optional(string)
    })))
  }))
  default = []

  validation {
    condition     = length([for a in var.graphql_api : true if contains(["API_KEY", "AWS_IAM", "AMAZON_COGNITO_USER_POOLS", "OPENID_CONNECT", "AWS_LAMBDA"], a.authentication_type)]) == length(var.graphql_api)
    error_message = "Authentication type. Valid values: API_KEY, AWS_IAM, AMAZON_COGNITO_USER_POOLS, OPENID_CONNECT, AWS_LAMBDA."
  }

  validation {
    condition     = length([for b in var.graphql_api : true if contains(["API_KEY", "AWS_IAM", "AMAZON_COGNITO_USER_POOLS", "OPENID_CONNECT", "AWS_LAMBDA"], b.additional_authentication_provider.authentication_type)]) == length(var.graphql_api)
    error_message = "Authentication type. Valid values: API_KEY, AWS_IAM, AMAZON_COGNITO_USER_POOLS, OPENID_CONNECT, AWS_LAMBDA."
  }

  validation {
    condition     = length([for c in var.graphql_api : true if contains(["ALL", "ERROR", "NONE"], c.log_config.field_log_level)]) == length(var.graphql_api)
    error_message = "Field logging level. Valid values: ALL, ERROR, NONE."
  }

  validation {
    condition     = length([for d in var.graphql_api : true if contains(["ALLOW", "DENY"], d.user_pool_config.default_action)]) == length(var.graphql_api)
    error_message = "Valid values: ALLOW, DENY."
  }
}

variable "resolver" {
  type = list(object({
    id                = number
    api_id            = any
    field             = string
    type              = string
    code              = optional(string)
    request_template  = optional(string)
    response_template = optional(string)
    data_source       = optional(string)
    max_batch_size    = optional(number)
    kind              = optional(string)
    caching_config = optional(list(object({
      caching_keys = optional(set(string))
      ttl          = optional(number)
    })))
    pipeline_config = optional(list(object({
      functions_id = any
    })))
    runtime = optional(list(object({
      name            = string
      runtime_version = string
    })))
    sync_config = optional(list(object({
      conflict_detection = optional(string)
      conflict_handler   = optional(string)
    })))
  }))
  default = []

  validation {
    condition     = length([for a in var.resolver : true if a.max_batch_size >= 0 && a.max_batch_size <= 2000]) == length(var.resolver)
    error_message = "Maximum batching size for a resolver. Valid values are between 0 and 2000."
  }

  validation {
    condition     = length([for b in var.resolver : true if contains(["UNIT", "PIPELINE"], b.kind)]) == length(var.resolver)
    error_message = "Resolver type. Valid values are UNIT and PIPELINE."
  }
}

variable "type" {
  type = list(object({
    id         = number
    api_id     = any
    definition = string
    format     = string
  }))
  default = []

  validation {
    condition     = length([for a in var.type : true if contains(["SDL", "JSON"], a.format)]) == length(var.type)
    error_message = "Valid values are SDL and JSON."
  }
}
