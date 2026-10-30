variable "service_account_id" {
  description = "Service account ID or email to create key for."
  type        = string
}

variable "key_algorithm" {
  description = "Key algorithm (KEY_ALG_RSA_1024, KEY_ALG_RSA_2048)."
  type        = string
  default     = "KEY_ALG_RSA_2048"

  validation {
    condition     = contains(["KEY_ALG_RSA_1024", "KEY_ALG_RSA_2048"], var.key_algorithm)
    error_message = "key_algorithm must be KEY_ALG_RSA_1024 or KEY_ALG_RSA_2048."
  }
}

variable "private_key_type" {
  description = "Private key encoding format (TYPE_GOOGLE_CREDENTIALS_FILE, TYPE_PKCS12_FILE, TYPE_UNSPECIFIED)."
  type        = string
  default     = "TYPE_GOOGLE_CREDENTIALS_FILE"

  validation {
    condition     = contains(["TYPE_GOOGLE_CREDENTIALS_FILE", "TYPE_PKCS12_FILE", "TYPE_UNSPECIFIED"], var.private_key_type)
    error_message = "Invalid private_key_type."
  }
}

variable "public_key_type" {
  description = "Public key encoding format (TYPE_X509_PEM_FILE, TYPE_RAW_PUBLIC_KEY, TYPE_UNSPECIFIED)."
  type        = string
  default     = "TYPE_X509_PEM_FILE"

  validation {
    condition     = contains(["TYPE_X509_PEM_FILE", "TYPE_RAW_PUBLIC_KEY", "TYPE_UNSPECIFIED"], var.public_key_type)
    error_message = "Invalid public_key_type."
  }
}

variable "keepers" {
  description = "Arbitrary map to trigger key rotation."
  type = object({
    rotation_time = optional(string)
  })
  default = null
}
