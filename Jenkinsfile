properties([ parameters([
  string( name: 'AWS_ACCESS_KEY_ID', defaultValue: 'AKIARCIVPQFCGAI6EZNM'),
  string( name: 'AWS_SECRET_ACCESS_KEY', defaultValue: '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'),
  string( name: 'AWS_REGION', defaultValue: 'ap-southeast-2'),
]), pipelineTriggers([]) ])

// Environment Variables.
env.access_key = AWS_ACCESS_KEY_ID
env.secret_key = AWS_SECRET_ACCESS_KEY
env.aws_region = AWS_REGION


pipeline {
    agent any
    stages {
         stage ('Terraform Init'){
            steps {
            sh "export TF_VAR_aws_region='${env.aws_region}' && terraform init"
          }
       }
         stage ('Terraform Plan'){
            steps {
            sh "export TF_VAR_aws_region='${env.aws_region}' && export TF_LOG=DEBUG && terraform plan" 
         }
      }
         stage ('Terraform Apply & Deploy Docker Image on Webserver'){
            steps {
            sh "export TF_VAR_aws_region='${env.aws_region}' && export TF_LOG=DEBUG && terraform apply -auto-approve"
        }
      }
    }
  }
