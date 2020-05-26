pipeline {
    agent any
    environment {
        PROJECT_ID = 'PROJECT-ID'
        CLUSTER_NAME = 'kube1'
        LOCATION = 'CLUSTER-LOCATION'
        CREDENTIALS_ID = 'local_kube'
    }
    stages {
        stage("Checkout code") {
            steps {
                checkout scm
            }
        }
        stage("Build image") {
            steps {
                script {
                    sh "docker login -u $user_registry -p $password_registry"
                    myapp = docker.build("giaple/giaplv/php:${env.BUILD_ID}")
                }
            }
        }
        stage("Push image") {
            steps {
                script {
                    sh """
                    docker login -u $user_registry -p $password_registry
                    docker push giaple/giaplv/php:${env.BUILD_ID}
                    docker rmi giaple/giaplv/php:${env.BUILD_ID}
                    """
                }
            }
        }        
        stage('Deploy to Kubenetes-Local') {
            steps{
                sh "sed -i 's/php:latest/php:${env.BUILD_ID}/g' deployment.yaml"
                sh "kubectl apply -f deployment.yaml"
            }
        }
    }    
}