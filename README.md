# AWS AutoScaling CodeDeploy Spring Boot

## Prepare

```
$ brew install awscli packer terraform
$ aws configure # setup your own (region: ap-northeast-1)
```

## Usage

### Initialize
- Create Deployment S3 Bucket by manually
  - e.g. `aws s3 mb s3://sampledeploy`
  - this s3 bucket is used for CodeDeploy or LaunchConfiguration for EC2 Instance (put/pull zip file)
- Create AMI with Packer
- Run Terraform
- Deploy Java Application
  - Continuous Deploy, just do `deploy.sh`

### Components

- `packer`
- `terraform`
- `javaapp`

## Packer

Create AMI

- require `AWS_ACCESS_KEY` & `AWS_SECRET_KEY`
  - who has [credentials](https://www.packer.io/docs/builders/amazon.html#using-an-iam-instance-profile)
- this AMI includes followings
  - CodeDeploy agent
  - `user-data.sh` which run when instance is up

```sh
$ cd packer
$ packer build sampleapp.json
```

## terraform

aws provisioner for `ap-northeast-1`. this requires `AMI` which is build by above `Packer`. (`ami_id` is automatically selected with aws api)

```
$ cd terraform
$ terraform init
```

example settings (this settings is for terraform managed state)

```sh
$ terraform init
The name of the S3 bucket
  Enter a value: terraformsample
The path to the state file inside the bucket
  Enter a value: sampleapp
The region of the S3 bucket.
  Enter a value: ap-northeast-1
```

```
$ terraform plan
$ terraform apply
```

- start point is `terraform/module_sample.tf`.
  - `ami_id` is fetched by `data resource` (see `terraform/modules/sample/data.f`)

### ssh into instance

If you want to ssh instances, apply following diff. (bastion server is not ready)

```diff
diff --git a/terraform/modules/sample/aws_launch_configuration.tf b/terraform/modules/sample/aws_launch_configuration.tf
index b6720ea..6146565 100644
--- a/terraform/modules/sample/aws_launch_configuration.tf
+++ b/terraform/modules/sample/aws_launch_configuration.tf
@@ -7,4 +7,5 @@ resource "aws_launch_configuration" "sample" {
name                        = "sample"
security_groups             = ["${aws_security_group.sample_web.id}"]
user_data                   = "${var.aws_launch_configuration_sample_user_data}"
+  key_name                    = "YOUR_KEYPAIR_KEY_NAME"
}
```

## Java Application

- `javaapp/deploy/appspec.yml`
  - CodeDeploy scripts
  - this is used for continuous deployment

### Local Run

```sh
$ cd javaapp
$ ./gradlew clean bootRun
```

- endpoints

```sh
$ curl localhost:8080 # 200 OK
$ curl localhost:8080/check/status # 200 OK
$ curl -XPOST localhost:8080/check/off # 200 OK
$ curl localhost:8080/check/status # 503 SERVICE UNAVAILABLE
```

### Deploy

- `deploy.sh`
  - create executable jar
  - aws deploy
    - zip following files (`deploy` directory)
      - executable jar
      - application initialize script
      - appspec.yml (for CodeDeploy)
    - upload zip into s3
  - run create-deployment

generally this script is executed by jenkins or somewhere
