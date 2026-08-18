#! /bin/bash

SG_ID="sg-0139ab60908a92954"

AMI_ID="ami-0220d79f3f480ecf5"


for instance in $@

do

        instance_id = $(aws ec2 run-instances \

        --image-id $AMI_ID \

        --instance-type "t3.micro" \

        --security-group-ids $SG_ID \

        "ResourceType=instance,Tags=[{Key=Name, Value=$instance}]" \ --tag-specifications

        --query 'Instances [0]. InstanceId' \

        --output text )

        if [ $instance == "frontend" ]; then

        IP=$(

        aws ec2 describe-instances \

        --instance-ids $instance_id \

        --query 'Reservations []. Instances [].PublicIpAddress' \

        --output text
        
        )

        else

            IP=$(

            aws ec2 describe-instances \

            --instance-ids $instance_id \

            --query 'Reservations []. Instances [].Private IpAddress' \

            --output text
            )

        fi

done