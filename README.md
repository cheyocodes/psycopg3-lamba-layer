# psycopg3 Lambda Layer

### Create packages for lambda layer
To create a pyscopg3 zip with the packages for your lambda layer simply execute `runner.sh`:
```sh
./runner.sh
```

### Create an S3 bucket for your lambda layer
Generate name for your s3 bucket
```sh
export LAMBDA_LAYERS_S3_BUCKET="lambda-layers-$RANDOM"
```

Create an s3 bucket 
```sh
aws s3api create-bucket \
    --bucket "$LAMBDA_LAYERS_S3_BUCKET" \
    --region us-east-1
```

### Upload to S3 
Upload `python.zip` in the `psycopg3` directory to your S3 bucket
```sh
aws s3 cp ./psycopg3/python.zip s3://$LAMBDA_LAYERS_S3_BUCKET/psycopg3/python.zip
```

### Publish the lambda layer 
```sh
aws lambda publish-layer-version \
    --layer-name "psycopg3" \
    --description "psycopg3 lambda layer" \
    --content S3Bucket=$LAMBDA_LAYERS_S3_BUCKET,S3Key=psycopg3/python.zip \
    --compatible-runtimes "python3.8" \
    --compatible-architectures "x86_64"
```