pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')  // Jenkins credentials ID for Docker Hub
        DOCKER_IMAGE_NAME = '8060633493/ecommerce-website'    // Your Docker Hub repository
    }

    stages {
        stage('Connect To Github') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/charliepoker/ecommerce-website.git']])
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image and tag it with 'latest'
                    sh 'docker build -t $DOCKER_IMAGE_NAME:latest .'
                }
            }
        }

        stage('Stop Existing Container on Port 8081') {
            steps {
                script {
                    // Check if any container is using port 8081 and stop it
                    sh '''
                    existing_container=$(docker ps --filter "publish=8081" -q)
                    if [ ! -z "$existing_container" ]; then
                        echo "Stopping container on port 8081"
                        docker stop $existing_container
                        docker rm $existing_container  # Clean up the stopped container
                    fi
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run a new container on port 8081
                    sh 'docker run -itd -p 8081:80 $DOCKER_IMAGE_NAME:latest'
                }
            }
        }


        stage('Push to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub and push the image
                    sh '''
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                    docker push $DOCKER_IMAGE_NAME:latest
                    docker push $DOCKER_IMAGE_NAME:latest
                    '''
                }
            }
        }
    }
}