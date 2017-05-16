#!/bin/bash

set -euxo pipefail

JAVAAPP_NAME=javaapp
LB_WAIT_COMMAND="sleep 12" # see also aws_alb_target_group.tf
STATUS_OFF_COMMAND="curl -XPOST localhost:8080/status/off > /dev/null"

echo "stop $JAVAAPP_NAME"
eval $STATUS_OFF_COMMAND |:
eval $LB_WAIT_COMMAND |:
sudo systemctl stop "$JAVAAPP_NAME" |:
