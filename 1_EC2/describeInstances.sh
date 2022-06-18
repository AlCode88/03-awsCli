#!/bin/bash
# Using the read command
#
echo -n "Please enter your service with a small latters. Example:ec2: "
read name
echo "Hello $name, welcome to my script."



if [ $name = 'ec2' ]
then
    echo "Describing ec2 instances"
    aws $name describe-instances

else [ $name = 's3' ] 
    echo 'Describing s3 bucket'
    aws $name ls
fi