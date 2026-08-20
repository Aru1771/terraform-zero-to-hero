Day 4: State File Management - Remote Backend
===============================================

How Terraform Updates Infrastructure
-------------------------------------

Goal: Keep actual state same as desired state
State File: Actual state resides in terraform.tfstate file
Process: Terraform compares current state with desired configuration
Updates: Only changes the resources that need modification

Terraform State File
-----------------------
The state file is a JSON file that contains:

Resource metadata and current configuration
Resource dependencies
Provider information
Resource attribute values

State File Best Practices
-----------------------------
Never edit state file manually
Store state file remotely (not in local file system)
Enable state locking to prevent concurrent modifications
Backup state files regularly
Use separate state files for different environments
Restrict access to state files (contains sensitive data)
Encrypt state files at rest and in transit

What is S3 Native State Locking?
---------------------------------
When Terraform needs to acquire a lock, it attempts to create a lock file in S3
S3 conditional writes check if the lock file already exists
If the lock file exists, the write operation fails, preventing concurrent modifications
If the lock file doesn't exist, it's created successfully and the lock is acquired
When the operation completes, the lock file is deleted (appears as a delete marker with versioning)


terraform {
  backend "s3" {
    bucket       = "your-terraform-state-bucket"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}


Common Issues
--------------

State Lock Error: If terraform process crashes, the lock file may remain. Manually delete it from S3 or use: terraform force-unlock <lock-id>
Permission Errors: Ensure proper IAM permissions for S3 operations
Versioning Not Enabled: S3 versioning MUST be enabled for native state locking to work
Region Mismatch: Backend region should match your provider region
Bucket Names: S3 bucket names must be globally unique
Terraform Version: Requires Terraform 1.10+ for S3 native locking; 1.11+ recommended for stable GA release
