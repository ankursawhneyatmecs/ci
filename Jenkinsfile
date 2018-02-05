pipeline {
  agent {
        docker { image 'jenkinsci/slave:alpine' }
    }

  stages {
  	  stage('Prepare underlying system') {
          steps {
          	deleteDir()
          	
              	sh '''
              	#!/bin/bash
  	    	      uname -a
  	    	      echo $0
  	    	      python 2>/dev/null || { apt-get install -y python; }
	              pip 2>/dev/null || { apt-get install -y python-pip; }
	              virtualenv 2>/dev/null || { apt-get install -y virtualenv; }
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
