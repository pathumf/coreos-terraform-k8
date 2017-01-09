resource "aws_autoscaling_group" "worker" {
  vpc_zone_identifier       = ["${aws_subnet.k8-worker-subnet-zone01.id}","${aws_subnet.k8-worker-subnet-zone02.id}"]
  name                      = "k8-worker-asg-${var.cluster_name}"
  max_size                  = 7
  min_size                  = "${var.worker_node_count}"
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = "${var.worker_node_count}"
  force_delete              = false
  launch_configuration      = "${aws_launch_configuration.worker.name}"
  tags {
    key = "Name"
    value = "k8-worker-asg-${var.cluster_name}"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_launch_configuration" "worker" {
  name                 = "k8-worker-lc-${var.cluster_name}"
  image_id             = "${var.core_ami}"
  instance_type        = "${var.worker_ins_type}"
  key_name             = "${var.key_name}"
  security_groups      = ["${aws_security_group.k8-security-group-worker.id}"]
  user_data            = "${file("${path.module}/files/user-data-worker")}"
  iam_instance_profile = "${aws_iam_instance_profile.worker.id}"


  lifecycle {
    create_before_destroy = true
  }
}
