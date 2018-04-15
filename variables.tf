variable "domain" {
    description = "The name of the domain to create Office365 DNS records"
    default     = "test.com"
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