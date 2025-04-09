---
title: "AWS Projects"
datePublished: Fri Mar 07 2025 07:35:37 GMT+0000 (Coordinated Universal Time)
cuid: cm7ygo5p7000g09l8b4o53wdq
slug: devops-and-ci-cd
ogImage: https://cdn.hashnode.com/res/hashnode/image/upload/v1741473539765/aab90a29-4bbe-4dd0-b66f-ef87ef40f76a.webp
tags: lambda, apis, terraform, infrastructure-as-code, my-projects

---

This project demonstrates how to build a simple, serverless API using AWS Lambda and API Gateway. The goal is to create an API endpoint that returns the client's IP address using the (X-Forwarded-For header) from incoming HTTP requests. The project utilizes AWS services to handle the backend logic and exposes the Lambda function through a scalable HTTP API using API Gateway.

I used Terraform for creation of this serverless infrastructure and the steps I went for creation are as below:

1. I used VSCode and created a directory (Lambda-api) and inside that I created my [main.tf](http://main.tf) for terraform and another folder (Lambda) including [lambda.py](http://lambda.py) file.
    
2. Inside my [lambda.py](http://lambda.py) I used (def lambda\_handler(event, context):) and at the end return statuscode 200 to return the IP.
    
3. In Terraform file [main.tf](http://main.tf) I did below steps: a- Provider for terraform b- data "archive\_file" for our [lambda.zip](http://lambda.zip) c- resources for creation of structure like, IAM Role, Lambda Functions, apigateway, apigateway\_stage, gateway integration, apigateway\_route and lambda\_permission.
    

4- After my code completed I used terraform commands as below:

a- terraform init: for downloading the plugins

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1741471543945/cf2ac804-4668-47c7-8966-551c86d50e7d.png align="center")

b- terraform fmt: for format of my code

c- terraform validate: for validation of my code syntax based on terraform requirements

d- terraform plan: to see the planned infrastructure and possible mistakes inside the code

e- terraform apply: to create our infrustructure

f- terraform destroy for destroying infrastructure to prevent from costs

5- when the serverless infrastructure created

a- I opened my AWS Consule and navigated to Lambda and then function there was a function with the name of lambda-function created as I defined in my VSCode for terraform.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1741471372702/4513235e-45d7-4e3e-b0d7-40bc38d78e47.png align="center")

b- then I opend the function I saw the Python code which I defined in my VSCode for terraform

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1741471859516/2b8c7373-5064-4a56-b8b7-8b2b8166e3ef.png align="center")

c- and I went to api gateway and there was also an api created with the name which I specified in my code

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1741471967874/ebdb1540-a859-4ecd-9ca5-caefbb1b4a8b.png align="center")

d- finally I got the URL and opened in my browser and api returned the IP as below:

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1741472127846/46962bfd-2a59-4ee4-9cbc-036f9062611b.png align="center")

**Key Components:** AWS Lambda: The backend function that processes HTTP requests and extracts the client's IP address from the X-Forwarded-For header. API Gateway: Exposes the Lambda function as an HTTP endpoint. Requests are routed through API Gateway and trigger the Lambda function. IAM Role: Grants the necessary permissions for Lambda to be invoked by API Gateway. API Gateway Integration: AWS Proxy integration links the API Gateway route to the Lambda function, allowing dynamic request handling.

**Usecases:**

This project is a great example of a serverless architecture where you don’t need to manage servers. It's ideal for scenarios like returning user-specific data (like IP address), handling simple backend logic, and creating scalable APIs without worrying about infrastructure.