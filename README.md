# Sprints_Project - Setting up Jenkins with Terraform, Ansible, AWS, and GitHub

Welcome to the setup guide for configuring Jenkins with Terraform, Ansible, AWS, and GitHub. This guide provides step-by-step instructions to establish an environment for continuous integration and deployment. Follow these steps to get started with your project.

## Overview

This guide will help you set up Jenkins on a remote server, automate infrastructure deployment using Terraform, manage tools with Ansible, integrate with AWS services, and enable GitHub for automated testing and deployment.

## Table of Contents

1. [Infrastructure Setup](#step-1-infrastructure-setup)
2. [Install Tools](#step-2-install-tools)
3. [Jenkins Configuration](#step-3-jenkins-configuration)
4. [Configure Jenkins Credentials](#step-4-configure-jenkins-credentials)
5. [Configure GitHub Webhook](#step-5-configure-github-webhook)
6. [Configure Jenkins Pipeline](#step-6-configure-jenkins-pipeline)
7. [Run the Pipeline](#step-7-run-the-pipeline)

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
Install Docker, AWS CLI, Kubernetes tools, and Jenkins using Ansible:
Update the inventory file with the instance IP and SSH key.

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
Open the instance IP with port 8080 in a web browser.

SSH into your instance and retrieve the initial admin password:

```shell
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Install suggested plugins and create a Jenkins account.

## Step 4: Configure Jenkins Credentials
In Jenkins, navigate to Manage Jenkins > Credentials > System > Global Credentials:

Add your AWS credentials using:

```shell
Cat .aws/credentials
```
Generate a GitHub Token in your GitHub account's Settings > Developer settings > Personal access tokens.

Add the credentials in Jenkins.

## Step 5: Configure GitHub Webhook
In your GitHub repository, go to Settings > Webhooks > Add webhook:
Payload URL: Jenkins server's public IP with port 8080.
Change Content type to application/json.
Choose desired events and add the webhook.

## Step 6: Configure Jenkins Pipeline
Get the ECR URL from AWS and add it to the Jenkinsfile.

Create a Multibranch Pipeline in Jenkins for your GitHub repository.

Configure credentials, repository URL, and branch discovery.

## Step 7: Run the Pipeline
Using the provided Jenkinsfile, the pipeline will:
Build Docker images
Push images to ECR
Deploy Kubernetes resources
Commit and push changes to GitHub.
Jenkins will automatically trigger the pipeline and execute defined actions.
