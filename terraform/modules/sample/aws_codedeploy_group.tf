resource "aws_codedeploy_deployment_group" "sample" {
  app_name               = "${aws_codedeploy_app.sample.name}"
  deployment_group_name  = "sample"
  service_role_arn       = "${aws_iam_role.sample_codedeploy.arn}"
  autoscaling_groups     = ["${aws_autoscaling_group.sample.id}"]
  deployment_config_name = "CodeDeployDefault.OneAtATime"

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
