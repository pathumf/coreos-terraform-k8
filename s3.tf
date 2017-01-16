resource "aws_s3_bucket" "s3-k8tlscert" {
  bucket = "${var.s3_bucket}"
  acl ="private"
}

resource "aws_s3_bucket_object" "ca" {
    bucket = "${aws_s3_bucket.s3-k8tlscert.id}"
    key = "ca.pem"
    source = "data/config/keys/ca.pem"
}

resource "aws_s3_bucket_object" "k8-key" {
    bucket = "${aws_s3_bucket.s3-k8tlscert.id}"
    key = "kubernetes-key.pem"
    source = "data/config/keys/kubernetes-key.pem"
}
resource "aws_s3_bucket_object" "k8-pub" {
    bucket = "${aws_s3_bucket.s3-k8tlscert.id}"
    key = "kubernetes.pem"
    source = "data/config/keys/kubernetes.pem"
}

resource "aws_s3_bucket_object" "k8-controller" {
    bucket = "${aws_s3_bucket.s3-k8tlscert.id}"
    key = "kube-controller-manager.yaml"
    source = "data/config/kube-controller-manager.yaml"
}

resource "aws_s3_bucket_object" "k8-scheduler" {
    bucket = "${aws_s3_bucket.s3-k8tlscert.id}"
    key = "kube-scheduler.yaml"
    source = "data/config/kube-scheduler.yaml"
}

resource "aws_s3_bucket_object" "k8-proxy" {
    bucket = "${aws_s3_bucket.s3-k8tlscert.id}"
    key = "kube-proxy.yaml"
    source = "data/config/kube-proxy.yaml"
}

resource "aws_s3_bucket_object" "k8-proxy-worker" {
    bucket = "${aws_s3_bucket.s3-k8tlscert.id}"
    key = "kube-proxy-worker.yaml"
    source = "data/config/kube-proxy-worker.yaml"
}

resource "aws_s3_bucket_object" "k8-kubeconfig" {
    bucket = "${aws_s3_bucket.s3-k8tlscert.id}"
    key = "worker-kubeconfig.yaml"
    source = "data/config/worker-kubeconfig.yaml"
}
