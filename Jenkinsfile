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
            appName = sh(script: "grep 'name' pom.xml | awk -F'name' '{print \$2}' | tr -d '<' | tr -d '>' tr -d '/'", returnStdout: true).trim()
            appVersion = sh(script: "grep 'version' pom.xml | awk -F'version' '{print \$2}' | tr -d '<' | tr -d '>' tr -d '/'", returnStdout: true).trim()
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