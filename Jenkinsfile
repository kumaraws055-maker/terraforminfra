pipeline {
    agent any
    
    triggers {
        githubPush()     // allows auto trigger via GitHub webhook
    }

    stages {

        stage('SCM Checkout') {
            steps {
                checkout scm
                echo "Sources checked out from GitHub"
            }
        }

        stage('Check Terraform Installed') {
            steps {
                sh 'terraform version'
            }
        }

        stage('Select Terraform Action') {
            steps {
                script {
                    // Wait for user input for up to 15 minutes
                    timeout(time: 15, unit: 'MINUTES') {
                        TERRAFORM_ACTION = input(
                            id: "actionInput", 
                            message: "Select Terraform Action to perform:",
                            parameters: [
                                choice(
                                    name: 'TERRAFORM_ACTION',
                                    choices: ['PLAN', 'APPLY', 'DESTROY'],
                                    description: 'Choose Terraform execution type'
                                )
                            ]
                        )
                    }
                }
                echo "User selected action: ${TERRAFORM_ACTION}"
            }
        }

        stage('Terraform PLAN') {
            when { expression { return TERRAFORM_ACTION == 'PLAN' } }
            steps {
                sh '''
                    terraform init
                    terraform validate
                    terraform plan
                '''
            }
        }

        stage('Terraform APPLY') {
            when { expression { return TERRAFORM_ACTION == 'APPLY' } }
            steps {
                sh '''
                    terraform init
                    terraform validate
                    terraform apply --auto-approve
                '''
            }
        }

        stage('Terraform DESTROY') {
            when { expression { return TERRAFORM_ACTION == 'DESTROY' } }
            steps {
                sh '''
                    terraform init
                    terraform destroy --auto-approve
                '''
            }
        }
    }

    post {
        success {
            echo "Terraform Task Completed Successfully!"
        }
        failure {
            echo "Pipeline Failed!"
        }
        aborted {
            echo "Pipeline Aborted (timeout or manual stop)!"
        }
    }
}
