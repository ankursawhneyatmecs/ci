pipeline {
  agent {
        docker { image 'alpine' }
    }

  stages {
  	  stage('Prepare underlying system') {
          steps {
          	deleteDir()
          	
              	sh '''
              	#!/bin/bash
  	    	      uname -a
  	    	      echo $0
  	    	      python2 || { apt install -y python; }
	              pip2 || { apt install -y python-pip; }
	              virtualenv2 || { apt install -y virtualenv; }
                python2 --version
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
