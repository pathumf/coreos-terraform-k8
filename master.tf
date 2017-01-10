resource "aws_autoscaling_group" "master" {
  vpc_zone_identifier       = ["${aws_subnet.k8-master-subnet.id}"]
  name                      = "k8-master-asg-${var.cluster_name}"
  max_size                  = 3
  min_size                  = "${var.master_node_count}"
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = "${var.master_node_count}"
  force_delete              = false
  launch_configuration      = "${aws_launch_configuration.master.name}"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_launch_configuration" "master" {
  name                 = "k8-master-lc-${var.cluster_name}"
  image_id             = "${var.core_ami}"
  instance_type        = "${var.master_ins_type}"
  key_name             = "${var.key_name}"
  security_groups      = ["${aws_security_group.k8-security-group-master.id}"]
  user_data            = "${file("${path.module}/files/user-data-master")}"
  iam_instance_profile = "${aws_iam_instance_profile.master.id}"


  lifecycle {
    create_before_destroy = true
  }
}

#master loadbalancer
resource "aws_elb" "master-elb" {
  name = "k8-master-elb-${var.cluster_name}"

  # The same availability zone as our instances
  availability_zones = ["${split(",", var.az_list_all)}"]
  internal = "true"

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }

  listener {
    instance_port     = 443
    instance_protocol = "http"
    lb_port           = 443
    lb_protocol       = "http"
  }

  listener {
    instance_port     = 10249
    instance_protocol = "tcp"
    lb_port           = 10249
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 10251
    instance_protocol = "tcp"
    lb_port           = 10251
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 10252
    instance_protocol = "tcp"
    lb_port           = 10252
    lb_protocol       = "tcp"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8080"
    interval            = 30
  }

}

