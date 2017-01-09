resource "template_file" "etcd-user-data" {
  template = "${file("files/etcd-userdata.yml")}"

  vars = {
    etcd_discovery_url = "${replace(file("etcd_discovery_url.txt"), "/\n/", "")}"
  }
}
