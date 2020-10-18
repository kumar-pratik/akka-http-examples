pipeline {
    agent any
    environment {
        // SBT='/home/ubuntu/jenkins/tools/org.jvnet.hudson.plugins.SbtPluginBuilder_SbtInstallation/sbt/bin/sbt'
        registry = 'pratik977/akkahttp'
    }
    // triggers {
    //     pollSCM 'H/5 * * * *'
    // }
    stages {
        stage ('Compilation.....') {
            steps {
                sh 'sbt clean compile'
                echo "Successfully compiled"
            }
        }
        stage ('Testing......') {
            steps{
                sh 'sbt test'
                echo "Successfully compiled"
            }
        }
        stage ('Packaging'){
            steps{
                sh 'sbt assembly'
                echo "Successfully compiled"
                archiveArtifacts artifacts: 'target/scala-2.11/*.jar', fingerprint: true, followSymlinks: false, onlyIfSuccessful: true
            }

        }
        stage ('Deploy'){
            when {
                branch 'master'
            }
            stages{
                stage('Image Build') {
                    steps{
                        sh 'docker build -t $registry:$BUILD_NUMBER'
                        echo "Image Build successfull"
                    }
                }
                stage ('Image Push') {
                    steps{
                        withDockerRegistry([ credentialsId: "dockerhub_credential", url: "" ]) {
                            sh 'docker push $registry:$BUILD_NUMBER'
                        }
                    }
                }
                stage ('Removing local image') {
                    steps{
                        sh 'docker rmi $registry:$BUILD_NUMBER'
                    }
                }
            }
            
        }
        
        
    }
    post {
        always {
            emailext to: 'kumar.pratik@knoldus.com',
                 subject: "Pipeline: ${currentBuild.fullDisplayName} is ${currentBuild.currentResult}",
                 body: "For complete detail goto ${BUILD_URL}",
                 attachLog: true
        }
    }
}
