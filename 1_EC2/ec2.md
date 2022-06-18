# AWS EC2 Command line

### Create a KeyPair
- First what we need to do is to create a private key for our isntance
```
aws ec2 create-key-pair --key-name tb-cli-test > key.txt
```
This will generate a private key and output into a file called key.txt
