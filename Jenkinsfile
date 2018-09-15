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
        ECRREGISTRY = '376298768100.dkr.ecr.ap-southeast-2.amazonaws.com/ecs-rp'
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
                    SHORTCOMMIT = shortCommitHash
                    currentBuild.displayName = "#${BUILD_ID}-${shortCommitHash}"
                }
            }
        }

        stage('Docker Build') {
            steps {
                dir('application') {
                    script {
                        sh 'ls -al'
                        imageName = "codevally/flask-app:${SHORTCOMMIT}"
                        sh "docker build -t ${imageName} ."
                    }
                }
            }        
        }

        stage('Tag Docker Image') {
            steps {
                dir('application') {
                    script {
                        sh 'ls -al'
                        imageName = "codevally/flask-app:${SHORTCOMMIT}"
                        sh "docker tag ${imageName} ${ECRREGISTRY}:${SHORTCOMMIT}"
                    }
                }
            }        
        }
        
        stage('ECR login') {
            steps {
                script {
                    sh 'eval $(aws ecr get-login --no-include-email --region ap-southeast-2 | sed \'s|https://||\')'
                }
            }
        }
        
        stage('Push Docker Image ECR') {
            steps {
                dir('application') {
                    script {
                        sh "docker push ${ECRREGISTRY}:${SHORTCOMMIT}"
                    }
                }
            }        
        }
        

    }
}
