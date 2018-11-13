# resource "aws_autoscaling_policy" "autoscale_policy_up_proxy" {
#   name = "autoscale-policy-up"
#   scaling_adjustment = 1
#   adjustment_type = "ChangeInCapacity"
#   cooldown = 300
#   autoscaling_group_name = "${aws_autoscaling_group.asg_group_proxy.name}"
# }
#
# resource "aws_cloudwatch_metric_alarm" "cpualarm-up" {
#   alarm_name = "cpualarm-up"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods = "2"
#   metric_name = "CPUUtilization"
#   namespace = "AWS/EC2"
#   period = "120"
#   statistic = "Average"
#   threshold = "60"
#
#   dimensions {
#     AutoScalingGroupName = "${aws_autoscaling_group.asg_group_proxy.name}"
#   }
#
#   alarm_description = "This metric monitor EC2 instance cpu utilization"
#   alarm_actions = ["${aws_autoscaling_policy.autoscale_policy_up_proxy.arn}"]
# }
#
# resource "aws_autoscaling_policy" "autoscale-policy-down" {
#   name = "autoscale-policy-down"
#   scaling_adjustment = -1
#   adjustment_type = "ChangeInCapacity"
#   cooldown = 300
#   autoscaling_group_name = "${aws_autoscaling_group.asg_group_proxy.name}"
# }
#
# resource "aws_cloudwatch_metric_alarm" "cpualarm-down" {
#   alarm_name = "cpualarm-down"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods = "2"
#   metric_name = "CPUUtilization"
#   namespace = "AWS/EC2"
#   period = "120"
#   statistic = "Average"
#   threshold = "10"
#
#   dimensions {
#     AutoScalingGroupName = "${aws_autoscaling_group.asg_group_proxy.name}"
#   }
#
#   alarm_description = "This metric monitor EC2 instance cpu utilization"
#   alarm_actions = ["${aws_autoscaling_policy.autoscale-policy-down.arn}"]
# }
