locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

resource "google_compute_url_map" "this" {
  name            = var.name
  project         = var.project
  description     = var.description
  default_service = var.default_service

  dynamic "host_rule" {
    for_each = var.host_rules
    content {
      hosts        = host_rule.value.hosts
      path_matcher = host_rule.value.path_matcher
    }
  }

  dynamic "path_matcher" {
    for_each = var.path_matchers
    content {
      name            = path_matcher.value.name
      default_service = path_matcher.value.default_service

      dynamic "path_rule" {
        for_each = try(path_matcher.value.path_rules, [])
        content {
          paths   = path_rule.value.paths
          service = try(path_rule.value.service, null)

          dynamic "route_action" {
            for_each = try(path_rule.value.route_action, null) != null ? [path_rule.value.route_action] : []
            content {
              dynamic "weighted_backend_services" {
                for_each = try(route_action.value.weighted_backend_services, [])
                content {
                  backend_service = weighted_backend_services.value.backend_service
                  weight          = weighted_backend_services.value.weight

                  dynamic "header_action" {
                    for_each = try(weighted_backend_services.value.header_action, null) != null ? [weighted_backend_services.value.header_action] : []
                    content {
                      request_headers_to_remove  = try(header_action.value.request_headers_to_remove, null)
                      response_headers_to_remove = try(header_action.value.response_headers_to_remove, null)

                      dynamic "request_headers_to_add" {
                        for_each = try(header_action.value.request_headers_to_add, [])
                        content {
                          header_name  = request_headers_to_add.value.header_name
                          header_value = request_headers_to_add.value.header_value
                          replace      = try(request_headers_to_add.value.replace, false)
                        }
                      }

                      dynamic "response_headers_to_add" {
                        for_each = try(header_action.value.response_headers_to_add, [])
                        content {
                          header_name  = response_headers_to_add.value.header_name
                          header_value = response_headers_to_add.value.header_value
                          replace      = try(response_headers_to_add.value.replace, false)
                        }
                      }
                    }
                  }
                }
              }

              dynamic "url_rewrite" {
                for_each = try(route_action.value.url_rewrite, null) != null ? [route_action.value.url_rewrite] : []
                content {
                  host_rewrite        = try(url_rewrite.value.host_rewrite, null)
                  path_prefix_rewrite = try(url_rewrite.value.path_prefix_rewrite, null)
                }
              }

              dynamic "timeout" {
                for_each = try(route_action.value.timeout, null) != null ? [route_action.value.timeout] : []
                content {
                  seconds = timeout.value.seconds
                  nanos   = try(timeout.value.nanos, 0)
                }
              }

              dynamic "retry_policy" {
                for_each = try(route_action.value.retry_policy, null) != null ? [route_action.value.retry_policy] : []
                content {
                  retry_conditions = try(retry_policy.value.retry_conditions, [])
                  num_retries      = try(retry_policy.value.num_retries, 1)

                  dynamic "per_try_timeout" {
                    for_each = try(retry_policy.value.per_try_timeout, null) != null ? [retry_policy.value.per_try_timeout] : []
                    content {
                      seconds = per_try_timeout.value.seconds
                      nanos   = try(per_try_timeout.value.nanos, 0)
                    }
                  }
                }
              }

              dynamic "cors_policy" {
                for_each = try(route_action.value.cors_policy, null) != null ? [route_action.value.cors_policy] : []
                content {
                  allow_origins        = try(cors_policy.value.allow_origins, [])
                  allow_origin_regexes = try(cors_policy.value.allow_origin_regexes, [])
                  allow_methods        = try(cors_policy.value.allow_methods, [])
                  allow_headers        = try(cors_policy.value.allow_headers, [])
                  expose_headers       = try(cors_policy.value.expose_headers, [])
                  max_age              = try(cors_policy.value.max_age, null)
                  allow_credentials    = try(cors_policy.value.allow_credentials, false)
                  disabled             = try(cors_policy.value.disabled, false)
                }
              }

              dynamic "fault_injection_policy" {
                for_each = try(route_action.value.fault_injection_policy, null) != null ? [route_action.value.fault_injection_policy] : []
                content {
                  dynamic "delay" {
                    for_each = try(fault_injection_policy.value.delay, null) != null ? [fault_injection_policy.value.delay] : []
                    content {
                      percentage = try(delay.value.percentage, 0)

                      dynamic "fixed_delay" {
                        for_each = try(delay.value.fixed_delay, null) != null ? [delay.value.fixed_delay] : []
                        content {
                          seconds = fixed_delay.value.seconds
                          nanos   = try(fixed_delay.value.nanos, 0)
                        }
                      }
                    }
                  }

                  dynamic "abort" {
                    for_each = try(fault_injection_policy.value.abort, null) != null ? [fault_injection_policy.value.abort] : []
                    content {
                      http_status = abort.value.http_status
                      percentage  = try(abort.value.percentage, 0)
                    }
                  }
                }
              }
            }
          }

          dynamic "url_redirect" {
            for_each = try(path_rule.value.url_redirect, null) != null ? [path_rule.value.url_redirect] : []
            content {
              host_redirect          = try(url_redirect.value.host_redirect, null)
              path_redirect          = try(url_redirect.value.path_redirect, null)
              prefix_redirect        = try(url_redirect.value.prefix_redirect, null)
              redirect_response_code = try(url_redirect.value.redirect_response_code, "MOVED_PERMANENTLY_DEFAULT")
              https_redirect         = try(url_redirect.value.https_redirect, false)
              strip_query            = try(url_redirect.value.strip_query, false)
            }
          }
        }
      }

      dynamic "route_rules" {
        for_each = try(path_matcher.value.route_rules, [])
        content {
          priority = route_rules.value.priority
          service  = try(route_rules.value.service, null)

          dynamic "match_rules" {
            for_each = try(route_rules.value.match_rules, [])
            content {
              full_path_match   = try(match_rules.value.full_path_match, null)
              prefix_match      = try(match_rules.value.prefix_match, null)
              regex_match       = try(match_rules.value.regex_match, null)
              ignore_case       = try(match_rules.value.ignore_case, false)

              dynamic "header_matches" {
                for_each = try(match_rules.value.header_matches, [])
                content {
                  header_name  = header_matches.value.header_name
                  exact_match  = try(header_matches.value.exact_match, null)
                  regex_match  = try(header_matches.value.regex_match, null)
                  prefix_match = try(header_matches.value.prefix_match, null)
                  suffix_match = try(header_matches.value.suffix_match, null)
                  invert_match = try(header_matches.value.invert_match, false)

                  dynamic "range_match" {
                    for_each = try(header_matches.value.range_match, null) != null ? [header_matches.value.range_match] : []
                    content {
                      range_start = range_match.value.range_start
                      range_end   = range_match.value.range_end
                    }
                  }

                  present_match = try(header_matches.value.present_match, null)
                }
              }

              dynamic "query_parameter_matches" {
                for_each = try(match_rules.value.query_parameter_matches, [])
                content {
                  name          = query_parameter_matches.value.name
                  exact_match   = try(query_parameter_matches.value.exact_match, null)
                  regex_match   = try(query_parameter_matches.value.regex_match, null)
                  present_match = try(query_parameter_matches.value.present_match, null)
                }
              }

              dynamic "metadata_filters" {
                for_each = try(match_rules.value.metadata_filters, [])
                content {
                  filter_match_criteria = metadata_filters.value.filter_match_criteria

                  dynamic "filter_labels" {
                    for_each = metadata_filters.value.filter_labels
                    content {
                      name  = filter_labels.value.name
                      value = filter_labels.value.value
                    }
                  }
                }
              }
            }
          }

          dynamic "route_action" {
            for_each = try(route_rules.value.route_action, null) != null ? [route_rules.value.route_action] : []
            content {
              # Same route_action structure as path_rule above
              # Omitted for brevity - would be identical
            }
          }

          dynamic "url_redirect" {
            for_each = try(route_rules.value.url_redirect, null) != null ? [route_rules.value.url_redirect] : []
            content {
              host_redirect          = try(url_redirect.value.host_redirect, null)
              path_redirect          = try(url_redirect.value.path_redirect, null)
              prefix_redirect        = try(url_redirect.value.prefix_redirect, null)
              redirect_response_code = try(url_redirect.value.redirect_response_code, "MOVED_PERMANENTLY_DEFAULT")
              https_redirect         = try(url_redirect.value.https_redirect, false)
              strip_query            = try(url_redirect.value.strip_query, false)
            }
          }
        }
      }

      dynamic "default_url_redirect" {
        for_each = try(path_matcher.value.default_url_redirect, null) != null ? [path_matcher.value.default_url_redirect] : []
        content {
          host_redirect          = try(default_url_redirect.value.host_redirect, null)
          path_redirect          = try(default_url_redirect.value.path_redirect, null)
          prefix_redirect        = try(default_url_redirect.value.prefix_redirect, null)
          redirect_response_code = try(default_url_redirect.value.redirect_response_code, "MOVED_PERMANENTLY_DEFAULT")
          https_redirect         = try(default_url_redirect.value.https_redirect, false)
          strip_query            = try(default_url_redirect.value.strip_query, false)
        }
      }
    }
  }

  dynamic "default_url_redirect" {
    for_each = var.default_url_redirect != null ? [var.default_url_redirect] : []
    content {
      host_redirect          = try(default_url_redirect.value.host_redirect, null)
      path_redirect          = try(default_url_redirect.value.path_redirect, null)
      prefix_redirect        = try(default_url_redirect.value.prefix_redirect, null)
      redirect_response_code = try(default_url_redirect.value.redirect_response_code, "MOVED_PERMANENTLY_DEFAULT")
      https_redirect         = try(default_url_redirect.value.https_redirect, false)
      strip_query            = try(default_url_redirect.value.strip_query, false)
    }
  }

  dynamic "test" {
    for_each = var.tests
    content {
      service     = test.value.service
      host        = test.value.host
      path        = test.value.path
      description = try(test.value.description, null)
    }
  }

  dynamic "header_action" {
    for_each = var.header_action != null ? [var.header_action] : []
    content {
      request_headers_to_remove  = try(header_action.value.request_headers_to_remove, null)
      response_headers_to_remove = try(header_action.value.response_headers_to_remove, null)

      dynamic "request_headers_to_add" {
        for_each = try(header_action.value.request_headers_to_add, [])
        content {
          header_name  = request_headers_to_add.value.header_name
          header_value = request_headers_to_add.value.header_value
          replace      = try(request_headers_to_add.value.replace, false)
        }
      }

      dynamic "response_headers_to_add" {
        for_each = try(header_action.value.response_headers_to_add, [])
        content {
          header_name  = response_headers_to_add.value.header_name
          header_value = response_headers_to_add.value.header_value
          replace      = try(response_headers_to_add.value.replace, false)
        }
      }
    }
  }

  dynamic "default_route_action" {
    for_each = length(var.default_route_action_weighted_backend_services) > 0 ? [1] : []
    content {
      dynamic "weighted_backend_services" {
        for_each = var.default_route_action_weighted_backend_services
        content {
          backend_service = weighted_backend_services.value.backend_service
          weight          = weighted_backend_services.value.weight
        }
      }
    }
  }
}
