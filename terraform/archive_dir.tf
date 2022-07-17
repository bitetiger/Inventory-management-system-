data "archive_file" "sales_api_file" {
  type             = "zip"
  source_dir       = "${path.module}/src"
  output_path      = "${path.module}/src/src.zip"
}

data "archive_file" "src_stock_lambda_zip" {
    type        = "zip"
  source_dir       = "${path.module}/src_stock_lambda"
  output_path      = "${path.module}/src_stock_lambda/src_stock_lambda.zip"
}

data "archive_file" "src_increase_lambda_zip" {
    type        = "zip"
  source_dir       = "${path.module}/src_increase_lambda"
  output_path      = "${path.module}/src_increase_lambda/src_increase_lambda.zip"
}