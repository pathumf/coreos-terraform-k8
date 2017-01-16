resource "template_file" "etcd-user-data" {
  template = "${file("data/etcd-userdata.yml")}"

  vars = {
    etcd_discovery_url = "${replace(file("etcd_discovery_url.txt"), "/\n/", "")}"
  }
}

resource "template_file" "master-user-data" {
  template = "${file("data/master-userdata.yml")}"
  vars  {
    KUBERNETES_VERSION = "${var.kubernetes_version}"
    KUBERNETES_CONTAINERS_CIDR = "${var.pod_network}"
    FLANNELD_ETCD_ENDPOINTS = "http://${aws_route53_record.etcd.name}:2379"
    ETCD_ENDPOINTS = "http://${aws_route53_record.etcd.name}:2379"
    SERVICE_IP_RANGE = "${var.service_ip_range}"
    API_SECURE_PORT = "${var.api_secure_port}"
    DNS_SERVICE_IP = "${var.dns_service_ip}"
    S3_BUCKET = "${var.s3_bucket}"
    K8S_VER = "${var.kubelet_version}"
    aws_region = "${var.region}"
  }

}

resource "template_file" "worker-user-data" {
  template = "${file("data/worker-userdata.yml")}"
  vars  {
    KUBERNETES_VERSION = "${var.kubernetes_version}"
    KUBERNETES_CONTAINERS_CIDR = "${var.pod_network}"
    FLANNELD_ETCD_ENDPOINTS = "http://${aws_route53_record.etcd.name}:2379"
    ETCD_ENDPOINTS = "http://${aws_route53_record.etcd.name}:2379"
    SERVICE_IP_RANGE = "${var.service_ip_range}"
    API_SECURE_PORT = "${var.api_secure_port}"
    DNS_SERVICE_IP = "${var.dns_service_ip}"
    MASTER_ELB = "${aws_route53_record.master.name}"
    S3_BUCKET = "${var.s3_bucket}"
    K8S_VER = "${var.kubelet_version}"
    aws_region = "${var.region}"
  }

}
