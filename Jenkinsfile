pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        ECR_REPOSITORY = '355102668264.dkr.ecr.us-east-1.amazonaws.com/project-ecr'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t project-latest /var/lib/jenkins/workspace/project-latest/'
                sh "docker tag project-latest $ECR_REPOSITORY:$BUILD_NUMBER"
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REPOSITORY"
                        sh "docker push $ECR_REPOSITORY:$BUILD_NUMBER"
                    }
                }
            }
        }
        
        stage('Deployment Stage') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh "aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster"
                        sh "sed -i 's|<SPRINTS-IMAGE>|$ECR_REPOSITORY:$BUILD_NUMBER|g' /var/lib/jenkins/workspace/project-latest/deployment.yml"
                        try {
                            sh "kubectl create configmap mysql-queries-configmap --from-file=/var/lib/jenkins/workspace/project-latest/MySQL_Queries/BucketList.sql"
                            echo "ConfigMap 'mysql-queries-configmap' created successfully."
                        } catch (Exception e) {
                            echo "ConfigMap 'mysql-queries-configmap' already exists: ${e.getMessage()}"
                        }
                        
                    sh "kubectl apply -f /var/lib/jenkins/workspace/project-latest/mysql-configmap.yml"
                    sh "kubectl apply -f /var/lib/jenkins/workspace/project-latest/mysql-secret.yml"
                    sh "kubectl apply -f /var/lib/jenkins/workspace/project-latest/statefulset.yml"
                    sh "kubectl apply -f /var/lib/jenkins/workspace/project-latest/mysql-service.yml"
                    sh "kubectl apply -f /var/lib/jenkins/workspace/project-latest/deployment.yml"
                    sh "kubectl apply -f /var/lib/jenkins/workspace/project-latest/service.yml"
                    sh "kubectl apply -f /var/lib/jenkins/workspace/project-latest/ingress.yml"
                    sh "kubectl apply -f /var/lib/jenkins/workspace/project-latest/mysql-pv.yml"
                    sh "kubectl apply -f /var/lib/jenkins/workspace/project-latest/mysql-pvc.yml"
                    }
                }
            }
        }
    }
}
