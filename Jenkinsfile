pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    Repo_Name='jprakash1/node-todolist-app'
    Container_Name = 'my-container'
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
        sh 'sudo docker build -t ${Repo_Name}:${BUILD_NUMBER} .'           
        echo 'Build Image Completed'                
      }           
    }
    
    stage('Running image') {
       steps {
         sh 'docker run -d --name ${Container_Name} ${Repo_Name}:${BUILD_NUMBER}
       }           
    }
            
    stage('Stop and Remove Container') {
       steps {
         sh 'docker stop ${Container_Name} || true'
         sh 'docker rm ${Container_Name} || true'
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
        sh 'sudo docker push ${Repo_Name}:${BUILD_NUMBER}'                
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
