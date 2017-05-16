#!/bin/bash

set -euxo pipefail

JAVAAPP_NAME=javaapp
JAVAAPP_VERSION=0.0.1-SNAPSHOT
APPLICATION_NAME=sample
DEPLOYMENT_GROUP_NAME=sample
DEPLOY_DIRECTORY=deploy
CONFIG_DIRECTORY=config
UPLOAD_S3_PATH=s3://sampledeploy/$JAVAAPP_NAME.zip

./gradlew clean build

echo "cp jar and configs into deploy directory"

cp "build/libs/$JAVAAPP_NAME-$JAVAAPP_VERSION.jar" "$DEPLOY_DIRECTORY/$JAVAAPP_NAME.jar"
chmod +x "$DEPLOY_DIRECTORY/$JAVAAPP_NAME.jar"
cp -r $CONFIG_DIRECTORY $DEPLOY_DIRECTORY

echo "upload zip deploy directory into $UPLOAD_S3_PATH"

aws deploy push \
    --application-name $APPLICATION_NAME \
    --s3-location $UPLOAD_S3_PATH \
    --source $DEPLOY_DIRECTORY

LATEST_ETAG=`aws deploy list-application-revisions --application-name sample --sort-by registerTime --sort-order descending | /usr/bin/grep "eTag" | head -1 | perl -p -e 's/.*: "(.*)".*/$1/'`

echo "deploy starting..."

aws deploy create-deployment \
    --ignore-application-stop-failures \
    --application-name $APPLICATION_NAME \
    --s3-location bucket=sampledeploy,key=$JAVAAPP_NAME.zip,bundleType=zip,eTag=$LATEST_ETAG \
    --deployment-group-name $DEPLOYMENT_GROUP_NAME
