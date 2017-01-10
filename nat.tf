resource "aws_instance" "nat" {
 ami                         = "${var.nat_ami}"
 instance_type               = "m3.medium"
 key_name                    = "${var.key_name}"
 vpc_security_group_ids      = ["${aws_security_group.k8-security-group-master.id}"]
 subnet_id                   = "${aws_subnet.k8-master-subnet.id}"
 associate_public_ip_address = true
 source_dest_check           = false

 root_block_device {
   volume_type           = "gp2"
   volume_size           = "8"
   delete_on_termination = true
 }

 tags {
     name = "nat-${var.cluster_name}"
    }

}

/* Elastic IPs*/
resource "aws_eip" "nat" {
 instance = "${aws_instance.nat.id}"
 vpc      = true
}
