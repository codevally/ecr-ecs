pipeline {

    agent {
        node {
            label 'docker-slave-image' 
        }
    }    

    //parameters {
    //    choice(choices: "$environment", description: '', name: 'ENVIRONMENT')
    //}
    
    stages {
    
        stage('Prepare') {
        
            steps {
		ansiColor('xterm') {
                    checkout scm
		}
            
            }
        
        }
    
    }
}
