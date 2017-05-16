#!/bin/bash

set -euxo pipefail

JAVAAPP_NAME=javaapp
HEALTH_CHECK_URL="http://localhost:8080/status/check"
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION="ap-northeast-1"
TARGET_GROUP_NAME="sample"
ALB_TARGET_GROUPS_ARN=`aws elbv2 describe-target-groups --region $REGION --names $TARGET_GROUP_NAME --query "TargetGroups[0].TargetGroupArn" | sed -e 's/"//g'`

echo "start $JAVAAPP_NAME"
sudo systemctl start "$JAVAAPP_NAME"

# wait javaapp starts
HEALTH_CHECK_CMD="curl -I -s -S $HEALTH_CHECK_URL | head -1 | awk '{ print \$2 }'"
while :; do
    response=`eval $HEALTH_CHECK_CMD || true`
    if [ "${response}" == "200" ]; then
        exit 0
    fi
    sleep 2
done

# register target into ALB (for autoscaling)
aws elbv2 register-targets --region $REGION --target-group-arn $ALB_TARGET_GROUPS_ARN --targets Id=$INSTANCE_ID
