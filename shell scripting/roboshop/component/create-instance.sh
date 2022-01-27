#!/bin/bash

count=$(aws ec2 describe-instance --filters "Name=tag,Values=$1" | jq ".Reservations[].Instances[].PrivateIpaddress)" | grep -v null | wc -l)
if [ $count -eq 0 ]; then
aws ec2 run-instances --image-id ami-0eb5f3f64b10d3e0e --instance-type t3.micro "Resourcetype=instance,Tags=[{key=Name,value=$1}]" | jq
else
   echo "Instance already exists"
 fi
