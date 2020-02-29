def appName = ""
def appVersion = ""


node('dockerAgent'){
    tool name: 'maven', type: 'maven'
    stage('Check prerequests'){
        withEnv(["PATH=${env.PATH}:${tool 'maven'}/bin"]){
            sh 'env | grep PATH'
//          echo "${tool 'maven'}"
            sh 'mvn -v'
        }
    }
    stage('Get sources'){
        git(url: 'git@github.com:jenkins-docs/simple-java-maven-app.git', branch: "master", credentialsId: 'git')
    }
    stage('Build'){
        withEnv(["PATH=${env.PATH}:${tool 'maven'}/bin"]){
            sh 'mvn -B -DskipTests clean package'
            appName = sh(script: 'mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.name', returnStdout: true).trim()
            appVersion = sh(script: "mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.version", returnStdout: true).trim()
        }        
    }
    stage('Test'){
        withEnv(["PATH=${env.PATH}:${tool 'maven'}/bin"]){
            sh 'mvn test'
            stash includes: 'target/my-app-1.0-SNAPSHOT.jar', name: 'artifactStash'
        }        
    }
}
node('dockerAgent1'){
    tool name: 'docker-latest', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
    stage('Ckeck prerequest'){
        echo "${tool name: 'docker-latest'}"
        sh "ls -lah"
        withEnv(["PATH=${env.PATH}:${tool name: 'docker-latest'}/bin"]){
            sh 'docker -v'
        } 
    }
    stage('unstash our application'){
        unstash 'artifactStash'
    }
    stage('Get Dockerfile'){
        echo appName
        echo appVersion
    }
}