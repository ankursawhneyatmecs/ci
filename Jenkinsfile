pipeline {
  agent any
  stages {
  	  stage('Prepare underlying system') {
          steps {
       	
              	sh '''
              	#!/bin/bash
                python --version
                ls
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
