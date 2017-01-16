resource "aws_security_group_rule" "master-etcd" {
 type = "ingress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 source_security_group_id = "${aws_security_group.k8-security-group-etcd.id}"
 security_group_id = "${aws_security_group.k8-security-group-master.id}"
}

resource "aws_security_group_rule" "master-worker" {
 type = "ingress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 source_security_group_id = "${aws_security_group.k8-security-group-worker.id}"
 security_group_id = "${aws_security_group.k8-security-group-master.id}"

}

resource "aws_security_group_rule" "etcd-master" {
 type = "ingress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 source_security_group_id = "${aws_security_group.k8-security-group-master.id}"
 security_group_id = "${aws_security_group.k8-security-group-etcd.id}"
}

resource "aws_security_group_rule" "etcd-worker" {
 type = "ingress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 source_security_group_id = "${aws_security_group.k8-security-group-worker.id}"
 security_group_id = "${aws_security_group.k8-security-group-etcd.id}"

}

resource "aws_security_group_rule" "worker-master" {
 type = "ingress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 source_security_group_id = "${aws_security_group.k8-security-group-master.id}"
 security_group_id = "${aws_security_group.k8-security-group-worker.id}"
}

resource "aws_security_group_rule" "worker-etcd" {
 type = "ingress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 source_security_group_id = "${aws_security_group.k8-security-group-etcd.id}"
 security_group_id = "${aws_security_group.k8-security-group-worker.id}"
}

resource "aws_security_group" "elb_sg" {
  name        = "kube-elb-sg"
  description = "Security group for elbs exposed to outside"
  vpc_id = "${aws_vpc.k8-vpc.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2380
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2379
    to_port     = 2379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}
