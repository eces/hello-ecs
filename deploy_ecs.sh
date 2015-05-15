#! /bin/bash

SHA1=$1

docker push quay.io/eces/hello-ecs

# aws ecs register-task-definition --cli-input-json file://$(pwd)/ecs_task_definition.json

# aws ecs list-task-definitions

# aws ecs run-task --cluster default --task-definition hello-ecs --count 2

# aws ecs list-tasks --cluster default

EB_BUCKET=zari-deploy
DOCKERRUN_FILE=$SHA1-Dockerrun.aws.json
sed "s/<TAG>/$SHA1/" < Dockerrun.aws.json.template > $DOCKERRUN_FILE
aws s3 cp $DOCKERRUN_FILE s3://$EB_BUCKET/$DOCKERRUN_FILE
aws elasticbeanstalk create-application-version --application-name multiContainerDocke-env \
  --version-label $SHA1 --source-bundle S3Bucket=$EB_BUCKET,S3Key=$DOCKERRUN_FILE

# Update Elastic Beanstalk environment to new version
aws elasticbeanstalk update-environment --environment-name multiContainerDocke-env \
    --version-label $SHA1