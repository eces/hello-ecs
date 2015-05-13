#! /bin/bash

SHA1=$1

aws ecs register-task-definition --cli-input-json file://$(pwd)/ecs_task_definition.json

aws ecs list-task-definitions

aws ecs run-task --cluster default --task-definition hello-ecs:5 --count 2

aws ecs list-tasks --cluster default