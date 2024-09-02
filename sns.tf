resource "aws_sns_topic" "ce7-azmi1-sns-tf" {
  name = "ce7-azmi1-sns-tf"

  tags = {
    Name = "ce7-azmi1-sns-tf"
  }
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.ce7-azmi1-sns-tf.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.ce7-azmi1-sqs-tf.arn
}

data "aws_iam_policy_document" "test" {
  statement {
    sid    = "__owner_statement"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::255945442255:root"]
    }

    actions   = ["sqs:*"]
    resources = [aws_sqs_queue.ce7-azmi1-sqs-tf.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.ce7-azmi1-sns-tf.arn]
    }
  }
  statement {
    sid    = "topic-subscription-arn:aws:sns:us-east-1:255945442255:ce7-azmi1-sns-tf"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.ce7-azmi1-sqs-tf.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.ce7-azmi1-sns-tf.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.ce7-azmi1-sqs-tf.id
  policy    = data.aws_iam_policy_document.test.json
}