
# AWS Cli

######################## Part 1 Configuration ################################
## Prerequestites 
1. You need to create a User with the necessary permissions
2. Get the access key and secret keys (Important: Do not push your keys to gitHub and keep them in safe place)

## To Install AwsCli for Mac and Linux
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```
## To update your existing CLI version to latest one run
```
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
```
## To upgrade your aws cli run:
```
sudo pip install awscli --upgrade
```

## To setup your Profile
```
 aws configure
 ```

## AWS Setup

	1. AWS Access Key ID    ======> your Access Key ID
	2. AWS Secret Access Key =====> your Secret Access Key ID
	3. Default Region Name =======> us-east-1
	4. Format json         =======> json            (that is the default format name) but you can choose the below formats

## AWS Output
	1. JSON(default)
	2. Text
	3. Table
  
## AWS Role for using AWS CLI
1. Create a role with necessary permissions
2. Create an Instance with the specified role above
3. Install aws cli
4. Run `aws configure` and leave access key and secret key with empty blank

[Roles Based Access Setup](https://stackoverflow.com/questions/48087499/how-to-setup-awscli-without-setting-up-access-key-secret-access-key)

## AWS CLI auto completion
- You need to configure auto completion feature which is available only for Unix Like OS
- The most popular shell is bash shell you can check shell by running 
```
echo $SHELLL
- you need to get result as /bin/bash
```
1. Next what you can check if the aws_completer is installed and find the path
```
which aws_completer
- It should be under /usr/bin/aws_completer
```
2. Enabling of AWS AutoCompleter 
```
complete -C '/usr/bin/aws_completer' aws
```
[Docs Auto Completer](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-linux)

## Setup Multiple Profiles
- What if you have a different account for different purpose?
- Profiles comes handy when you want to use different IAM users permissions or differen role
```
aws configure --profile <anyProfileName>
```
- To access your profile you need to always specify your profile name
```
aws ec2 describe-instances --profile <yourProfileName>
```
- To read all the existing profiles
```
cat ~/.aws/config
```
### To set Different Region for your Profile
- What if you want to use different region for new profile or you want to update your existing profile?
- This command will update your existing profile with a new region or will create a new profile 
```
aws configure set region us-east-2 --profile <profileName>
```
### To get the access keys you can run the following command
- Sometimes you want ot perform some operations or check your access Keys
```
aws configure get aws_access_key_id --profile <profileName>
```

[Setup Additional Profiles Documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)

# How to read commands from Documentation
```
aws<space><typeOfService><space><help>
```
Example: aws ec2 describe-instance help

- To look for a help what you can do is type help. Will provide with the all commands
```
aws iam help
```
- You can get more specific use case after you enter your actions. Example
: 
```
aws iam create-role help
```

# AWS Configuration Location

- The default configuration of aws profile is located in this path
```
~/.aws/credentials
```
- The config file for aws is located in the config file
```
~/.aws/config
```
 ### The precedens of the command line is 
  <br> 1. Command line options
  <br> 2. Environment variables
  <br> 3. CLI configuration files

# AWS CLI filter output on client side (query) with query

- You can filter on the server side wich is more efficient than filtering on the 
client side and much faster but if faster response time is not our consideration than we must use query option
- query will procide more robust and detailed view ot aws services than filtering but much more slower than filter
- There are two types of filtering 
    1. filter
    2. query

- You can apply filters to your aws instance and filter option is only supported with describe and list commands and not available with all aws commands
Example; 
```
aws ec2 describe-instances --filter Name=instance-type,Values=t2.micro
- will list all the instance with t2.micro
```
- To Describe instances run:
```
aws ec2 describe-instances --query "Reservations[*].Instances[*].{Instances:InstanceId,AvailabilityZone:Placement.AvailabilityZone,PubIP:PublicIpAddress,SubnetIds:SubnetId,VpcIds:VpcId,InstanceType:InstanceType}" --output table
```
- This command lists all the instances information based on your needs
```
aws ec2 describe-instances --query "Reservations[*].Instances[*].{InstanceId:InstanceId,AvailabilityZone:Placement.AvailabilityZone,PubIP:PublicIpAddress,SubnetIds:SubnetId,VpcIds:VpcId,InstanceType:InstanceType,EC2Name:Tags[?Key=='Name']|[0].Value}" --output table
```
- To Describe Security Groups Run
```
aws ec2 describe-security-groups --query "SecurityGroups[*].{SGName:GroupName,SGId:GroupId}" --output table
```
- To describe ec2 instance 
```
aws ec2 describe-instances --filters Name=tag-key,Values=Name --query "Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key=='Name']|[0].Value}" --output table

