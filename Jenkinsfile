#!groovy
pipeline {

agent none

stages {
  stage('Run all stages in parallel') {

    parallel {
	
	  stage('Read env') {
	  agent any
		steps {
			script {
				sh 'env > env.txt' 
				for (String i : readFile('env.txt').split("\r?\n")) {
					   println i
				}
			}
		}
	  }
	  
      stage('Validate Filenames') {
        agent {
	  dockerfile {
	    filename 'ci_tools/check_filename/dockerfile_centos'
	    }
        }
        steps {
				script {
		    try 
		      {
			  sh '''
					if ! [ -e ci_tools/check_filename/filename_checker.sh ]; then echo "[Error]: \'filename_checker.sh\' not found." && exit 1; fi ;
				find . \\! -path \\*/\\.git/\\* \\! -path \\*/README.md \\! -path \\*/Jenkinsfile -exec sh ci_tools/check_filename/filename_checker.sh {} \\; > invalidfilenames.out
				if [ -s invalidfilenames.out ]; then echo "[Error]: Following files with invalid names found in workspace" && cat invalidfilenames.out && rm invalidfilenames.out && exit 1; else rm invalidfilenames.out; fi'''
		      }
		    catch (err) {
			currentBuild.result = 'UNSTABLE'
			emailext attachLog: true, body: 'Hello', compressLog: true, recipientProviders: [[$class: 'DevelopersRecipientProvider']], subject: 'job ${env.BUILD_NUMBER}', to: 'ankur.sawhney@dxc.com'
		    }
	      }  
        }
      }

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
