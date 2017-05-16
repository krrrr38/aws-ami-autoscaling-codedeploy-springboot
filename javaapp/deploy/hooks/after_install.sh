#!/bin/bash

set -euxo pipefail

JAVAAPP_NAME=javaapp
APP_PATH=/var/$JAVAAPP_NAME
CONFIG_PATH="$APP_PATH/config"

echo "copy app configs"

# app sustemctl service file
sudo cp "$CONFIG_PATH/$JAVAAPP_NAME.service" "/etc/systemd/system/$JAVAAPP_NAME.service"
sudo systemctl enable "$JAVAAPP_NAME.service"
sudo systemctl daemon-reload

# spring-boot read conf from jar directory
sudo mv "$CONFIG_PATH/$JAVAAPP_NAME.conf" $APP_PATH
