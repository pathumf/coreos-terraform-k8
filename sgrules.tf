resource "aws_security_group_rule" "master" {
 type = "ingress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 source_security_group_id = "${aws_security_group.k8-security-group-etcd.id}"
 security_group_id = "${aws_security_group.k8-security-group-master.id}"

 type = "ingress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 source_security_group_id = "${aws_security_group.k8-security-group-worker.id}"
 security_group_id = "${aws_security_group.k8-security-group-master.id}"

}

resource "aws_security_group_rule" "etcd" {
 type = "ingress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 source_security_group_id = "${aws_security_group.k8-security-group-master.id}"
 security_group_id = "${aws_security_group.k8-security-group-etcd.id}"

 type = "ingress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 source_security_group_id = "${aws_security_group.k8-security-group-worker.id}"
 security_group_id = "${aws_security_group.k8-security-group-etcd.id}"

}




resource "aws_security_group_rule" "worker" {
 type = "ingress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 source_security_group_id = "${aws_security_group.k8-security-group-master.id}"
 security_group_id = "${aws_security_group.k8-security-group-worker.id}"

 type = "ingress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 source_security_group_id = "${aws_security_group.k8-security-group-master.id}"
 security_group_id = "${aws_security_group.k8-security-group-worker.id}"
}
