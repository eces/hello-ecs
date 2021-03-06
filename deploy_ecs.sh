#! /bin/bash

SHA1=$1

# docker push quay.io/eces/hello-ecs
docker push quay.io/yellotravel/zari

aws ecs register-task-definition --cli-input-json file://$(pwd)/ecs_task_definition.json
# aws ecs run-task --cluster default --task-definition zari-task --count 1
aws ecs update-service --cluster default --service zari-app --task-definition zari-task --desired-count 1
# aws ecs list-services --cluster default
# aws ecs list-task-definitions


# 


# EB_BUCKET=zari-deploy
# DOCKERRUN_FILE=$SHA1-Dockerrun.aws.json
# sed "s/<TAG>/$SHA1/" < Dockerrun.aws.json.template > $DOCKERRUN_FILE
# aws s3 cp $DOCKERRUN_FILE s3://$EB_BUCKET/$DOCKERRUN_FILE
# aws elasticbeanstalk create-application-version --application-name zari \
#   --version-label $SHA1 --source-bundle S3Bucket=$EB_BUCKET,S3Key=$DOCKERRUN_FILE

# # Update Elastic Beanstalk environment to new version
# aws elasticbeanstalk update-environment --environment-name zari-env \
#     --version-label $SHA1