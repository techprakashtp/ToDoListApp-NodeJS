
pipeline {
  
  environment {
    Repo_Name='jprakash1/node-todolist-app'
    Container_Name = 'my-container'
    dockerImage = ''
    image_tag='latest'
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
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
        sh 'gpasswd -a jenkins docker'           
        dockerImage = docker.build '${Repo_Name}:${image_tag}'
        echo 'Build Image Completed'   
      }         
    }
    
    stage('Running image') {
       steps {
         sh 'docker run -d --name ${Container_Name} ${Repo_Name}:${image_tag}'
       }         
    }
        
    stage('Stop Remove Container') {
       steps {
         sh "docker stop ${Container_Name}"
         sh "docker rm ${Container_Name}"
       }           
    }
    
    stage('Login') {
      steps {
        sh 'echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin'
        echo 'Login Completed'
      }
    }
    stage('Push Image to Docker Hub') {         
      steps{ 
        sh 'docker push ${Repo_Name}:${image_tag}'                
        echo 'Push Image Completed'       
        }           
      }  
    } //stages

  post {
    always {
      sh 'docker logout'
    }
  }  
} //pipeline
