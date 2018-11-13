resource "aws_autoscaling_group" "asg_group_proxy" {
  name = "${var.ENVIRONMENT}-asg-group-proxy"
  launch_configuration = "${aws_launch_configuration.launch_config_proxy.name}"
  vpc_zone_identifier = ["${aws_subnet.public.*.id}"]
  min_size = 2
  max_size = 4
  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
  metrics_granularity = "1Minute"
  load_balancers = ["${aws_elb.elb_inbound.id}"]
  health_check_type = "ELB"
  wait_for_capacity_timeout = "5m"
  tag {
    key = "Name"
    value = "${var.ENVIRONMENT}-asg-group-proxy"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "launch_config_proxy" {
  name_prefix = "${var.ENVIRONMENT}-proxy_launch_config-"
  image_id = "${lookup(var.AMI_UBUNTU, var.AWS_REGION)}"
  instance_type = "${var.SERVER_PROXY_EC2_INSTANCE_TYPE}"
  key_name = "${aws_key_pair.deploy_key.id}"
  enable_monitoring = true
  associate_public_ip_address = false
  user_data = "${file(var.INSTALL_PROXY_SERVER)}"
  # iam_instance_profile = "${var.M_APP_S3_ACCESS_PROFILE_ID}"
  security_groups = [
    "${aws_security_group.ssh_private_in.id}",
    "${aws_security_group.proxy_instance.id}",
    "${aws_security_group.proxy_instance.id}"
  ]

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_type = "gp2"
    delete_on_termination = true
  }
}
