output "api_endpoint" {
  description = "The endpoint of API Gateway that invokes lambda visitor counter"
  value       = "${aws_apigatewayv2_api.http_api.api_endpoint}/count"
}
