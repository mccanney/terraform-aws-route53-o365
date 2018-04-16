variable "domain" {
    description = "The name of the domain to create Office365 DNS records in"
    default     = ""
}

variable "ttl" {
    description = "The time-to-live value for the DNS record"
    default     = "3600"
}

variable "ms_txt" {
    description = "The value of the MS=mxXYZ TXT record Office365 requires to prove domain ownership"
    default     = ""
}

variable "enable_exchange" {
    description = "Controls if the DNS records for Exchange Online should be created"
    default     = false
}

variable "enable_sfb" {
    description = "Controls if the DNS records for Skype for Business should be created"
    default     = false
}

variable "enable_mdm" {
    description = "Controls if the DNS records for Mobile Device Management should be created"
    default     = false
}