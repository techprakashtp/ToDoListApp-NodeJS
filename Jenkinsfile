pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DockerHubRepoName='jprakash1/node-todolist-app'
    ContainerName = 'my-container'
    BUILD_NUMBER='latest'
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
  }

  stages {         
    stage("Git Checkout"){           
      steps{                
      git credentialsId: 'github', url: 'https://github.com/techprakashtp/ToDoListApp-NodeJS.git'                 
      echo 'Git Checkout Completed'            
      }        
    }
  
    stage('Build Docker Image') {         
      steps{        
        sh 'gpasswd -a jenkins docker'          
        sh 'sudo docker build -t ${DockerHubRepoName}:${BUILD_NUMBER} .'           
        echo 'Build Image Completed'                
      }           
    }
    
    stage('Running image') {
       steps {
         sh 'docker run -d --name ${ContainerName} ${DockerHubRepoName}:${BUILD_NUMBER}
       }           
    }
            
    stage('Stop and Remove Container') {
       steps {
         sh 'docker stop ${ContainerName} || true'
         sh 'docker rm ${ContainerName} || true'
       }           
    }
         
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
        echo 'Login Completed'
      }
    }

    stage('Push Image to Docker Hub') {         
      steps{                            
        sh 'sudo docker push ${DockerHubRepoName}:${BUILD_NUMBER}'                
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
