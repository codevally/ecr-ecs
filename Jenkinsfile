pipeline {

    options
    {
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }
    
    agent {
        node {
            label 'master' 
        }
    }    

    //parameters {
    //    choice(choices: "$environment", description: '', name: 'ENVIRONMENT')
    //}
    
    stages {
        stage('Git Checkout') {
            steps {
                checkout scm
            
            }
        }

        stage('Build preparations') {
            steps {
                script {
                    gitCommitHash = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                    shortCommitHash = gitCommitHash.take(7)
                    currentBuild.displayName = "#${BUILD_ID}-${shortCommitHash}"
                }
            }
        }
        
        stage('ECR login') {
            steps {
                script {
                    sh 'aws ecr get-login --no-include-email --region ap-southeast-2'
                }
            }
        }        
        
    }
}
