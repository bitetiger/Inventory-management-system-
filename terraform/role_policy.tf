resource "aws_iam_role" "sales-api-role" {
  name               = "sales-role2"
  assume_role_policy = jsonencode({

  "Version": "2012-10-17",
  "Statement": {
    "Action": "sts:AssumeRole"
    "Principal": {
      "Service": "lambda.amazonaws.com"
    },
    "Effect": "Allow"
  }
})
}

data "aws_iam_policy_document" "pol-document" {
  statement {
    sid       = ""
    actions   = [
      "sns:*",
      "sqs:*",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      aws_sns_topic.sales-api-sns.arn,
      "arn:aws:logs:*:*:*",
      aws_sqs_queue.sales-sqs.arn
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name   = "policy"
  policy = data.aws_iam_policy_document.pol-document.json
}

resource "aws_iam_role_policy_attachment" "POLICY_ATTACHMENT" {
  role       = aws_iam_role.sales-api-role.name
  policy_arn = aws_iam_policy.policy.arn
}

#sqs policy
resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.sales-sqs.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sales-sqs.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.sales-api-sns.arn}"
        }
      }
    }
  ]
}
POLICY
}

