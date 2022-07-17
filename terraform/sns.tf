resource "aws_sns_topic" "sales-api-sns" {
  name = "sales-api-sns"
}

/* resource "aws_lambda_permission" "with_sns" {
statement_id  = "AllowExecutionFromSNS"
action        = "lambda:InvokeFunction"
function_name = aws_lambda_function.sales-api-lambda.function_name
principal     = "sns.amazonaws.com"
source_arn    = aws_sns_topic.sales-api-sns.arn
} */

resource "aws_sns_topic_subscription" "sns_to_sqs_target" {
  topic_arn = aws_sns_topic.sales-api-sns.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sales-sqs.arn
}
resource "aws_sns_topic_policy" "sns-pol" {
  arn = aws_sns_topic.sales-api-sns.arn

  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = aws_sns_topic.sales-api-sns.id

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.sales-api-sns.arn,
    ]
  }
}

