resource "aws_lambda_function" "stock-lambda" {
  function_name    = "stock-lambda"
  filename         = "${path.module}/src_stock_lambda/src_stock_lambda.zip"
  handler          = "handler.handler"
  role             = aws_iam_role.sales-api-role.arn
  runtime          = "nodejs14.x"
  memory_size      = 128
  timeout          = 1
  publish          = true
  tags = {
    Environment = "production2"
  }

  environment {
    variables = {
      USERNAME = var.connect_db2["username"]
      DATABASE = var.connect_db2["database"]
      HOSTNAME = var.connect_db2["hostname"]
      PASSWORD = var.connect_db2["password"]
    }
  }
}

resource "aws_lambda_event_source_mapping" "stock-lambda-sqs-trigger" {
  event_source_arn = aws_sqs_queue.sales-sqs.arn
  function_name    = aws_lambda_function.stock-lambda.arn
}