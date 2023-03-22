#! /bin/bash

container_name="lambda_docker"
docker_image="aws_lambda_builder_image"
artifact_directory="psycopg3"

echo $container_name
echo $docker_image

docker buildx build -t $docker_image --platform "linux/x86_64" .

docker run --rm -td --name=$container_name $docker_image
docker cp ./requirements.txt $container_name:/

docker exec -i $container_name /bin/bash < ./docker_install.sh 
docker cp $container_name:/python.zip python.zip
docker stop $container_name

echo "removing image..."
sleep 5

docker image rm $docker_image:latest

echo "creating artifacts..."
sleep 3
mkdir $artifact_directory
mv python.zip $artifact_directory