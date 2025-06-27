pipeline {
    agent {
        docker {
            image 'deshan1371/jenkins_homework:1.0'
            args  '-v /var/run/docker.sock:/var/run/docker.sock -u root'
        }
    }

    stages {
        
           stage('Pull project') {
            steps {
               git changelog: false, poll: false, url: 'https://github.com/Lokdash/dind_Jenkins.git'
            }
        }
           stage('Build in Maven') {
            steps {
               sh 'mvn package'
            }
        }
        
         stage('Build in Docker') {
            steps {
                 sh 'docker build -t javatest .'
            }
        }
       
       stage('Login to Docker Hub&tag&push') {
            steps { withCredentials([usernamePassword(credentialsId: 'cf5fd340-0fa2-4975-a8af-4d6fa4e7027a', passwordVariable: 'docker_pass', usernameVariable: 'docker_login')]) {

                    sh "echo ${docker_pass} | docker login -u ${docker_login} --password-stdin"
                    sh 'docker tag javatest deshan1371/jenkins_homework_build:1.0'
                    sh 'docker push deshan1371/jenkins_homework_build:1.0'
                }
            }
            } 
            
             stage('Second node auth') {
            steps { 
                 sh "mkdir /root/.ssh"
                 sh "touch /root/.ssh/known_hosts"
                 sh "ssh-keyscan 89.169.176.113 > /root/.ssh/known_hosts"
                 sh "cat /root/.ssh/known_hosts"
            }
        }
       stage('Remote SSH') {
  steps {
    withCredentials([sshUserPrivateKey(credentialsId: '01dd9b1c-826f-43d0-97b6-059224a08c9c', keyFileVariable: 'sshKey')]) {
      sh '''ssh -tt -i ${sshKey} root@89.169.176.113 << EOF
      docker pull deshan1371/jenkins_homework_build:1.0
      docker run -d -p 8083:8080 deshan1371/jenkins_homework_build:1.0
      exit
      EOF'''
    }
  }
} 
    }
}
