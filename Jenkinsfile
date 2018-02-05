pipeline {
  agent {
        dockerfile true
    }

  stages {
  	  stage('Prepare underlying system') {
          steps {
          	deleteDir()
          	
              	sh '''
              	#!/bin/bash
                python --version
                '''
            }
        }
  }
  
      options {
          // Store max 4 build results at any given time
          buildDiscarder(logRotator(numToKeepStr:'4'))
      
         // To make sure that this build doesn't hang forever, we time it out after an hour
         timeout(time: 60, unit: 'MINUTES')
         }

}
