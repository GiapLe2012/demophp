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
                    myapp = docker.build("giaple/demogo:$(awk -F":" '{print $NF}' version) .")
                }
            }
        }
        stage("Push image") {
            steps {
                script {
                    sh """
                    docker login -u $user_registry -p $password_registry
                    docker push giaple/demogo:$(awk -F":" '{print $NF}' version) .
                    docker rmi giaple/demogo:$(awk -F":" '{print $NF}' version) .
                    """
                }
            }
        }        
        stage('Deploy to Kubenetes-Local') {
            steps{
                sh "sed -i 's/demogo:latest/demogo:$(awk -F":" '{print $NF}' version)/g' deployment.yaml"
                sh "kubectl apply -f deployment.yaml"
            }
        }
    }    
}