resource "aws_iam_role" "LambdaPostReaderRole" {
    name = "LambdaPostReaderRole"
    assume_role_policy = "${data.template_file.lambdarolefile.rendered}"
}

resource "aws_iam_policy" "LambdaPostReaderPolicy" {
    name        = "LambdaPostReaderPolicy"
    policy = "${data.template_file.lambdapolicyfile.rendered}"
}

resource "aws_iam_role_policy_attachment" "PolicyRoleAttachement" {
    role       = "${aws_iam_role.LambdaPostReaderRole.name}"
    policy_arn = "${aws_iam_policy.LambdaPostReaderPolicy.arn}"
}

data "template_file" "lambdapolicyfile" {
  template = "${file("json/lambdapolicy.json")}"
}

data "template_file" "lambdarolefile" {
  template = "${file("json/lambdarole.json")}"
}