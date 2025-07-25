pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'dockerhub-Credentials'               // ID from Jenkins credentials
        DOCKER_IMAGE_NAME = 'ahmedabdelraouf/retail-app'               // Your DockerHub repo name
    }

    stages {

        stage('Checkout Source Code') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-pat',
                    url: 'https://github.com/ahmedabdelraouf75/retail-app.git'
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
                    docker.image("${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}").tag("latest")
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    withDockerRegistry(credentialsId: "${DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                        docker.image("${DOCKER_IMAGE_NAME}:latest").push()
                    }
                }
            }
        }

        stage('Verify Deployment Step') {
            steps {
                echo "✅ Docker image pushed to DockerHub successfully. Ready for manual deployment to Kubernetes."
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline finished successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check the console output for errors.'
        }
    }
}
