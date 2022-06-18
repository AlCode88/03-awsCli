
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

[Role Based Access] (https://stackoverflow.com/questions/48087499/how-to-setup-awscli-without-setting-up-access-key-secret-access-key)

### To list the instance
- To describe isntances in the with the nice output format run
```
aws ec2 describe-instances --output table
```
- If you need the output in the special text format 
```
aws ec2 describe-instance --output text
```
- The default configuration of aws profile is located in this path
```
~/.aws/credentials
```
- The config file for aws is located in the config file
```
~/.aws/config
```
- The precedens of the command line is 
   <br> 1. Command line options
    <br> 2. Environment variables
    <br> 3. CLI configuration files

# How to read commands from Documentation
```
aws<space><typeOfService><space><help>
```
Example: aws ec2 describe-instance help

- To look for a help what you can do is type. Will provide with the all commands
```
aws iam help
```
- You can get more specific use case after you enter your actions. Example
: 
```
aws iam create-role help
```

## AWS CLI auto completion
- you need to configure auto completion feature in Linux
- the most popular shell is bash shell you can check shell by running 
```
echo $SHELLL
- you need to get result as /bin/bash
```
- Next what you can check if the aws_completer is installed
```
which aws_completer
- It should be under /usr/bin/aws_completer
```
- Next you can configure your aws_completer based on your own needs
```
complete -C '/usr/bin/aws_completer' aws
```

## AWS CLI filter output on client side (query)
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

- User query option works on the client means aws will 


## AWS CLI dry-run option
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