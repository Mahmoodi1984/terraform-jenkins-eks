# terraform-jenkins-eks
Infrastructure as Code and Jenkins CI/CD Automation :
code magic plan to Code,to build  to test to deploy the infrastructure on AWS

this project has two phases:
1- What we want to do is creation of infrastructure in AWS by using Terraform as Intrastructure as Code and then deploying
   it to the infrastructure.

   1.1- Create EC2 Instance + Jenkins
   1.2- write tf code for EKS cluster
   1.3- push the code on Gihtub
   1.4- Create jenkins pipeline to EKS cluster
   1.5- Deploy the changes to AWS
2-I created one directory and inside that I have created to more directories one for Jenkins server and one for EKS.
   2.1- inside the jenkins-server directory I created main.tf to define my
   2.2- at the end I created the pipeline using Terraform(IaC) and used jenkins for our pipeline to create our cluster in AWS.
   you can see all photos of my project in my website: www.mahmoodi-tech.cloud
