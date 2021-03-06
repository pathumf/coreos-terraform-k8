variable "region" {
  default = "eu-central-1"
}
variable "cidr_vpc_block" {
  default = "10.0.0.0/16"
}
variable "az_list_all" {
  default = "eu-central-1a,eu-central-1b"
}
variable "cluster_name" {
  default = "kube-cluster"
}
variable "cidr_block_master" {
  default = "10.0.1.0/24"
}
variable "az_master_zone" {
  default = "eu-central-1a"
}
variable "cidr_block_etcd_zone01" {
  default = "10.0.2.0/26"
}
variable "cidr_block_etcd_zone02" {
  default = "10.0.2.64/26"
}
variable "cidr_block_worker_zone01" {
  default = "10.0.3.0/26"
}
variable "cidr_block_worker_zone02" {
  default = "10.0.3.64/26"
}

variable "az_count" {
  default = "2"
}
variable "nat_ami" {
  default = "ami-0b322e67"
}
variable "nat_ins_type" {
  default = "m3.medium"
}
variable "etcd_node_count" {
  default = "3"
}

variable "etcd_ins_type" {
  default="t2.micro"
}

variable "core_ami" {
  default = "ami-ed0ec882"
}
variable "master_node_count" {
  default = "1"
}
variable "master_ins_type" {
  default = "t2.large"
}
variable "worker_node_count" {
  default = "3"
}
variable "worker_ins_type" {
  default = "t2.large"
}
variable "az_zone1" {
  default = "eu-central-1a"
}
variable "az_zone2" {
  default = "eu-central-1b"
}
variable "key_name" {
  default="etcd-key"
}

variable "kubernetes_version" {
  default = "1.2.2"
}
variable "service_ip_range" {
  default = "10.5.0.0/16"
}
variable "api_secure_port" {
  default = "443"
}
variable "dns_service_ip" {
  default = "10.5.0.10"
}
variable "s3_bucket" {
  default = "paascloudtls"
}
variable "pod_network" {
    default = "10.5.0.0/16"
}
variable "kubelet_version" {
    default = "v1.5.1_coreos.0"
}
