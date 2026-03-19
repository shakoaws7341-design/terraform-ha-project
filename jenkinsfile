pipeline {
  agent any

  stages {

    stage('Terraform Init') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds'
        ]]) {
          dir('terraform') {
            sh 'terraform init'
          }
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds'
        ]]) {
          dir('terraform') {
            sh 'terraform apply -auto-approve'
          }
        }
      }
    }

  }
}
