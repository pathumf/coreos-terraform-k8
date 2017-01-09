resource "aws_vpc" "k8-vpc" {
    cidr_block = "${var.cidr_vpc_block}"
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags {
      name = "k8-${var.cluster_name}"
    }
  }

resource "aws_subnet" "k8-master-subnet" {
  vpc_id ="${aws_vpc.k8-vpc.id}"
  cidr_block ="${var.cidr_block_master}"
  map_public_ip_on_launch = true
  availability_zone = "${var.az_master_zone}"
  tags {
    name = "k8-master-${var.cluster_name}-subnet"
  }
 }

 resource "aws_subnet" "k8-etcd-subnet-zone01" {
   vpc_id ="${aws_vpc.k8-vpc.id}"
   cidr_block="${var.cidr_block_etcd}"
   map_public_ip_on_launch = false
   availability_zone = "${var.az_etcd_zone1}"
   tags {
     name = "k8-etcd-${var.cluster_name}-subnet"
   }
}

resource "aws_subnet" "k8-etcd-subnet-zone02" {
  vpc_id ="${aws_vpc.k8-vpc.id}"
  cidr_block="${var.cidr_block_etcd}"
  map_public_ip_on_launch = false
  availability_zone = "${var.az_etcd_zone2}"
  tags {
    name = "k8-etcd-${var.cluster_name}-subnet"
  }
}

resource "aws_subnet" "k8-worker-subnet-zone01" {
  vpc_id = "${aws_vpc.k8-vpc.id}"
  cidr_block ="${var.cidr_block_worker_zone01}"
  map_public_ip_on_launch = false
  availability_zone = "${var.az_worker_zone01}"
  tags {
    name = "k8-worker-${var.cluster_name}-subnet-zone01"
  }
}

resource "aws_subnet" "k8-worker-subnet-zone02" {
  vpc_id = "${aws_vpc.k8-vpc.id}"
  cidr_block ="${var.cidr_block_worker_zone02}"
  map_public_ip_on_launch = false
  availability_zone = "${var.az_worker_zone02}"
  tags {
    name = "k8-worker-${var.cluster_name}-subnet-zone02"
  }
}

resource "aws_internet_gateway" "k8-igw" {
  vpc_id = "${aws_vpc.k8-vpc.id}"
  tags {
    name = "k8-igw-${var.cluster_name}"
  }
}

resource "aws_route_table" "k8-public-route" {
  vpc_id = "${aws_vpc.k8-vpc.id}"
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.k8-igw.id}"
  }
  tags {
    name = "k8-public-route-${var.cluster_name}"
  }

}

resource "aws_route_table_association" "k8-public-route" {
  subnet_id ="${aws_subnet.k8-master-subnet.id}"
  route_table_id = "${aws_route_table.k8-public-route.id}"

}

resource "aws_route_table" "k8-backend" {
  vpc_id = "${aws_vpc.k8-vpc.id}"

  tags = {
    Name = "backend-${var.cluster_name}"
  }
}

resource "aws_route" "k8-backend_default" {
  route_table_id         = "${aws_route_table.k8-backend.id}"
  destination_cidr_block = "0.0.0.0/0"
  instance_id = "${aws_instance.nat.id}"
}

resource "aws_route_table_association" "backend" {
  subnet_id = ["${aws_subnet.k8-etcd-subnet-zone01.id}","${aws_subnet.k8-etcd-subnet-zone02.id}","${aws_subnet.k8-worker-subnet-zone01.id}","${aws_subnet.k8-worker-subnet-zone02.id}"]
  route_table_id ="${aws_route_table.k8-backend.id}"
}

resource "aws_security_group" "k8-security-group-master" {
    name = "k8-master-sg-${var.cluster_name}"
    vpc_id = "${aws_vpc.k8-vpc.id}"
    ingress{
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "k8-security-group-master-${var.cluster_name}"
    }
}

resource "aws_security_group" "k8-security-group-etcd" {
  name = "k8-etcd-sg-${var.cluster_name}"
  vpc_id = "${aws_vpc.k8-vpc.id}"
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    name = "k8-security-group-etcd-${var.cluster_name}"
  }

}

resource "aws_security_group" "k8-security-group-worker" {
  name = "k8-worker-sg-${var.cluster_name}"
  vpc_id = "${aws_vpc.k8-vpc.id}"
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    name = "k8-security-group-worker-${var.cluster_name}"
  }
}
