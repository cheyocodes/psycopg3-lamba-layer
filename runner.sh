#! /bin/bash

function runner {
  local container_name="lambda_docker"
  local docker_image="aws_lambda_builder_image"

  echo $container_name
  echo $docker_image

  docker buildx build -t $docker_image --platform "linux/x86_64" .

  docker run --rm -td --name=$container_name $docker_image
  docker cp ./requirements.txt $container_name:/

  docker exec -i $container_name /bin/bash < ./docker_install.sh 
  docker cp $container_name:/python.zip python.zip
  docker stop $container_name
  
  sleep 5
  
  docker image rm $docker_image:latest

  sleep 3

  mkdir psycopg3
  mv python.zip psycopg3
}

runner