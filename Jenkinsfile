pipeline {
    agent any
    environment {
        DOCKER_USER = "axone125" 
    }
    stages {
        // No manual Checkout stage needed here
        
        stage('Build & Push App 1') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_USER}/my-app:v${env.BUILD_NUMBER} -f docker/Dockerfile.nginx docker/"
                    
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        sh "echo \$PASS | docker login -u \$USER --password-stdin"
                        sh "docker push ${DOCKER_USER}/my-app:v${env.BUILD_NUMBER}"
                    }
                }
            }
        }
        
        stage('Build & Push App 2') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_USER}/my-app-1:v${env.BUILD_NUMBER} -f docker/Dockerfile.nginx1 docker/"
                    // Re-use login from previous stage
                    sh "docker push ${DOCKER_USER}/my-app-1:v${env.BUILD_NUMBER}"
                }
            }
        }

        stage('Deploy/Update K8s') {
            steps {
                // Ensure kubectl is in the path
                sh "kubectl rollout restart deployment/nginx-deployment -n terraform-lab"
                sh "kubectl rollout restart deployment/nginx-deployment-1 -n terraform-lab"
            }
        }
    }
}
