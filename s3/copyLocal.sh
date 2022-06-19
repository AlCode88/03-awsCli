#!/bin/bash
# You can set the cron job to copy this file everyday
# crontab -e        ====> To schedule a cron job for you files
# 
#
aws s3 sync /home/ec2-user/awsCli/Documents/ s3://test-talant-bucket

# */1 * * * * /home/ec2-user/copyLocal.sh if you want to execute it every minute of the single day
# /home/ec2-user/awsCli/s3
# To disable the cron job you can run the same command and delete the line of the time