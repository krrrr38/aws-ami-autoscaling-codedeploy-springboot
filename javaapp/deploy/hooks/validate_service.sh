#!/bin/bash

set -euxo pipefail

# check the instance is healthy on the ALB target group

TARGET_GROUP_NAME="sample"
REGION="ap-northeast-1"
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
ALB_TARGET_GROUPS_ARN=`aws elbv2 describe-target-groups --region $REGION --names $TARGET_GROUP_NAME --query "TargetGroups[0].TargetGroupArn" | sed -e 's/"//g'`

# check target health
while :; do
    stat=$(aws elbv2 describe-target-health --region $REGION --target-group-arn $ALB_TARGET_GROUPS_ARN --targets Id=$INSTANCE_ID --query "TargetHealthDescriptions[0].TargetHealth.State")
    if [ `echo $stat | grep "\"healthy\""` ] ; then
        exit 0
    fi
    sleep 2
done
