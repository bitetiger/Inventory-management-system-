resource "aws_lambda_function" "sales-api-lambda" {
  function_name    = "sales-api-lambda"
  filename         = "${path.module}/src_sales_api/src.zip"
  handler          = "handler.handler"
  role             = aws_iam_role.sales-api-role.arn
  runtime          = "nodejs14.x"
  memory_size      = 128
  timeout          = 1
  publish          = true

  environment {
    variables = {
      USERNAME = var.connect_db["username"]
      DATABASE = var.connect_db["database"]
      HOSTNAME = var.connect_db["hostname"]
      PASSWORD = var.connect_db["password"]
      TOPIC_ARN = aws_sns_topic.sales-api-sns.arn
    }
  }
}

resource "aws_lambda_function_event_invoke_config" "sales-api-invoke-conf" {
  function_name = aws_lambda_function.sales-api-lambda.function_name

  destination_config {
    on_success {
      destination = aws_sns_topic.sales-api-sns.arn
    }
  }
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sales-api-lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.myregion}:${var.account-id}:${module.api_gateway.apigatewayv2_api_id}/*"
}
