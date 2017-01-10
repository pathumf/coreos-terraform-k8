resource "aws_s3_bucket" "s3-k8tlscert" {
  bucket = "${var.s3_bucket}"
  acl ="private"
}

resource "aws_s3_bucket_object" "ca" {
    bucket = "${aws_s3_bucket.s3-k8tlscert.id}"
    key = "k8TLSkey/ca.pem"
    source = "k8TLSkey/ca.pem"
}

resource "aws_s3_bucket_object" "k8-key" {
    bucket = "${aws_s3_bucket.s3-k8tlscert.id}"
    key = "k8TLSkey/kubernetes-key.pem"
    source = "k8TLSkey/kubernetes-key.pem"
}

resource "aws_s3_bucket_object" "k8-pub" {
    bucket = "${aws_s3_bucket.s3-k8tlscert.id}"
    key = "k8TLSkey/kubernetes.pem"
    source = "k8TLSkey/kubernetes.pem"
}
