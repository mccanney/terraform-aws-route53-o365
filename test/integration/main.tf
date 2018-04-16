provider "aws" {
    version = "~> 1.14"
    region  = "us-east-1"
}

resource "aws_route53_zone" "test_zone" {
    name              = "tiguard.technology"
    comment           = "Route53 DNS zone for tiguard.technology"
}

module "terraform-aws-office365" {
    source = "../.."

    domain          = "tiguard.technology"
    zone_id         = "${aws_route53_zone.test_zone.zone_id}"
    ms_txt          = "ms12345678"
    enable_exchange = true
    enable_sfb      = true
    enable_mdm      = true
}
