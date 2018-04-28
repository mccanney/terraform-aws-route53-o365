provider "aws" {
    version = "~> 1.14"
    region  = "${var.region}"
}

terraform {
    backend "s3" {
      bucket  = "terraform-remote-state-bucket-s3"
      key     = "tiguard.technology/terraform.tfstate"
      region  = "eu-west-2"
      encrypt = true
    }
}

resource "aws_route53_zone" "test_zone" {
    name              = "${var.domain}"
    comment           = "Route53 DNS zone for ${var.domain}"
    delegation_set_id = "${var.delegation_id}"
}

module "route53-o365" {
    source = "../.."

    domain       = "${var.domain}"
    zone_id      = "${aws_route53_zone.test_zone.zone_id}"
    ms_txt       = "ms12345678"
    enable_dkim  = true
    enable_dmarc = true
    dmarc_record = "v=DMARC1; p=none; rua=mailto:dmarc@tiguard.technology; ruf=mailto:dmarc@tiguard.technology"
    tenant_name  = "tiguard"
}
