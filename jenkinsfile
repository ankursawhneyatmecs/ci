#!/usr/bin/env groovy

properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '4')), [$class: 'GithubProjectProperty', displayName: '', projectUrlStr: 'https://github.com/ankursawhneyatmecs/ci/']])

node {
        deleteDir()
		
		checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/ankursawhneyatmecs/ci.git']]])

		stage('Validate Filenames') {
				sh '''if ! [ -e filename_checker.sh ]; then echo "[Error]: \'filename_checker.sh\' not found." && exit 1; fi ;
				find . \\! -path \\*/\\.git/\\* -exec filename_checker.sh {} \\; > invalidfilenames.out
				if [ -s invalidfilenames.out ]; then echo "[Error]: Following files with invalid names found in \\
				workspace" && cat invalidfilenames.out && rm invalidfilenames.out && exit 1; else rm invalidfilenames.out; fi'''
		}
		
		stage('Analyze and test') {
			sh '''#!/bin/bash
			python --version
			pip || apt-get install python-pip -y
			virtualenv || pip install virtualenv
			python -m virtualenv newvenv
			source newvenv/bin/activate
			pip install -r requirements.txt
			pylint -j 0 -r n -f parseable main_code/ | tee pylint.out
			robot -d main_code main_code'''
		}
}
