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

## Step 3: Jenkins Configuration 

1. Open ip of intstance with port 8080

2. Connect to your instnace then retrieve the initial admin password:

```shell
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
3.Install suggested plugins then create a Jenkins  account:


## Step 4: Configure Jenkins Credentials:

1. To create jenkins credentials we acess Jenkins > manage Jenkins > credentials > system > global credentials 
   get aws credentials using

```shell
Cat .aws/credentials
```

2. Generate GitHub Token:

In your GitHub account, go to Settings > Developer settings > Personal access tokens.

Generate a new token with appropriate permissions.

Then add the credentials in jenkins as the previous step

## Step 5: Configure GitHub Webhook:

In your GitHub repository, go to Settings > Webhooks > Add webhook.

1. Payload URL with the Jenkins server's public IP and port 8080.
2. Change Content type to application/json
3. Which events would you like to trigger this webhook? the you choose (send me everything)
4. "Add Webhook"


## Step 6: Configure Jenkins Pipeline

1. get ecr url from aws add it to jenkins file in the approprtiate location
2. Create a Multibranch Pipeline in Jenkins
3. Create a new pipeline for your GitHub repository.
4. Configure credentials, repository URL, and branch discovery.

## Step 7: Run the Pipeline
Commit and push changes to your GitHub repository.
Jenkins will automatically trigger the pipeline on new commits and perform the defined actions.
