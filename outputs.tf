output "mx_record" {
    description = "The DNS name of the specific Office 365 mail server for the domain."
    value       = "${local.domain_guid}.mail.protection.outlook.com}"
}