aws ec2 describe-instances --filters 
```
- To List all isntance Names and Instances Ids run
```
aws ec2 describe-instances --query "Reservations[*].Instances[*].{InstanceIds:InstanceId,Name:Tags[?Key=='Name']|[0].Value}" --output table

aws ec2 describe-instances --query "Reservations[*].Instances[*].{InstanceIds:InstanceId,KeyName:KeyName,AMI:ImageId,SG:SecurityGroups[1],Name:Tags[?Key=='Name']|[0].Value}" --query "SecurityGroups[*].{SGName:GroupName,SGId:GroupId}" --output table
```


# AWS CLI dry-run option
- Testing Permission - Dry Run option
- Good to get an extra information about command that you would like to execute Example:
```
aws ec2 describe-regions --dry-run
- An error occurred (DryRunOperation) when calling the DescribeRegions operation: Request would have succeeded, but DryRun flag is set.
- meaning the command will succeed but the dry run option is set but you do have a permissions to run this command and good thing is you executed without actually executing
```
## Intro to JMESPath terminal

- Helps you more efficiently visualize Json format 

- To Install JamesPath terminal
```
sudo pip3 install jmespath-terminal -y
```
- How to execute jmespath-terminal: 
```
aws ec2 describe-regions | jpterm
```
- You will get  a nice visual output


Note:
- You can apply the same query in the cli as well Example: 
```
aws ec2 describe-instances --query 'Reservations[].Instances[].PublicIpAddress[]'
```
- What you can do as well is to grep PublicIPAddresses as well
```
aws ec2 describe-instances --query 'Reservations[].Instances[]' | grep PublicIpAddress
```
# S3 Bucket
################## S3 Resource ####################################
- To work with any resource in AWS 
```
aws<space><typeOfService><space><help>
```

- To list all you buckets run the following command
```
aws s3 ls
```
- To create a new bucket run
```
aws mb s3://bucketName
```
- To list all the files inside s3 bucket
```
aws s3 ls s3://bucketName
```
- To copy file to S3 bucket run:
```
aws s3 cp LocalfileName s3://bucketName
```
- To download files from s3 run:
```
aws s3 cp s3://bucketName/fileName (path or . current dirr)
```
- To copy all the files from local to s3 run:
```
aws s3 sync pathinlocal s3://bucketName

Example: aws s3 sync . s3://test-talant-bucket

```
- To copy files to Storage classes
```
aws s3 sync . s3://bucketName/path --storage-class STANDARD_IA
```
- To exclude some files from copying you can run:
```
aws s3 sync . s3://bucketName/path --storage-class STANDARD_IA --exclude '*.sh' --acl public-read
```
### Encryption of files using Default Encryption
- Encrypt file with SSE-S3 you can specify --sse option
	- Amazon manages the Master key 
	- We do not have a choice to choose a Master key
```
aws s3 cp Documents/file3.txt s3://test-talant-bucket --sse AES256
```

### Encryption of files using KMS service
- To Encrypt S3 bucket files with kms keys run:
```
aws s3 cp Documents/file3.txt s3://test-talant-bucket --sse aws:kms --sse-kms-key-id PasteYourKMSKeyId
```

### Create a KMS keys
- NOTE: Each key will cost you dollar per month
- You can not use different keys from different services no corss key usages

- To create a kms keys run: 
```
aws kms create-key --tags TagKey=Name,TagValue=awsCliTest --description "This is kms test keys"

