module "sample" {
  aws_region                                    = "${var.aws_region}"
  aws_launch_configuration_sample_instance_type = "${var.aws_launch_configuration_sample_instance_type}"
  aws_launch_configuration_sample_user_data     = "${var.aws_launch_configuration_sample_user_data}"
  source                                        = "./modules/sample"
}
