resource "aws_iam_role" "ec2_iam_role" {
  name_prefix        = "${var.name}-${var.env}"
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

resource "aws_iam_role_policy_attachment" "ec2_iam_new_role_attachment" {
  role       = aws_iam_role.ec2_iam_role
  count      = length(var.iam_policy_arn)
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ec2_iam_custom_role_attachment" {
  for_each   = var.iam_policy_arn
  policy_arn = each.value
  role       = aws_iam_role.ec2_iam_role
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  role = aws_iam_role.ec2_iam_role.name
  name = var.instance_profile_name
}
