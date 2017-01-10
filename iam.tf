resource "aws_iam_role" "master" {
    name = "k8s-master"
    path = "/"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "master" {
    name = "k8s-master"
    roles = ["${aws_iam_role.master.name}"]
}

resource "aws_iam_role_policy" "master" {
    name = "k8s-master"
    role = "${aws_iam_role.master.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::${var.s3_bucket}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]

    
}
EOF
}

resource "aws_iam_role_policy" "worker" {
    name = "k8s-worker"
    role = "${aws_iam_role.worker.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:AttachVolume",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:DetachVolume",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:BatchGetImage"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "worker" {
    name = "k8s-worker"
    roles = ["${aws_iam_role.worker.name}"]
}

resource "aws_iam_role" "worker" {
    name = "k8s-worker"
    path = "/"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


/*== NAT INSTANCE IAM PROFILE ==*/
resource "aws_iam_instance_profile" "nat" {
    name  = "k8-nat"
    roles = ["${aws_iam_role.nat.name}"]
}

resource "aws_iam_role" "nat" {
    name = "k8-nat"
    path = "/"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {"AWS": "*"},
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "nat" {
    name = "k8-nat"
    path = "/"
    description = "NAT IAM policy"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:ModifyInstanceAttribute",
                "ec2:DescribeSubnets",
                "ec2:DescribeRouteTables",
                "ec2:CreateRoute",
                "ec2:ReplaceRoute"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
