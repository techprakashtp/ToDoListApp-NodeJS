pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
  }
  stages {
    stage('Install') {
      steps { 
	sh 'apt install apt-transport-https ca-certificates curl software-properties-common' 
	sh 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg'
	sh 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null'
	sh 'apt update'
	sh 'apt-cache policy docker-ce'
	sh 'apt install docker-ce'
      }
    }	    
    stage('Build') {
      steps {          
	sh 'service docker status'
	sh 'usermod -aG docker $USER'
	sh 'usermod -aG docker jenkins'
	sh 'gpasswd -a jenkins docker'  
	sh 'systemctl start docker'
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
