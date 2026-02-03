output "bucket_name" {
  value = aws_s3_bucket.static_site.id
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "distribution_id" {
  value = aws_cloudfront_distribution.s3_distribution.id
}
