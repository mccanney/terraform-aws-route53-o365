output "mx_record" {
    value = "${replace("${data.template_file.mx_record.rendered}", "/^10./", "")}"
}