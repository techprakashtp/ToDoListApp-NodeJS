
pipeline {
  
  environment {
    Repo_Name='jprakash1/node-todo-app'
    Container_Name = 'my-container'
    IMAGE_TAG='v1.0'
    GITHUB_CREDENTIALS = credentials('github-credentials')
    DOCKER_HUB_TOKEN = credentials('docker-hub-token')
  }
  
  agent any
  
  stages {         
    stage('Cloning Git') {
            steps {
                git([url: 'https://github.com/techprakashtp/ToDoListApp-NodeJS.git', branch: 'main'])
            }
        }
  
    stage('Build Docker Image') {         
       steps{  
         script {  
        docker.build "${Repo_Name}:${BUILD_NUMBER}"
        echo 'Build Image Completed'   
           
         }
      }       
   }
    
    stage('Running image') {
       steps {
         sh "docker run -d --name ${Container_Name} ${Repo_Name}:${BUILD_NUMBER}"
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
                    withDockerRegistry(credentialsId: 'docker-hub-cred', toolName: 'Docker') {
                        docker.image("${Repo_Name}:${BUILD_NUMBER}").push()
                        echo 'Push Docker Image to Docker Hub Completed'
                    }
                }
            }
    }
  } 
}
