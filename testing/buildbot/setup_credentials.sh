#!/bin/bash

# Setup of test credentials for index and registry. Called by Vagrantfile.
export PATH="/bin:sbin:/usr/bin:/usr/sbin:/usr/local/bin"

USER=$1
REGISTRY_USER=$2
REGISTRY_PWD=$3
REGISTRY_BUCKET=$4
REGISTRY_ACCESS_KEY=$5
REGISTRY_SECRET_KEY=$6

BUILDBOT_PATH="/data/buildbot"
DOCKER_PATH="/go/src/github.com/dotcloud/docker"

function run { su $USER -c "$1"; }

run "cp $DOCKER_PATH/testing/buildbot/credentials.cfg $BUILDBOT_PATH/master"
cd $BUILDBOT_PATH/master
run "sed -i -E 's#(export DOCKER_CREDS=).+#\1\"$REGISTRY_USER:$REGISTRY_PWD\"#' credentials.cfg"
run "sed -i -E 's#(export S3_BUCKET=).+#\1\"$REGISTRY_BUCKET\"#' credentials.cfg"
run "sed -i -E 's#(export S3_ACCESS_KEY=).+#\1\"$REGISTRY_ACCESS_KEY\"#' credentials.cfg"
run "sed -i -E 's#(export S3_SECRET_KEY=).+#\1\"$REGISTRY_SECRET_KEY\"#' credentials.cfg"
