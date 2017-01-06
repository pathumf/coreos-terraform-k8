/*=== NAT INSTANCE ASG ===*/
resource "aws_autoscaling_group" "nat" {
    name                      = "nat-asg-${var.cluster_name}"
    vpc_zone_identifier       = "${aws_subnet.k8-master-subnet}"
    max_size                  = 1
    min_size                  = 1
    health_check_grace_period = 60
    default_cooldown          = 60
    health_check_type         = "EC2"
    desired_capacity          = 1
    force_delete              = false
    launch_configuration      = "${aws_launch_configuration.nat.name}"
    tag {
      key                 = "Name"
      value               = "nat-${var.cluster_name}"
      propagate_at_launch = true
    }

   lifecycle {
      create_before_destroy = true
    }
}

resource "aws_launch_configuration" "nat" {
    name                        = "${var.cluster_name}-k8-nat-lc"
    image_id                    = "${var.nat_ami}"
    instance_type               = "${var.nat_ins_type}"
    iam_instance_profile        = "${aws_iam_instance_profile.nat.name}"
    key_name                    = "${var.key_name}"
    security_groups             = ["${aws_security_group.k8-master-sg.id}"]
    associate_public_ip_address = true
    sorce_dest_check            = false
    lifecycle {
      create_before_destroy = true
    }
    depends_on = [
      "aws_iam_policy_attachment.nat"
      "aws_iam_role_policy.nat"
      "aws_security_group.k8-master-sg"
    ]
}
