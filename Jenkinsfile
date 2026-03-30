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
                echo 'DockerHub a image ı gönder'
                script{
                withCredentials([usernamePassword(credentialsId: 'ID_DockerHub', passwordVariable: 'dckr_pat_UOkXzHZwTiv3PRc7S9LtMHAikm8', usernameVariable: 'Cred_hsnDockerHub')]) {

                
             
                    if (isUnix()){
                        //sh 'docker login -u hsntpl -p %Cred_hsnDockerHub%'
                        sh 'docker push hsntpl/devops-application:latest'
                        echo 'sh çalıştı'
                    }else
                    {
                        //bat 'docker login -u hsntpl -p %Cred_hsnDockerHub%'
                        bat 'docker push hsntpl/devops-application:latest'
                        echo 'bat çalıştı'
                    }
                }
}

            }
        }
        
        stage('Kubernetes') {
            steps {
                echo 'K8s image ı çek ve pod a dönüştür.'
            }
        }
        
        stage('Clean') {
            steps {
                echo 'Makinemdeki fazlalık imajları temizle'
            }
        }
    }
}
