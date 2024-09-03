# module "sns_topic" {
#   source  = "terraform-aws-modules/sns/aws"

#   name  = "ce7-azmi1-sns-tf-module"

#   topic_policy_statements = {
#     pub = {
#       actions = ["sns:Publish"]
#       principals = [{
#         type        = "AWS"
#         identifiers = ["arn:aws:iam::255945442255:role/publisher"]
#       }]
#     },

#     sub = {
#       actions = [
#         "sns:Subscribe",
#         "sns:Receive",
#       ]

#       principals = [{
#         type        = "AWS"
#         identifiers = ["*"]
#       }]

#       conditions = [{
#         test     = "StringLike"
#         variable = "sns:Endpoint"
#         values   = ["arn:aws:sqs:us-east-1:255945442255:subscriber"]
#       }]
#     }
#   }

#   subscriptions = {
#     sqs = {
#       protocol = "sqs"
#       endpoint = "arn:aws:sqs:us-east-1:255945442255:subscriber"
#     }
#   }

#   tags = {
#     Environment = "dev"
#     Terraform   = "true"
#   }
# }