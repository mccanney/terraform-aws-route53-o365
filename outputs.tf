output "mx_record" {
    description = "The DNS name of the specific Office 365 mail server for the domain."
    value       = "${data.template_file.domain_guid.rendered}.mail.protection.outlook.com}"
}