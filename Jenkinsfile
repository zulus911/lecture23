
node('dockerAgent'){
    stage('Check prerequests'){
        withMaven(maven: 'maven'){
            sh 'mvn -v'
        }
    }
}