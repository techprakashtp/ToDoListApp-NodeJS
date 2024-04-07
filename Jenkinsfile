
pipeline {
  
  environment {
    Repo_Name='jprakash1/node-todo-app'
    Container_Name = 'my-container'
    IMAGE_TAG='latest'
    DOCKERHUB_CREDENTIALS = credentials('docker-hub-credentials')
  }
  
  agent any
  
  stages {         
    stage('Checkout Code') {
            steps {
                 git branch: 'main', credentialsId: 'GITHUB', url: 'https://github.com/techprakashtp/ToDoListApp-NodeJS.git'
            }
        }
  
    stage('Build Docker Image') {         
       steps{  
         script {
        sh 'gpasswd -a jenkins docker'           
        docker.build "${Repo_Name}:${IMAGE_TAG}"
        echo 'Build Image Completed'   
           
         }
      }       
   }
    
    stage('Running image') {
       steps {
         sh "docker run -d --name ${Container_Name} ${Repo_Name}:${IMAGE_TAG}"
       }         
    }
        
    stage('Stop Remove Container') {
       steps {
         sh "docker stop ${Container_Name}"
         sh "docker rm ${Container_Name}"
       }           
    }
    
      stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://hub.docker.com/u/jprakash1/', DOCKERHUB_CREDENTIALS) {
                        docker.image("${Repo_Name}:${IMAGE_TAG}").push()
                        echo 'Push Docker Image to Docker Hub Completed'
                    }
                }
            }
    } //stages
} //pipeline
