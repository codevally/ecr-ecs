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
            script {
                gitCommitHash = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                shortCommitHash = gitCommitHash.take(7)
                currentBuild.displayName = "#${BUILD_ID}-${shortCommitHash}"
            }
        }
        
        stage('Prepare') {
        
            steps {
                checkout scm
            
            }
        
        }        
    }
}
