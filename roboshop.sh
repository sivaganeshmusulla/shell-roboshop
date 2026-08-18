#!/bin/bash

SG_ID="sg-0139ab60908a92954"

AMI_ID="ami-0220d79f3f480ecf5"


for instance in $@

do
    IINSTANC_ID=$( aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro --security-group-ids $SG_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text )
    if [ $instance == "frontend" ]; then
        IP=$(
            aws ec2 describe-instances --instance-ids $IINSTANC_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text
        )
    else
        IP=$(
            aws ec2 describe-instances --instance-ids $IINSTANC_ID --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text
        )
    fi

    echo "IP address : $IP"
done