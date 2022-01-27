#!/bin/bash

count=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" | jq ".Reservations[].Instances[].PrivateIpaddress" | grep -v null | wc -l)
if [ $count -eq 0 ]; then
aws ec2 run-instances --image-id ami-0eb5f3f64b10d3e0e --instance-type t3.micro --security-group-ids sg-0a57500c7aa97fd16 --tag-specifications "ResourceType=instance,Tags=[{key=Name,value=$1}]" | jq
else
   echo "Instance already exists"
 fi
