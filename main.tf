provider "template" {
    version = "~> 1.0"
}

data "aws_route53_zone" "selected" {
    name = "${var.domain}."
}

data "template_file" "mx_record" {
    template = "10 ${replace("${var.domain}", ".", "-")}.mail.protection.outlook.com"
}

data "template_file" "passed_zoneid" {
    count = "${length("${var.depends_on}")}"
    
    template = "${var.depends_on}"
}

data "template_file" "computed_zoneid" {
    count = "${1 - length("${var.depends_on}")}"

    template = "${data.template_file.mx_record.rendered}"
}

#################
# Exchange Online
#################

resource "aws_route53_record" "mx" {
    count   = "${var.enable_exchange ? 1 : 0}"

    zone_id = "${element(concat(data.template_file.passed_zoneid.*.rendered, data.template_file.computed_zoneid.*.rendered), 0)}"   
    name    = ""
    records = ["${data.template_file.mx_record.rendered}"]
    type    = "MX"
    ttl     = "${var.ttl}"
}
