resource "aws_autoscaling_group" "etcd" {
  vpc_zone_identifier       = ["${aws_subnet.k8-etcd-subnet-zone01.id}","${aws_subnet.k8-etcd-subnet-zone02.id}"]
  name                      = "k8-etcd-asg-${var.cluster_name}"
  max_size                  = 5
  min_size                  = "${var.etcd_node_count}"
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = "${var.etcd_node_count}"
  force_delete              = false
  launch_configuration      = "${aws_launch_configuration.etcd.name}"
  load_balancers            = ["${aws_elb.etcd-elb.name}"]

  tag {
    key                 = "Name"
    value               = "etcd-${var.cluster_name}"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "apptype"
    value               = "k8-etcd"
    propagate_at_launch = "true"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_launch_configuration" "etcd" {
  name                 = "k8-etcd-lc-${var.cluster_name}"
  image_id             = "${var.core_ami}"
  instance_type        = "${var.etcd_ins_type}"
  key_name             = "${var.key_name}"
  security_groups      = ["${aws_security_group.k8-security-group-etcd.id}"]
  #user_data            = "${file("${path.module}/files/etcd-userdata.yml")}"
  user_data            = "${template_file.etcd-user-data.rendered}"
  iam_instance_profile = "${aws_iam_instance_profile.master.id}"


  lifecycle {
    create_before_destroy = true
  }
}

#etcd loadbalancer
resource "aws_elb" "etcd-elb" {
  name = "k8-etcd-elb-${var.cluster_name}"
  subnets = ["${aws_subnet.k8-etcd-subnet-zone01.id}","${aws_subnet.k8-etcd-subnet-zone02.id}"]
  security_groups = ["${aws_security_group.elb_sg.id}"]
  idle_timeout = 3600
  # The same availability zone as our instances
  #availability_zones = ["${split(",", var.az_list_all)}"]
  internal = "true"

  listener {
    instance_port     = 2379
    instance_protocol = "http"
    lb_port           = 2379
    lb_protocol       = "http"
  }

  listener {
    instance_port     = 2380
    instance_protocol = "http"
    lb_port           = 2380
    lb_protocol       = "http"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:2379"
    interval            = 30
  }

}
