Authentication and Authorization to AWS resources
=================================================

AWS Authentication
--------
Before creating resources, you need to configure AWS credentials for Terraform to authenticate with AWS APIs.

Authentication Methods
-----------
AWS CLI Configuration: aws configure
Environment Variables: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
IAM Roles: For EC2 instances or AWS services
AWS Profiles: Named credential profiles

Authentication Setup
-------
Method 1: AWS CLI Configuration
--------
aws configure
Enter your:

AWS Access Key ID
AWS Secret Access Key
Default region (e.g., us-east-1)
Default output format (json)

Method 2: Environment Variables
-------
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
