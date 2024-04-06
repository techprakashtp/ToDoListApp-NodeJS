pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    dockerhubusername='jprakash1'
    dockerhubreponame='node-todolist-app'
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
        sh 'sudo docker build -t dockerhubusername/dockerhubreponame:$BUILD_NUMBER .'           
        echo 'Build Image Completed'                
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
        sh 'sudo docker push dockerhubusername/dockerhubreponame:$BUILD_NUMBER'                
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
