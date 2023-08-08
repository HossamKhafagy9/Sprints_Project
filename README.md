# Sprints_Project
Sprints Final Project
# Setting up Jenkins with Terraform, Ansible, AWS, and GitHub

This guide outlines the steps to set up Jenkins for continuous integration and deployment using Terraform, Ansible, AWS, and GitHub. Follow these instructions to get your environment up and running.

After cloning the repo

## Step 1: Infrastructure Setup

1. Initialize Terraform:
```shell
terraform init
```
2. Plan and review the infrastructure changes:
 
```shell
terraform plan
```
3. Apply the infrastructure changes:
   
```shell
terraform apply
```
## Step 2: Install Tools

1. Run Ansible playbook to install Docker, AWS CLI, Kubernetes tools, and Jenkins:
   change the inventory file with the ip of your instance and add the key
   
```shell
ansible-playbook -i inventory docker.yml
```
```shell
ansible-playbook -i inventory awscli.yml
```
```shell
ansible-playbook -i inventory kubectl.yml
```
```shell
ansible-playbook -i inventory jenkins.yml
```
Run Ansible playbook to install Jenkins:

## Step 3: Jenkins Configuration 

1. Open <IP of instnace:8080>

2. Connect to your instnace then retrieve the initial admin password:

```shell
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
3.Install suggested plugins then create a Jenkins  account:


## Step 4: Configure AWS ECR:

Log in to AWS and retrieve the ECR repository URL.
Manage Jenkins Credentials:

Go to Manage Jenkins > Manage Credentials > Global Credentials.
Add your AWS credentials: use cat .aws/credentials to get the details.
Generate GitHub Token:

In your GitHub account, go to Settings > Developer settings > Personal access tokens.
Generate a new token with appropriate permissions.
Configure GitHub Webhook:

In your GitHub repository, go to Settings > Webhooks.
Add a new webhook with the Jenkins server's public IP and port 8080.
Step 4: Configure Jenkins Pipeline
Create a Multibranch Pipeline in Jenkins:

Access Jenkins via the web browser.
Create a new pipeline for your GitHub repository.
Configure credentials, repository URL, and branch discovery.
Build Configuration:

Customize the pipeline configuration based on your requirements.
Step 5: Run the Pipeline
Commit and push changes to your GitHub repository.
Jenkins will automatically trigger the pipeline on new commits and perform the defined actions.
