#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0a25a19c0d44231b7"  #replace with your SG ID

for instances in $@
do 
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro --security-group-ids sg-0a25a19c0d44231b7 --tag-specifications  "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]"  --query 'Instances[0].InstanceId' --output text)

    if [ $instances != "frontend" ];then
        IP=$(aws ec2 describe-instances --instance-ids i-0701657d289653a75 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)

    else
        IP=$(aws ec2 describe-instances --instance-ids i-0701657d289653a75 --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)


    fi
    echo "$instances: $IP"

done

