pipeline {
  agent any
  stages {
        stage('Prepare underlying system') {
          steps {
           
                sh '''
                  #!/bin/bash
                  python --version
                  ls
                  git secret 2> /dev/null;
                  status=$?
                  if [ $status -ne 0 ] && [ $status -ne 126 ] ; then 
                  echo "deb https://dl.bintray.com/sobolevn/deb git-secret main" | sudo tee -a /etc/apt/sources.list
                  wget -qO - https://api.bintray.com/users/sobolevn/keys/gpg/public.key | sudo apt-key add -
                  sudo apt-get update && sudo apt-get install git-secret; 
                  fi;
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
