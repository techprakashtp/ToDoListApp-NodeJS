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
	sh 'gpasswd -a jenkins docker'      
	sh 'service docker status'
	sh 'usermod -aG docker $USER'
	sh 'usermod -aG docker jenkins'
	sh 'systemctl start docker'
	sh 'systemctl enable docker'
	sh 'systemctl restart docker'
	sh 'ls -la /var/run/docker.sock'
	sh 'docker build -t jprakash1/nodejs-todolist .'
      } 
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push jprakash1/nodejs-todolist-app'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}
