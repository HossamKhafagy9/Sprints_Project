# Sprints_Project
Sprints Final Project
# Setting up Jenkins with Terraform, Ansible, AWS, and GitHub

This guide outlines the steps to set up Jenkins for continuous integration and deployment using Terraform, Ansible, AWS, and GitHub. Follow these instructions to get your environment up and running.

## Step 1: Infrastructure Setup

1. Initialize Terraform:
terraform init

markdown
Copy code

2. Plan and review the infrastructure changes:
terraform plan

markdown
Copy code

3. Apply the infrastructure changes:
terraform apply

markdown
Copy code

## Step 2: Install Jenkins

1. Run Ansible playbook to install Docker, AWS CLI, and Kubernetes tools:
```shell
ansible-playbook docker.yml -i inventory.txt
ansible-playbook awscli.yml -i inventory.txt
ansible-playbook kubectl.yml -i inventory.txt
Run Ansible playbook to install Jenkins:

shell
Copy code
ansible-playbook Jenkins.yml -i inventory.txt
Connect via SSH to the Jenkins server:

shell
Copy code
ssh <Jenkins_Server_IP> -i <Path_to_Private_Key>
Retrieve the initial admin password:

shell
Copy code
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
Copy the output and use it to unlock Jenkins during setup.

Step 3: Jenkins Configuration
Install suggested plugins and create a Jenkins user account:

Access Jenkins via the web browser.
Create a user account with username, password, and email.
Configure AWS ECR:

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
