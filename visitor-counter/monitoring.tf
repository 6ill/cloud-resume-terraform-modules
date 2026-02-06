locals {
  alarm_configs = {
    errors = {
      metric_name         = "Errors"
      threshold           = 0
      period              = 60
      statistic           = "Sum"
      comparison_operator = "GreaterThanThreshold"
      alarm_description   = "Triggered when lambda gets error"
    }
    latency = {
      metric_name         = "Duration"
      threshold           = 2000
      period              = 60
      statistic           = "Average"
      comparison_operator = "GreaterThanThreshold"
      alarm_description   = "Triggered when lambda takes too long"
    }
    invocations = {
      metric_name         = "Invocations"
      threshold           = 15
      period              = 60
      statistic           = "Sum"
      comparison_operator = "GreaterThanThreshold"
      alarm_description   = "Triggered when lambda gets called many time"
    }
  }
}

resource "aws_sns_topic" "alerts" {
  name = "visitor-counter-alerts"
}

resource "aws_sns_topic_subscription" "lambda_alerts" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

resource "aws_cloudwatch_metric_alarm" "lambda_alerts" {
  for_each            = local.alarm_configs
  alarm_name          = "visitor-counter-${each.key}"
  alarm_description   = each.value.alarm_description
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = 1
  metric_name         = each.value.metric_name
  namespace           = "AWS/Lambda"
  period              = each.value.period
  statistic           = each.value.statistic
  threshold           = each.value.threshold

  dimensions = {
    FunctionName = aws_lambda_function.visitor_counter.function_name
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
}
