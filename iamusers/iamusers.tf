resource "aws_iam_group" "oziadministrators" {
    name = "my-administrator-group"
}
resource "aws_iam_policy_attachment" "administrators-policy-attach" {
    name = "ozi-administrators-policy-attach"
    groups = ["${aws_iam_group.oziadministrators.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
# user
resource "aws_iam_user" "oziuser1" {
    name = "OziUser1"
}
resource "aws_iam_user" "oziuser2" {
    name = "OziUser2"
}
resource "aws_iam_group_membership" "administrators-users" {
    name = "administrators-users"
    users = [
        "${aws_iam_user.oziuser1.name}",
        "${aws_iam_user.oziuser2.name}",
    ]
    group = "${aws_iam_group.oziadministrators.name}"
}
