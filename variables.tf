variable "domain" {
    description = "The DNS name of the domain in which to create the Office 365 records."
    default     = ""
}

variable "zone_id" { 
    description = "The Zone ID of the Route53 DNS zone."
    default     = ""
}

variable "ttl" {
    description = "The time-to-live value for the DNS records."
    default     = "3600"
}

variable "ms_txt" {
    description = "The value of the MS=mxXYZ TXT record which Office 365 requires to prove domain ownership."
    default     = ""
}

variable "enable_exchange" {
    description = "Controls if the DNS records for Exchange Online should be created."
    default     = true
}

variable "enable_sfb" {
    description = "Controls if the DNS records for Skype for Business should be created."
    default     = true
}

variable "enable_mdm" {
    description = "Controls if the DNS records for Mobile Device Management should be created."
    default     = true
}
