pipeline {
  agent any
  stages {
        stage('Prepare underlying system') {
          steps {
           
                sh '''
                  #!/bin/bash
                  python --version
                  ls -l
                  git clone https://github.com/awslabs/git-secrets
                  cd git-secrets
                  make install
				  git secrets --register-aws --global
				  git secrets --install
                  git secrets --install ~/.git-templates/git-secrets
                  git config --global init.templateDir ~/.git-templates/git-secrets
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
