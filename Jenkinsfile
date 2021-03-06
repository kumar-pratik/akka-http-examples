pipeline {
    agent any
    environment {
        registry = 'pratik977/akkahttp'
    }
    stages {
        stage ('Compilation.....') {
            steps {
                sh 'sbt clean compile'
                echo "######Successfully compiled##################"
            }
        }
        stage ('Testing......') {
            steps{
                sh 'sbt test'
                echo "##########Successfully tested###################"
            }
        }
        stage ('Packaging.......'){
            when { anyOf { branch 'master'; branch 'development' } }
            steps{
                sh 'sbt assembly'
                archiveArtifacts artifacts: 'target/scala-2.11/*.jar', fingerprint: true, followSymlinks: false, onlyIfSuccessful: true
                echo "##########Successfully archived##################"
            }

        }
        stage ('Deploy.........'){
            when {
                branch 'master'
            }
            stages{
                stage('Image Build.......') {
                    steps{
                        sh 'docker build -t $registry:$BUILD_NUMBER .'
                        echo "Image Build successfull"
                    }
                }
                stage ('Image Push........') {
                    steps{
                        withDockerRegistry([ credentialsId: "dockerhub_credential", url: "" ]) {
                            sh 'docker push $registry:$BUILD_NUMBER'
                        }
                        echo "Image Successfully pushed to registry"
                    }
                }
                stage ('Removing local image') {
                    steps{
                        sh 'docker rmi $registry:$BUILD_NUMBER'
                    }
                }
                stage ('Final Deployment') {
                    steps{
                        emailext to: 'kumar.pratik@knoldus.com',
                            subject: "Input needed for Job ${JOB_NAME}",
                            body: "Please verify the deployment at ${BUILD_URL}"
                        echo "Email sent"
                        input 'proceed to deploy'
                        sh 'sudo ansible-playbook site.yml --extra-vars image=$registry:$BUILD_NUMBER'
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
