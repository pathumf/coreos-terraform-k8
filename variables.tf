variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = ""
}
variable "cidr_vpc_block" {
  default = ""
}
variable "az_list_all" {
  default = ""
}                                                            
variable "cluster_name" {
  default = ""
}
variable "cidr_block_master" {
  default = ""
}
variable "az_master_zone" {
  default = ""
}
variable "cidr_block_etcd" {
  default = ""
}
variable "cidr_block_worker_zone01" {
  default = ""
}
variable "cidr_block_worker_zone02" {
  default = ""
}
variable "az_worker_zone01" {
  default = ""
}
variable "az_worker_zone02" {
  default = ""
}
variable "az_count" {
  default = ""
}
variable "nat_ami" {
  default = ""
}
variable "nat_ins_type" {
  default = ""
}
variable "etcd_node_count" {
  default = ""
}
variable "core_ami" {
  default = ""
}
variable "master_node_count" {
  default = ""
}
variable "master_ins_type" {
  default = ""
}
variable "worker_node_count" {
  default = ""
}
variable "worker_ins_type" {
  default = ""
}
variable "az_etcd_zone1" {
  default = ""
}
variable "az_etcd_zone2" {
  default = ""
}