if you run aws kms-list it will be hard to read the file for you, you can create Aliases instead
```
- To creae an Alias you can run  the following command
```
aws kms create-alias --alias-name alias/YourKeyName --target-key-id 5a0cbb42-90f2-40e1-b8b6-5f914e9b7507(KeyId)
```
- To list aliases run:
```
aws kms list-aliases          =====> our example alias alias/awscli-test
```
- To list all aliases with KMS key Id run:
```
aws kms list-aliases | grep 'awscli-test \| TargetKeyId'
```
### SSE-C You 
- You can not create server side encryption with console nor read it
- The key provider should not be base64 encoded
- We will use options `--sse c` and `--sse c key`

- To generate your own keys you can use Open SSL software and run to generate 128 bit keys we need a key part: 
```
openssl enc -aes-128-cbc -k secret -P
```
- To encrypt file with your own custom keys you run:
```
aws s3 cp Documents/file3.txt s3://test-talant-bucket --sse-c --sse-c-key generatedKey
```
- To download the file from S3 bucket you need to provide your custom keys otherwise you will get an error
```
aws s3 cp s3://test-talant-bucket/file3.txt .
fatal error: An error occurred (400) when calling the HeadObject operation: Bad Request

Run this command:
aws s3 cp s3://test-talant-bucket/file3.txt (path) --sse-c --sse-c-key generatedKeyName
```
### Encryp the whole S3 Bucket
#### KMS
- To Encrypt whole bucket with kms keys you have to specify json policy document first
- Create a .json file with your account id and kms key id
```
{
    "Rules": [
      {
        "ApplyServerSideEncryptionByDefault": {
          "SSEAlgorithm": "aws:kms",
          "KMSMasterKeyID": "arn:aws:kms:us-east-1:PutYourAWSAccountId:key/yourKMSKeyId"
        }
      }
    ]
  }
