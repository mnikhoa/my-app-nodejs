pipeline {
    agent any
    stages {
        stage("build") {
            steps {
                echo 'building the application...'

                script {
                    def test = 1 > 0 ? 'good' : 'bad'
                    echo test
                }
            }
        }
        stage("test") {
            steps {
                echo 'testing the application...'
            }
        }
        stage("deploy") {
            steps {
                echo 'deploying the application...'
            }
        }
    }
}
