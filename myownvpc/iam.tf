resource "aws_iam_role" "flowlogrole" {
  name = "flowlogrole"

  assume_role_policy = "${file("flowlogsrole.json")}"
}

resource "aws_iam_role_policy" "flowlogpolicy" {
  name = "test_policy"
  role = "${aws_iam_role.flowlogrole.id}"

  policy = "${file("flowlogpolicy.json")}"
}