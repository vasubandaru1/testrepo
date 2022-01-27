#!/bin/bash

aws ec2 run-instances --image-id ami-04656078adf4aa403 --instance-type t3.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$1}]"
