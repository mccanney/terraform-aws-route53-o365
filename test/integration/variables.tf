variable "region" {
    default = "us-east-1"
}

variable "domain" {
    default = "tiguard.technology"
}

# Delegation ID is set via an environment variable.
variable "delegation_id" {
    default = ""
}

# Tenant name is set via an environment variable.
variable "tenant_name" {
    default = ""
}
