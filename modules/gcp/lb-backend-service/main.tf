locals {
  merged_labels = merge({ name = var.name }, var.labels)
}

resource "google_compute_backend_service" "this" {
  name        = var.name
  project     = var.project
  description = var.description

  protocol                        = var.protocol
  port_name                       = var.port_name
  timeout_sec                     = var.timeout_sec
  enable_cdn                      = var.enable_cdn
  session_affinity                = var.session_affinity
  affinity_cookie_ttl_sec         = var.affinity_cookie_ttl_sec
  connection_draining_timeout_sec = var.connection_draining_timeout_sec
  load_balancing_scheme           = var.load_balancing_scheme

  health_checks = var.health_checks

  dynamic "backend" {
    for_each = var.backends
    content {
      group                        = backend.value.group
      balancing_mode               = try(backend.value.balancing_mode, "UTILIZATION")
      capacity_scaler              = try(backend.value.capacity_scaler, 1.0)
      max_utilization              = try(backend.value.max_utilization, 0.8)
      max_rate                     = try(backend.value.max_rate, null)
      max_rate_per_instance        = try(backend.value.max_rate_per_instance, null)
      max_connections              = try(backend.value.max_connections, null)
      max_connections_per_instance = try(backend.value.max_connections_per_instance, null)
    }
  }

  dynamic "cdn_policy" {
    for_each = var.cdn_policy != null ? [var.cdn_policy] : []
    content {
      cache_mode                   = try(cdn_policy.value.cache_mode, "CACHE_ALL_STATIC")
      default_ttl                  = try(cdn_policy.value.default_ttl, 3600)
      max_ttl                      = try(cdn_policy.value.max_ttl, 86400)
      client_ttl                   = try(cdn_policy.value.client_ttl, 3600)
      negative_caching             = try(cdn_policy.value.negative_caching, false)
      serve_while_stale            = try(cdn_policy.value.serve_while_stale, 0)
      signed_url_cache_max_age_sec = try(cdn_policy.value.signed_url_cache_max_age_sec, 0)

      dynamic "cache_key_policy" {
        for_each = try(cdn_policy.value.cache_key_policy, null) != null ? [cdn_policy.value.cache_key_policy] : []
        content {
          include_host           = try(cache_key_policy.value.include_host, true)
          include_protocol       = try(cache_key_policy.value.include_protocol, true)
          include_query_string   = try(cache_key_policy.value.include_query_string, true)
          query_string_whitelist = try(cache_key_policy.value.query_string_whitelist, null)
          query_string_blacklist = try(cache_key_policy.value.query_string_blacklist, null)
        }
      }
    }
  }

  dynamic "iap" {
    for_each = var.iap != null ? [var.iap] : []
    content {
      enabled              = try(iap.value.enabled, true)
      oauth2_client_id     = iap.value.oauth2_client_id
      oauth2_client_secret = iap.value.oauth2_client_secret
    }
  }

  dynamic "log_config" {
    for_each = var.enable_logging ? [1] : []
    content {
      enable      = true
      sample_rate = var.log_sample_rate
    }
  }

  dynamic "outlier_detection" {
    for_each = var.outlier_detection != null ? [var.outlier_detection] : []
    content {
      consecutive_errors                    = try(outlier_detection.value.consecutive_errors, 5)
      consecutive_gateway_failure           = try(outlier_detection.value.consecutive_gateway_failure, 5)
      enforcing_consecutive_errors          = try(outlier_detection.value.enforcing_consecutive_errors, 100)
      enforcing_consecutive_gateway_failure = try(outlier_detection.value.enforcing_consecutive_gateway_failure, 0)
      enforcing_success_rate                = try(outlier_detection.value.enforcing_success_rate, 0)
      max_ejection_percent                  = try(outlier_detection.value.max_ejection_percent, 10)
      success_rate_minimum_hosts            = try(outlier_detection.value.success_rate_minimum_hosts, 5)
      success_rate_request_volume           = try(outlier_detection.value.success_rate_request_volume, 100)
      success_rate_stdev_factor             = try(outlier_detection.value.success_rate_stdev_factor, 1900)

      dynamic "base_ejection_time" {
        for_each = try(outlier_detection.value.base_ejection_time, null) != null ? [outlier_detection.value.base_ejection_time] : []
        content {
          seconds = base_ejection_time.value.seconds
          nanos   = try(base_ejection_time.value.nanos, 0)
        }
      }

      dynamic "interval" {
        for_each = try(outlier_detection.value.interval, null) != null ? [outlier_detection.value.interval] : []
        content {
          seconds = interval.value.seconds
          nanos   = try(interval.value.nanos, 0)
        }
      }
    }
  }

  dynamic "circuit_breakers" {
    for_each = var.circuit_breakers != null ? [var.circuit_breakers] : []
    content {
      max_requests_per_connection = try(circuit_breakers.value.max_requests_per_connection, null)
      max_connections             = try(circuit_breakers.value.max_connections, null)
      max_pending_requests        = try(circuit_breakers.value.max_pending_requests, null)
      max_requests                = try(circuit_breakers.value.max_requests, null)
      max_retries                 = try(circuit_breakers.value.max_retries, null)
    }
  }

  dynamic "consistent_hash" {
    for_each = var.consistent_hash != null ? [var.consistent_hash] : []
    content {
      http_header_name  = try(consistent_hash.value.http_header_name, null)
      minimum_ring_size = try(consistent_hash.value.minimum_ring_size, 1024)

      dynamic "http_cookie" {
        for_each = try(consistent_hash.value.http_cookie, null) != null ? [consistent_hash.value.http_cookie] : []
        content {
          name = http_cookie.value.name
          path = try(http_cookie.value.path, null)

          dynamic "ttl" {
            for_each = try(http_cookie.value.ttl, null) != null ? [http_cookie.value.ttl] : []
            content {
              seconds = ttl.value.seconds
              nanos   = try(ttl.value.nanos, 0)
            }
          }
        }
      }
    }
  }

  custom_request_headers  = var.custom_request_headers
  custom_response_headers = var.custom_response_headers

  locality_lb_policy = var.locality_lb_policy
  security_policy    = var.security_policy

  dynamic "security_settings" {
    for_each = var.security_settings != null ? [var.security_settings] : []
    content {
      client_tls_policy = security_settings.value.client_tls_policy
      subject_alt_names = try(security_settings.value.subject_alt_names, null)
    }
  }
}
