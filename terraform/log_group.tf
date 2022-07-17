resource "aws_cloudwatch_log_group" "sales-api-group" {
  name = "/aws/lambda/${aws_lambda_function.sales-api-lambda.function_name}"
  retention_in_days = 3

  tags = {
    Environment = "production"
  }
}
/* 
resource "aws_cloudwatch_log_destination" "sales-api-log-destination" {
  name       = "sales-api-log-destination"
  role_arn   = aws_iam_role.sales-api-role.arn
  target_arn = aws_lambda_function.sales-api-lambda.arn
} */

resource "aws_cloudwatch_log_group" "stock-lambda" {
  name = "/aws/lambda/${aws_lambda_function.stock-lambda.function_name}"
  retention_in_days = 3

  tags = {
    Environment = "production2"
  }
}