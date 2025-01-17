#!/usr/bin/env bash

for bucket in $(aws s3api list-buckets --query "Buckets[].Name" --output text); do
  echo "Bucket: $bucket"
  aws s3api list-objects --bucket $bucket --output json --query "[sum(Contents[].Size)]" | jq '.[]'
done