```
- To Encrypt whole bucket with the kms key run:
```
aws s3api put-bucket-encryption --bucket --bucket new-talant-bucket --server-side-encryption-configuration file://s3/bucket.json
```

#### AES256 S3 default encryption
- Create a file with .json document with the following json document
```
{
  "Rules": [
    {
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }

  ]
}
```
- Run the following command 
```
aws s3api put-bucket-encryption --bucket new-talant-bucket --server-side-encryption-configuration file://s3/aes256.json
```
[Link to Encryption Doc](https://docs.aws.amazon.com/cli/latest/reference/s3api/put-bucket-encryption.html)

## Multipart upload
#### Steps
- Break the files into many pieces
- Initiate Multipart Upload
- Upload individual parts
- Complete Multipar uploads

1. Locate the file that needs to be uploaded
2. run `split -b 10M fileName` command
3. If you list the content of the folder, you should get chunked fiels like `xaa  xab  xac  xad  xae  xaf  xag  xah` and each files is in the size of that you have specified
4. Initiate Multipart Upload `aws s3api create-multipart-upload --bucket NameOftheBucket --key video.mp4`(can be any name for the key) and you should get response with Bucket: , UploadId(Make a note), Key:
5. Upload your parts
```
aws s3api upload-part --bucket YourBucketName --key vide.mp4 --part-number 1(needsToBeModifiedWithFile#) --body xaa --upload-id a3LonUf_grTvPPzHAr5Yqn5nln.8z1Tsf46KEkCGii5Y6z18iF.xYJEVwCBFybdjUMZ9SL92FZ_Wn.oH0n.G45.0BKft5uzRQcq9icjMvHO9Tb6yLBuVZ59vhtN5v6nR(yourUniqueUploadID)
```
7. You can list the files with the following command
```
aws s3api list-parts --bucket yourBucketName --key yourKey --upload-id yourUniqueUploadId
```
8. To complete the multipart upload you need to creaete a json file with Etag and PartNumber
```
{
 "Parts": [
        {
            "PartNumber": 1,
            "ETag": "\"68475ba5402f8d10b5f023123d1d3aed\""
        },
        {
            "PartNumber": 2,
            "ETag": "\"2d6ff177048e5d54cb667b239acc45d3\""
        },
        {
            "PartNumber": 3,
            "ETag": "\"aad2b0f6aa7e75ff1bee7dcdf71c0a24\""
        },
        {
            "PartNumber": 4,
            "ETag": "\"f4730547f453ea13f184918946a7f7bf\""
        },
        {
            "PartNumber": 5,
            "ETag": "\"a9f7e32b51ba75fd12e39ec08535c68b\""
        },
        {
            "PartNumber": 6,
            "ETag": "\"049ff1b5eecfb483f49890c1c74d8fbf\""
        },
        {
            "PartNumber": 7,
            "ETag": "\"b4c4ed7b14e64d3af3d3153e71bb1555\""
        },
        {
            "PartNumber": 8,
            "ETag": "\"47742569fbb7a0654c66a2d51e826a4d\""
        }
    ]
}
```
9. You need to run finall command 
```
aws s3api complete-multipart-upload --multipart-upload file://JsonFileName.json --bucket BucketName --key YourUniqueKeyId upload-id yourUniqueUploadId
```
10. Note: The upload Id will be deleted after completion Sometimes it is easiear to achieve this with command line interface

## Cross Account S3 Bucket access using bucket policy and aws cli
### Prerequesites
1. We need two accounts Account A and Account B
2. Create S3 bucket in AccountA and add some items
3. In the Account A enter this policy in the bucket policy section. Principal part will determine who will be accessing this files. So you need to type another account id in the AnotherAccountId
```
{
    "Version":"2012-10-17",
    "Statement":[
        {
            "Sid":"CrossAccountPermission",
            "Effect":"Allow",
            "Principal":{
                "AWS":"arn:aws:iam::AccountBAWSAccountID:root"      #GetAccountB Account Id
            },
            "Action":"s3:*",                                    #MeansYouCanPerformAnyActionsOnS3
            "Resource":[
                "arn:aws::s3:::AccountABucketName",               #PathToBucket
                "arn:aws::s3:::AccountABucketName/*"
            ]
        }
    ]
}
```
4. Now from AccountB try to list the buckets in AccountA
```
aws s3 ls s3://AccountABucketName
```
5. You can copy file from accountA bucket to your accountB 
``` 
aws s3 cp s3://AccountABucketName/fileName.jpg ~/Downloads/
```
6. You can add multiple statements in your bucket policy. Like this one you can list but can not download the file. You should get permission denied 403 error
```
{
    "Version":"2012-10-17",
    "Statement":[
        {
            "Sid":"CrossAccountPermission",
            "Effect":"Allow",
            "Principal":{
                "AWS":"arn:aws:iam::YourAccountId:root"
            },
            "Action":"s3:*",
            "Resource":[
                "arn:aws::s3:::NameOfyourBucket",
                "arn:aws::s3:::NameOfyourBucket/*"
            ]
        },
        {
            "Sid":"DenyPermission",
            "Effect":"Deny",
            "Principal":{
                "AWS":"arn:aws:iam::YourAccountId:root"
            },
            "Action":"s3:GetObject",                              #Do not allow to Download staff
            "Resource":"arn:aws::s3:::NameOfyourBucket/*"
        }
    ]
}
```
## Generate Pre-Signed URL with aws Cli
- Will allow anyone to recieve pre-signed url to retrieve the object.
- The default Valid URL is 3600s (1hr)
- To generate pre-signed url run:
```
aws s3 presign s3://YouBucketname/objectName.txt
```
- To set the expiration time for Pre-signed URL use `--expires-in` flag:
```
aws s3 presign s3://YouBucketname/objectName.txt --expires-in 30
```

# EC2 
####################################### EC2 Resource ############################################ 
## To list the instance
- List Ubuntu images
```
aws ec2 describe-images --filters 'Name=name,Values=*Ubuntu*' --query 'Images[*].[ImageId , Description]'
```
- To describe isntances in the with the nice output format run
```
aws ec2 describe-instances --output table
```
- If you need the output in the special text format 
```
aws ec2 describe-instance --output text
```
- To create a key pair and output that file to pem file run:
```
aws ec2 create-key-pair --key-name YourKeyName --query 'KeyMaterial' --output text > myKey.pem

Make sure to run: chmod 400 YourKeyName file
```
- Create an instance run:
```
aws ec2 run-instances --image-id ami-Id --instance-type t2.micro --key-name yourKeyName
```
- Create an instance with Security group and specific subnet
```
aws ec2 run-instances --image-id ami-8c1be5f6 --instance-type t2.micro --key-name MyKeyPair --security-group-ids sg-beb3eacc --subnet-id subnet-ed36c3c2
```
- To modify Security Groups
```
aws ec2 authorize-security-group-ingress --group-id sg-814134f2 --protocol tcp --port 22 --cidr 0.0.0.0/0
```
- Terminate Multiple instance at once
```
aws ec2 terminate-instances --instance-ids i-0b20d7680fa0e6ba0  i-00251da28fa34ffd1
```
- To create a snapshot
```
aws ec2 create-snapshot --volume-id vol-1234567890abcdef0 --description "This is my root volume snapshot."                =====> Have your Root volume id
```
- This example command creates an 10 GiB General Purpose (SSD) volume in the Availability Zone us-east-1a
```
aws ec2 create-volume --size 10 --region us-east-1 --availability-zone us-east-1a --volume-type gp2
```
- To attach volume to instance
```
aws ec2 attach-volume --volume-id vol-1234567890abcdef0 --instance-id i-01474ef662b89480 --device /dev/sdf
```
- To detach volume from instance
```
aws ec2 detach-volume --volume-id vol-1234567890abcdef0
```
- 

# VPC
############################ VPC ###################################################
- To create VPC
```
aws ec2 create-vpc --cidr-block 10.0.0.0/16
```
- Tag VPC
```
aws ec2 create-tags --resources yourVPCid --tags Key=Name,Value=YourVpcName
```
- To Create a public Subnet
```
aws ec2 create-subnet --vpc-id vpc-d363afab --cidr-block 10.0.1.0/24
```
- Tag the public subnet
```
aws ec2 create-tags --resources subnet-7314ad17 --tags Key=Name,Value=CLI-Public-Subnet
```
- Create a private Subnet
```
aws ec2 create-subnet --vpc-id vpc-d363afab --cidr-block 10.0.2.0/24
```
- Tag the private subnet 
```
aws ec2 create-tags --resources subnet-4109b025 --tags Key=Name,Value=CLI-Private-Subnet
```
- Create Internet Gateway
```
aws ec2 create-internet-gateway=
```
- Tag Internet Gateway
```
aws ec2 create-tags --resources igw-afdd01d6 --tags Key=Name,Value=CLI-Internet-Gateway
```
- Attach Internet Gateway
```
aws ec2 attach-internet-gateway --internet-gateway-id igw-5d685a38 --vpc-id vpc-d363afab
```
- Allocate Elastic IP
```
aws ec2 allocate-address --domain vpc
```
- Create Nat Gateway
```
aws ec2 create-nat-gateway --subnet-id subnet-1a2b3c4d --allocation-id eipalloc-37fc1a52
#
Tag
#
aws ec2 create-tags --resources nat-0e4d97e539eadf232 --tags Key=Name,Value=CLI-Nat-Gateway
```
- Create Route Table 1 for Public Subnet
```
aws ec2 create-route-table --vpc-id vpc-d363afab 
#
Tag
#
aws ec2 create-tags --resources rtb-14c3736e --tags Key=Name,Value=CLI-PUBLIC_RT
```
- Create Route Table 2 for Private Subnets:
```
aws ec2 create-route-table --vpc-id vpc-d363afab 

#Tag:

aws ec2 create-tags --resources rtb-cbc070b1 --tags Key=Name,Value=CLI-PRIVATE_RT
```
- Create Route Table Internet in Route Table 1: 
```
aws ec2 create-route --route-table-id rtb-14c3736e --destination-cidr-block 0.0.0.0/0 --gateway-id igw-afdd01d6
```
- Create Route table to internet via Nat
```
aws ec2 create-route --route-table-id rtb-cbc070b1 --destination-cidr-block 0.0.0.0/0 -- gateway-id nat-0e4d97e539eadf232
```
- Associate Route Table 1 to PublicSubnet:
```
aws ec2 associate-route-table --route-table-id rtb-14c3736e --subnet-id subnet-7314ad17
```
- Associate Route Table with Private Subnet
```
aws ec2 associate-route-table --route-table-id rtb-1245623e --subnet-id subnet-234567as
```
- Create Security Group inside your cusotm VPC
```
aws	ec2	create-security-group --group-name CLI-WEB-SecurityGroup --description	"Mysecurity group" --vpc-id vpc-d363afab
#
Tag:
#
aws ec2 create-tags --resources sg-03ca1371 --tags Key=Name,Value=CLI_SECURITY_GROUP

Add Ingress Port 22 and 80:
```
- Create a key pair 
```
aws ec2 create-key-pair --key-name MyKeyPairCLI
```
- Give proper permission to your keys chmod 400
```
chmod 400 MyKeyPairCli.pem
```
- Create Instance with AMI in vpc
```
aws ec2 run-instances --image-id ami-8c1be5f6 --count 1 --instance-type t2.micro --key- name MyKeyPairCLI --security-group-ids sg-c3ed34b1 --subnet-id subnet-7314ad17 --associate-public-ip-address
```
- Tag your Isntance
```
aws ec2 create-tags --resources i-05c8b15394d0905b8 --tags Key=Name,Value=CLI_EC2
```
- Describe instance to Get Pub ip 
```
aws ec2 describe-instances
```
- ssh to your Created Instance
```
ssh ec2-user@pubip -i MyKeyPair.pem
```

# Lambda Function with AWS Cli
################################################# Lambda Function ##################################################################

- Lambda Function is one of the greatest and mostly used services in aws
- To run our Lambda function we need to create a role for our Lambda with the name lambdaRole.json:
```
{
    "Version":"2012-10-17",
    "Statement": {
        "Effect":"Allow",
        "Principal":{"Service":"lambda.amazonaws.com"},
        "Action":"sts:AssumeRole"
    }
}
```
- To create a role run the following aws command: 
```
aws iam create-role --role-name lambda-test-role --assume-role-policy-document file://lambda/lambdaRole.json
```
- To list created role you can run
```
aws iam list-roles
```
- To list policies you need to run:
```
aws iam list-policies | grep EC2Full

or

aws iam list-policies | grep S3Read
```
- To attach role to lambda function run:
```
aws iam attach-role-policy --role-name lambdaTest --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess
```
- Now we need to create a zip file for our code:
```
zip -r zipFileName fileName.py
```
- Create a function
```
aws lambda create-function --function-name lambdaTest --runtime python3.7 --role arn:aws:iam::775359975843:role/lambdaTest --handler lambda.lambda_handler --zip-file fileb://lambda/lambdatest.zip
```
- To invoke Lambda function run:
```
aws lambda invoke --invocation-type Event --function-name lambdaTest output.txt
```


# IAM
############################################### IAM ##################################################################
- To creare an IAM user
```
aws iam create-user --user-name testUser
```
- To create an access key for specific user
```
aws iam create-access-key --user-name testUser
```
- You can configure new user with different profile
```
aws configure --profile testProfile
```
- To perform some kind of action with newly created profile
```
aws s3 ls --profile testProfile
```
- To list available policies run:
```
aws iam list-policies | grep AdministratorAccess

 aws iam list-policies | grep S3Full
```
- In order your user to have some permissions you need to attach a policy:
```
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --user-name testUser
```
- To test it now you can run the cli command with --profile:
```
aws s3 ls --profile testProfile
```
- To delete the user you need to detach policy first: 
```
aws iam detach-user-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --user-name testUser
```
- You need to get access keys first to delete user:
```
aws configure get aws_access_key_id --profile testProfile
```
- Now we can delete user
```
aws iam delete-access-key --user-name testUser --access-key-id yourAccessKey                         # Delete your profiles Access Key Ids
```
- To delete user run:
```
aws iam delete-user --user-name testUser
```
- To confirm that user has been deleted run:
```
aws iam list-users
```

# Create a role EC2 with Instance Profile
########################################### Instance profile ######################################################################################################


- To attach a role to your Instance you need to create an Instance Profile. Create a json document Example profile.json. So EC2 will perform Actions on your behalf:
```
{
    "Version":"2012-10-17",
    "Statement": {
        "Effect":"Allow",
        "Principal":{"Service":"ec2.amazonaws.com"},
        "Action":"sts:AssumeRole"
    }
}
```
- To create a role with existing json trust policy run:
```
aws iam create-role --role-name ec2_S3_access --assume-role-policy-document file://1_EC2/assumeRole.json
```
- To list all available policies you can run:
```
aws iam attach-role-policy --role-name ec2_S3_access --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
```
- Create an	Instance Profile required to contain the role:
```
aws iam create-instance-profile --instance-profile-name EC2-EC2-full-access
```
- Attach the role to the instance profile run:
```
aws iam add-role-to-instance-profile --instance-profile-name EC2-EC2-full-access --role-name EC2AdminCli
```
- Launch EC2 instance with the role:
```
aws ec2 run-instances --image-id ami-6057e21a --instance-type t2.micro --iam-instance-profile Name=EC2-EC2-full-access
```

################################################ AWS CLOUDFORMATION ##############################################################
# AWS CloudFormation
###
- CF is a service that gives developers and buisnesses an easy way to create a collection of related AWS resources and provision them in an orderly and predictable fashion

### What new concepts does AWS CloudFormation introduce?
- AWS CF introduce two conecpts:
    1. Template - a JSON or YAML-format, text-based file that describes all the AWS resources you need to deploy to run you application.
    2. Stack - the set of AWS resources that are created and managed as a single unit when AWS CF instantiates template

- If all resources is not created properly a **rollback** occurs and all the resources are deleted
- If a succesful stack is deleted, all resources are deleted

- We have defined our vpc.yml file in local path
```
AWSTemplateFormatVersion: "2010-09-09"
Description: A sample template
Parameters:
  Cidr:
    Description: Specify CIDR Range
    Type: String
    Default: 10.0.0.0/16             #You can test it without setting default cidr and by specifyig cidr in parameter example
Resources:
  Vpc:
    Type: AWS::EC2::VPC
    Properties:
      CidrBlock: !Ref Cidr
      EnableDnsSupport: true
```

- To deploy CF from your local machine run: 
```
aws cloudformation create-stack --stack-name teststack --template-body file://vpc.yml
```
- To describe stacks 
```
aws cloudformation describe-stacks
```
- To deploy stack with specifying parameters run:
```
aws cloudformation create-stack --stack-name teststack-param-stack --template-body file://vpc_params.yml --parameters ParameterKey=Cidr,ParameterValue=10.0.0.0/16
```
- To upload your file from S3 run:
```
aws cloudformation deploy --stack-name testStack --template-file vpc.yml --s3-bucket cloudformation-test-talant-oreally
```
- To delete stack run: 
```
aws cloudformation delete-stack --stack-name testStack
```
- To update your stack run:
```
aws cloudformation update-stack --stack-name teststack-param-stack --templatbody file://vpc_params.yml --parameters ParameterKey=cidr,ParameterValue=10.0.0.0/16
```
- To delete stack run: 
```
aws cloudformation delete-stack --stack-name teststack
```