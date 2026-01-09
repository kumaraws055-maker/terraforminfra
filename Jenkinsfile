pipeline {
    agent any 
    parameters {
        choice(name: 'TERRAFORM_ACTION',  
        choices: ['PLAN','APPLY','DESTROY'], 
        description: 'Select packer action')
    }
   stages {
        stage('scm checkout'){
            steps{
                sh ' echo " accessing the github repo" '
                checkout scm
            }
        }
        stage('Checking the required application'){
            steps{
                sh 'terraform version'
            }
        }
        stage('Terraform_Plan'){
         when {
                expression { params.TERRAFORM_ACTION == 'PLAN' }
            }
            steps{
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform plan'
            }
    }
    stage('Terrafor_Apply'){
         when {
                expression { params.TERRAFORM_ACTION == 'APPLY' }
            }
            steps{
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply --auto-approve'
            }
    }
        stage('Terrafor_Destory'){
         when {
                expression { params.TERRAFORM_ACTION == 'DESTROY' }
            }
            steps{
                sh 'terraform init'
                sh 'terraform destroy --auto-approve'
            }
        }

    }
}