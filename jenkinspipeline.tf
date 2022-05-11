pipeline{
    agent any
    tools {
        terraform 'terraform'
    }
    stages {
      stage('Git Checkout')  {
          steps {
              git branch: 'main', credentialised: 'github', url: 'https://github.com/arikrishnangit/jenkinspipeline.git'
          }
      }
      stage('TF Init&Plan') {
       steps {
         sh 'terraform init'
         sh 'terraform plan'
          }
      }
      stage('Approval') {
            steps {
              script {
                def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
              }
            }
          }
        stage('TF Apply') {
        steps {
          sh 'terraform apply -input=false'
        }
      }
    }
  }
