resource "aws_lambda_function" "increase_lambda" {
  function_name    = "stock-inc-lambda"
  filename         = "${path.module}/src_increase_lambda/src_increase_lambda.zip"
  runtime          = "nodejs14.x"
  handler          = "handler.handler"
  role             = aws_iam_role.sales-api-role.arn

  timeout = 15

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

resource "aws_lambda_permission" "inc_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.increase_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.myregion}:${var.account-id}:${module.stock_inc_api_gateway.apigatewayv2_api_id}/*"
}
