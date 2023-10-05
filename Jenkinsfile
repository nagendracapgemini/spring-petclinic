pipeline {
    agent any
    parameters {
        choice(name: 'BRANCH_TO_BUILD', choices: ['master', 'main'], description: 'Branch to build')
        string(name: 'MAVEN_GOAL', defaultValue: 'package', description: 'maven goal')
    triggers { pollSCM('* * * * *') }
    stages {
        stage('SourceCode') {
            steps {
                git branch: 'main', url: 'https://github.com/nagendracapgemini/spring-petclinic.git'
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
        
    }    
    } 
}    
