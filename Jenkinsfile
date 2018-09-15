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
        //BUILDNUMBER = "${env.BUILD_NUMBER}"
        //ECRREGISTRY = 'https://376298768100.dkr.ecr.ap-southeast-2.amazonaws.com/ecs-rp'
        def SHORTCOMMIT = ""
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
                    env.SHORTCOMMIT = shortCommitHash
                    currentBuild.displayName = "#${BUILD_ID}-${shortCommitHash}"
                }
            }
        }

        stage('Docker Build') {
            steps {
                dir('application') {
                    script {
                        sh 'ls -al'
                        imageName = "codevally/flask-app-${env.SHORTCOMMIT}"
                        sh "docker build -t ${imageName}:latest ."
                    }
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
