resource "aws_dynamodb_table" "dynamodbposts" {
    name        =   "posts"
    hash_key    =   "id"
    read_capacity   =   20
    write_capacity  =   20
    attribute {
        name    =   "id"
        type    =   "S"
    }
}