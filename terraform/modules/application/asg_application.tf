resource "aws_autoscaling_group" "asg_group_application" {
  name = "${var.ENVIRONMENT}-asg-group-application"
  launch_configuration = "${aws_launch_configuration.launch_config_application.name}"
  vpc_zone_identifier = ["${aws_subnet.private.*.id}"]
  min_size = 2
  max_size = 4
  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
  metrics_granularity = "1Minute"
  load_balancers = ["${aws_elb.elb_application.id}"]
  health_check_type = "ELB"
  wait_for_capacity_timeout = "5m"
  tag {
    key = "Name"
    value = "${var.ENVIRONMENT}-asg-group-application"
    propagate_at_launch = true
  }
}

resource "aws_key_pair" "deploy_key_app" {
  key_name = "${var.ENVIRONMENT}_Deploy_Key_App"
  public_key = "${file(var.DEPLOY_KEY)}"
}


resource "aws_launch_configuration" "launch_config_application" {
  name_prefix = "${var.ENVIRONMENT}-application_launch_config-"
  image_id = "${lookup(var.AMI_UBUNTU, var.AWS_REGION)}"
  instance_type = "${var.SERVER_PROXY_EC2_INSTANCE_TYPE}"
  key_name = "${aws_key_pair.deploy_key_app.id}"
  enable_monitoring = true
  associate_public_ip_address = false
  user_data = "${file(var.INSTALL_APPLICATION)}"
  iam_instance_profile = "${aws_iam_instance_profile.s3_access_profile.id}"
  security_groups = [
    "${var.M_FRONT_SSH_PRIVATE_IN_ID}",
    "${aws_security_group.application_inbound.id}",
    "${aws_security_group.application_outbound.id}",
    "${var.M_DB_PRIVATE_DATABASE_ID}"
  ]

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_type = "gp2"
    delete_on_termination = true
  }
}
