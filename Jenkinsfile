pipeline {
    agent none
    environment {
        // SBT='/home/ubuntu/jenkins/tools/org.jvnet.hudson.plugins.SbtPluginBuilder_SbtInstallation/sbt/bin/sbt'
        registry = 'pratik977/akkahttp'
    }
    stages {
        // stage ('Installation......') {
        //     agent {
        //         label 'Linux'
        //     }
        //     steps {
        //         tool name: 'sbt', type: 'org.jvnet.hudson.plugins.SbtPluginBuilder$SbtInstallation'                
        //     }
        // } 
        stage ('Compilation.....') {
            // agent {
            //     label 'Linux'
            // }
            steps {
                sh 'sbt clean compile'
                echo "Successfully compiled"
            }
        }
        stage ('Testing......'){
            // agent {
            //     label 'Linux'
            // }
            steps{
                sh 'sbt test'
                echo "Successfully compiled"
            }
        }
        stage ('Packaging'){
            // agent {
            //     label 'Linux'
            // }
            steps{
                sh 'sbt assembly'
                echo "Successfully compiled"
            }

        }
        stage ('Image Build'){
            when {
                branch 'master'
            }
            steps{
                sh 'docker build -t $registry:$BUILD_NUMBER'
                echo "Image Build successfull"
            }
        }
        stage ('Image Push') {
            when {
                branch 'master'
            }
            steps{
                withDockerRegistry([ credentialsId: "dockerhub_credential", url: "" ]) {
                    sh 'docker push $registry:$BUILD_NUMBER'
                }
            }
        }
        stage ('Removing local image') {
            when {
                branch 'master'
            }
            steps{
                sh 'docker rmi $registry:$BUILD_NUMBER'
            }
        }
    }
}