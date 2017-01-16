resource "aws_route53_zone" "main" {
  name = "paas.cloud"
  vpc_id = "${aws_vpc.k8-vpc.id}"

  tags {
    Environment = "main"
  }

}

resource "aws_route53_record" "master" {
   zone_id = "${aws_route53_zone.main.zone_id}"
   name = "master.paas.cloud"
   type = "A"

   alias {
    name = "${aws_elb.master-elb.dns_name}"
    zone_id = "${aws_elb.master-elb.zone_id}"
    evaluate_target_health = true
  }

}

resource "aws_route53_record" "etcd" {
   zone_id = "${aws_route53_zone.main.zone_id}"
   name = "etcd.paas.cloud"
   type = "A"

   alias {
    name = "${aws_elb.etcd-elb.dns_name}"
    zone_id = "${aws_elb.etcd-elb.zone_id}"
    evaluate_target_health = true
  }

}
