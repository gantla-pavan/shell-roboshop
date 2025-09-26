#!/bin/bash
AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0f08420df1833f423" 

for instance in $@
do 
    INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID--instance-type t3.micro --security-group-ids $SGI_ID --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstancesId' --output text)

    if [ $instance != "frontend" ];then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)

    else
         IP=$(aws ec2 describe-instances --instance-ids $INSTANCE-ID--query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
    fi
    echo "$instance: $IP"
done
