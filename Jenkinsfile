#!/usr/bin/env groovy

properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '4')), [$class: 'GithubProjectProperty', displayName: '', projectUrlStr: 'https://github.com/ankursawhneyatmecs/ci/'] ])

node {
        deleteDir()
		
		checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/ankursawhneyatmecs/ci.git']]])

		stage('Validate Filenames') {
				sh '''if ! [ -e filename_checker.sh ]; then echo "[Error]: \'filename_checker.sh\' not found." && exit 1; fi ;
				find . \\! -path \\*/\\.git/\\* -exec filename_checker.sh {} \\; > invalidfilenames.out
				if [ -s invalidfilenames.out ]; then echo "[Error]: Following files with invalid names found in \\
				workspace" && cat invalidfilenames.out && rm invalidfilenames.out && exit 1; else rm invalidfilenames.out; fi'''
		}
		
		stage('Run UnitTest and Analyze') {
			//Assuming the module 'virtualenv' is already installed
			sh '''
			python --version
			pip || sudo yum install python-pip -y
			virtualenv || sudo pip install virtualenv
			python -m virtualenv newvenv
			source newvenv/bin/activate
			pip install -r requirements.txt
			pylint -j 0 -r n -f parseable main_code/ | tee pylint.out
			cd main_code
			robot -d unit_tests unit_tests'''
			
			step([
				$class : 'RobotPublisher',
				outputPath : 'main_code/unit_tests',
				outputFileName : 'output.xml',
				disableArchiveOutput : false,
				reportFileName : 'report.html',
				logFileName : 'log.html',
				passThreshold : 97.0,
				unstableThreshold: 96.0,
				enableCache : true,
				otherFiles: '',
			])
			
			warnings canComputeNew: false, canResolveRelativePaths: false, categoriesPattern: '', defaultEncoding: '', excludePattern: '', healthy: '', includePattern: '', messagesPattern: '', parserConfigurations: [[parserName: 'PyLint', pattern: 'pylint.out']], unHealthy: ''
		}
}