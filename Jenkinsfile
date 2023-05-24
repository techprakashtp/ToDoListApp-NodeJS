pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
  }
  stages { 
    stage('Build') {
      steps {   
	sh 'docker --version'
	sh 'gpasswd -a jenkins docker'  
	sh 'docker build -t jprakash1/node-todolist-app .'
      } 
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push jprakash1/node-todolist-app'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}
