output "mx_record" {
    description = "The DNS name of the specific Office 365 mail server for the domain."
    value       = "${replace("${data.template_file.mx_record.rendered}", "/^10./", "")}"
}