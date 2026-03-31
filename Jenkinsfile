pipeline {
    agent any
    
    tools{
        maven "Maven3"
        jdk "java21"
    }
    stages {
       
        stage('Github') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/hsntpl/devops_003_pipeline']])
                echo 'Uygulamayı GitHub dan çek'
            }
        }
        
        stage(' Build Maven') {
            steps {
                echo 'Çekilen uygulamanın Maven bağımlılıklarını bul'
               script{ 
                    if (isUnix()){
                        sh mvn '-Dmaven.test.failure.ignore=true clean package'
                    }else
                    {
                        bat'mvn -Dmaven.test.failure.ignore=true clean package'
                        echo 'bat çalıştı'
                    }
               }
            }
        }
       
        stage('Test') {
            steps {
                echo 'Uygulamayı Test Et'
                script{ 
                    if (isUnix()){
                        sh 'mvn test'
                    }else
                    {
                        bat 'mvn test'
                        echo 'bat çalıştı'
                    }
                }
            }
        }
        
        stage('Docker Image') {
            steps {
                echo 'Docker Image yap'
                script{ 
                    if (isUnix()){
                        sh 'docker build -t hsntpl/devops-application:latest .'
                        echo 'sh çalıştı'
                    }else
                    {
                        bat 'docker build -t hsntpl/devops-application:latest .'
                        echo 'bat çalıştı'
                    }
                }
            }
        }
        
        stage('Docker image to DockerHub') {
            steps {
                echo 'DockerHub a image gönderiliyor'
                script{
                  withCredentials([string(credentialsId: 'Cred_DockerHub', variable: 'hsnCred_DockerHub')]) {

                    if (isUnix()){
                        //sh 'docker login -u hsntpl -p %Cred_hsnDockerHub%'
                        sh 'docker push hsntpl/devops-application:latest'
                        echo 'sh çalıştı'
                        echo 'DockerHub a image gönderildi'
                    }else
                    {
                        //bat 'docker login -u hsntpl -p %Cred_hsnDockerHub%'
                        bat 'docker push hsntpl/devops-application:latest'
                        echo 'bat çalıştı'
                        echo 'DockerHub a image gönderildi'
                    }

                }
}

            }
        }
        
        stage('Kubernetes') {
            steps {
                echo 'K8s image ı çek ve pod a dönüştür.'
                kubernetesDeploy configs: 'deployment-service.yaml', kubeconfigId: 'ID_kubernetes']
            }
        }
        
        stage('Clean') {
            steps {
                echo 'Makinemdeki fazlalık imajları temizle'
            }
        }
    }
}
