#!/bin/bash

 count=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" | jq ".Reservations[].Instances[].PrivateIpAddress" | grep -v null | wc -l)

 if [ $1 -eq 0 ]; then
   aws ec2 run-instances --image-id ami-04656078adf4aa403 --instance-type t3.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$1}]" | jq
   else
     echo "Instance already exists"

fi
