pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'dockerhub-Credentials'       // your DockerHub credentials in Jenkins
        DOCKER_IMAGE_NAME = 'retail-app'        // your DockerHub repo name
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
                sh 'mvn clean install -DskipTests'   // generates target/retail-app.war
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
                    docker.image("${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}").tag("${DOCKER_IMAGE_NAME}:latest")
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
                echo "✅ Docker image built and pushed to DockerHub. You can now deploy it manually to Kubernetes."
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline finished successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs for details.'
        }
    }
}
