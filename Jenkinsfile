pipeline {
    agent any

    environment {
        IMAGE_NAME = 'localhost:5000/my-springboot-app'  // Use local registry
        IMAGE_TAG = 'latest'
    }

    stages {

        stage('Docker Permission Check') {
            steps {
                sh 'id && ls -l /var/run/docker.sock && docker ps'
            }
        }

	stage('Test Maven') {
    	     steps {
        	sh 'mvn -version'
    	     }
	}

        stage('Checkout') {
            steps {
                // Replace with your actual Git URL and branch
                git url: 'https://github.com/vadece3/Jenkins-Docker-Springboot.git', branch: 'main'
            }
        }

        stage('Build Java App') {
            steps {
                // Compile and package the Spring Boot app into a JAR
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile in the root
                    docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Push to Local Registry') {
            steps {
                script {
                    // Push the image to the local registry (localhost:5000)
                    docker.withRegistry('http://localhost:5000') {
                        docker.image("${IMAGE_NAME}:${IMAGE_TAG}").push()
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                // Stop any previous container
                sh 'docker rm -f springboot_container || true'

                // Run the newly built image from the local registry
                sh 'docker run -d -p 9090:8080 --name springboot_container localhost:5000/my-springboot-app:latest'
            }
        }
    }

    post {
        always {
            // Clean up dangling images and containers
            sh 'docker system prune -f'
        }
    }
}
