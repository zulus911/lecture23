def appName = "my-app"
def appVersion = "1.0-SNAPSHOT"


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
        git(url: 'git@uni.ssny.us:civicom-downstream/emblem.git', branch: "develop", credentialsId: 'git')
    }
    stage('Build'){
        withEnv(["PATH=${env.PATH}:${tool 'maven'}/bin"]){
            sh 'cd emblem && mvn -B -DskipTests clean package'
        }        
    }
    stage('Test'){
        withEnv(["PATH=${env.PATH}:${tool 'maven'}/bin"]){
            sh 'cd emblem && mvn test'
        }        
    }
}
