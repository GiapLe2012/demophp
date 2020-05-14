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
                    sh "docker login -u $user_registry -p $password_registry registry.nganluong.vn:444"
                    myapp = docker.build("registry.nganluong.vn/repository/demo-repo/php:${env.BUILD_ID}")
                }
            }
        }
        stage("Push image") {
            steps {
                script {
                    sh """
                    docker login -u $user_registry -p $password_registry registry.nganluong.vn:444
                    docker push registry.nganluong.vn/repository/demo-repo/php:${env.BUILD_ID}
                    docker rmi registry.nganluong.vn/repository/demo-repo/php:${env.BUILD_ID}
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