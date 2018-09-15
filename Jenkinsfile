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

    environment {
        BUILDNUMBER = "${env.BUILD_NUMBER}"
        ECRREGISTRY = 'https://376298768100.dkr.ecr.ap-southeast-2.amazonaws.com/ecs-rp'
    }


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

        stage('Docker Build') {
            steps {
                script {
                    sh 'ls -al'
                    sh 'docker build -t codevally/flask-app-"${shortCommitHash}":latest .'
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
