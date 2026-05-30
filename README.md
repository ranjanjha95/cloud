# Let's Build on AWS series - eCommerce Application
This repo is a part of my course on Udemy where I have explained the architecture in detail and demonstrated complete deployment process. 

Course Link: https://www.udemy.com/course/build-ecommerce-application-on-aws/?referralCode=361CDE8C3A9653255373

## My mission
My mission is simple — to bridge the gap between learning and real-world execution. Every course and project I build is designed with one goal - to make you truly industry-ready, not just conceptually aware.

**Author**: [Chetan Agrawal](https://in.linkedin.com/in/chetan-agrawal-30107310)

**Website**: [www.awswithchetan.com](https://www.awswithchetan.com)

## Table of Contents

- [Architecture Overview](#architecture-overview)
- [Project Structure](#project-structure)
- [Cost Estimates](#cost-estimates)
- [Getting Started](#getting-started)

## Architecture Overview

This project demonstrates a complete cloud-native microservices based application.

### AWS Services
- **Frontend**: S3 + CloudFront + Route53
- **API Layer**: API Gateway (HTTP API) + VPC Link + ALB
- **Compute**: ECS/Fargate
- **Authentication**: Cognito User Pools
- **Databases**: DynamoDB and RDS PostgreSQL
- **Messaging**: SNS + SQS (+SES)
- **Networking**: VPC, Subnets, Security Groups, NAT Gateway
- **Logs and Management**: CloudWatch, Systems Manager
- **Security**: IAM

## Project Structure

```
ecommerce-web-app/
├── services/                    # Backend microservices
│   ├── product-service/         # Python FastAPI
│   ├── cart-service/            # Python FastAPI
│   ├── user-service/            # Python FastAPI
│   └── order-service/           # Python FastAPI
├── frontend/
│   └── react-app/               # React application
├── data/                        # Product data + S3 upload scripts
├── deployment/                  # AWS deployment guides
│   ├── README.md                # Deployment overview
│   └── module*.md               # Step-by-step modules
└── install-prerequisites.sh     # Tool installation script
```

### Microservices
- **Product Service** - Product catalog management (DynamoDB)
- **Cart Service** - Shopping cart operations (DynamoDB)  
- **User Service** - User profile management (RDS PostgreSQL)
- **Order Service** - Order processing and orchestration (RDS PostgreSQL)
- **Notification Service** - Asynchronous email notifications (SNS/SQS/SES)

## Getting Started

1. Proceed to [AWS Deployment](deployment/README.md)
2. Clean up resources after learning

Happy Learning!
