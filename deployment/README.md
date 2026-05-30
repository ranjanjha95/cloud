# AWS Deployment Guide - Ecommerce Application

## Overview
This guide walks you through deploying a production-ready microservices ecommerce application on AWS.

## Deployment Modules

### [Module 0: Prerequisites](./module00-prerequisites.md)
**Time:** 10-15 minutes
- Clone this repository, install required tools, configure AWS credentials

### [Module 1: Networking Foundation](./module01-networking.md)
**Time:** 15-20 minutes
- VPC, Subnets, Internet Gateway, NAT Gateway, Route Tables

### [Module 2: Authentication](./module02-cognito-authentication.md)
**Time:** 5-10 minutes
- Cognito User Pools, JWT token management

### [Module 3: Frontend Deployment](./module03-frontend-deployment.md)
**Time:** 20 minutes
- S3, CloudFront

### [Module 4: Data Layer](./module04-data-layer.md)
**Time:** 20-30 minutes
- DynamoDB, RDS PostgreSQL, S3

### [Module 5: Container Deployment](./module05-backend-deployment.md)
**Time:** 45-60 minutes
- ECR, ECS, Fargate, Internal ALB, Parameter Store

### [Module 6: API Gateway](./module06-api-gateway.md)
**Time:** 30-45 minutes
- API Gateway, VPC Link

### [Module 7: Frontend-Backend Integration](./module07-frontend-backend-integration.md)
**Time:** 10-15 minutes
- Configure aws-config.js, rebuild and deploy React app

### [Module 8: Event-Driven Architecture](./module08-notification.md)
**Time:** 15 minutes
- SNS, SQS

### [Module 9: DNS & SSL](./module09-custom-domain-and-ssl.md)
**Time:** 20-30 minutes (Optional)
- Route53, Certificate Manager

### [Module 10: Cleanup](./module10-cleanup.md)
**Time:** 10-15 minutes
- Remove all AWS resources

## Let's get started
Begin with **[Module 0: Pre-requisites](./module00-prerequisites.md)**.
