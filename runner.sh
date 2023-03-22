#! /usr/bin/bash

container_name="lambda_docker"
docker_image="aws_lambda_builder_image"
artifact_directory="psycopg3"

echo $container_name
echo $docker_image

# Builds a Docker image with the specified parameters.
docker buildx build -t $docker_image --platform "linux/x86_64" .

# Runs the Docker container with the specified parameters.
docker run --rm -td --name=$container_name $docker_image

# Copies the 'requirements.txt' file to the specified Docker container.
docker cp ./requirements.txt $container_name:/

# Executes a Bash script in the specified Docker container.
docker exec -i $container_name /bin/bash < ./docker_install.sh 

# Copies the 'python.zip' file from the specified Docker container to the current directory.
docker cp $container_name:/python.zip python.zip

# Stops the specified Docker container.
docker stop $container_name

echo "removing image..."

sleep 5

# Removes the specified Docker image.
docker image rm $docker_image:latest

echo "creating artifacts..."

sleep 3

# creates a directory and moves the python.zip artifact in there
mkdir $artifact_directory
mv python.zip $artifact_directory
