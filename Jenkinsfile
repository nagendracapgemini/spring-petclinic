pipeline {
    agent any
    triggers { pollSCM('* * * * *') }
    stages {
        stage('SourceCode') {
            steps {
                git branch: 'master', url: 'https://github.com/nagendracapgemini/spring-petclinic.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn package'
				//buildName: "${JOB_NAME}",
                //buildNumber: "${BUILD_ID}"
            }
        }
        stage('Archive and Test Results') {
            steps {
               junit '**/surefire-reports/*.xml'
               archiveArtifacts artifacts: '**/*.jar', followSymlinks: false


            }
        }
        
        stage('Static Code Analysis') {
          environment {
            SONAR_URL = "http://20.242.95.181:9000"
            }
            steps {
               withCredentials([string(credentialsId: 'sonorintegration', variable: 'SONAR_AUTH_TOKEN')]) {
               sh 'mvn sonar:sonar -Dsonar.login=$SONAR_AUTH_TOKEN -Dsonar.host.url=${SONAR_URL}'
            }
          }
        }
        stage('Build Docker Image') {
           steps {
               script {
                   // Define environment variables Docker image name and tag
                   def imageName = "petclinic"
                   def imageTag = "v1"
                   
                   // Build the Docker image
                   sh "docker build -t ${imageName}:${imageTag} ."
               }
           }
        }
        
        stage('Publish Docker hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                    script {
                        // Login to Docker Hub and push the Docker image
                        sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"
                        sh "docker tag petclinic:v1 nagendra123456/petclinic:v1"
                        sh "docker push nagendra123456/petclinic:v1"
                    }
                }
            }
        }

        stage('ACR Dockerbuild') {
            steps{
              sh 'docker image build -t mana007.azurecr.io/petclinic:v1 .'
            }
        }
        stage('push') {
          steps{
           withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'ACR_cred', usernameVariable: 'ACR_USER', passwordVariable: 'ACR_PASSWORD']]) {
            sh 'docker login -u ${ACR_USER} -p ${ACR_PASSWORD} mana007.azurecr.io'
            sh 'docker image push mana007.azurecr.io/petclinic:v1'
            }
          }
        }
        stage ("Kube Deploy") {
            steps {
                withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'kube-config', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                  sh "helm install spring petclinic"
            }
        }    
        }

    } 
}    
