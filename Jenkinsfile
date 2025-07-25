pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'dockerhub-Credentials'
        DOCKER_IMAGE_NAME = 'ahmedabdelraouf/retail-app'
    }

    stages {
        stage('Checkout Source Code') {
            steps {
                cleanWs()
                git branch: 'main', credentialsId: 'github-pat', url: 'https://github.com/ahmedabdelraouf75/retail-app.git'
            }
        }

        stage('Build and Test Maven Project') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'mvn test'
                junit 'target/surefire-reports/*.xml'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}")
                    docker.tag("${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}", "${DOCKER_IMAGE_NAME}:latest")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: "${DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                        docker.image("${DOCKER_IMAGE_NAME}:latest").push()
                    }
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "Docker image pushed successfully. Proceed to deploy manually using Ansible."
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo '✅ Pipeline finished successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs for details.'
        }
    }
}
