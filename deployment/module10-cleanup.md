# Module 10: Cleanup

## Overview
Clean up all AWS resources created during this project to avoid ongoing charges.

## Cleanup Order

Delete resources in reverse order of creation:

1. **DNS & SSL (Module 9)** - Route53 records, ACM certificate, hosted zone
2. **Notification (Module 8)** - SNS subscriptions, SQS queue, SNS topic
3. **API Gateway (Module 6)** - HTTP API, VPC Link
4. **ECS Services & Cluster (Module 5)** - Services, cluster, task definitions
5. **ECR Repositories (Module 5)** - Container image repos
6. **ALB & Target Groups (Module 5)** - Load balancer, target groups
7. **IAM Roles (Module 5)** - ECS task role
8. **RDS Database (Module 4)** - DB instance, subnet group
9. **DynamoDB & Parameter Store (Module 4)** - Tables, SSM parameters
10. **CloudFront & S3 (Module 3)** - Distribution, S3 bucket
11. **Cognito (Module 2)** - User Pool
12. **Networking (Module 1)** - NAT Gateway, IGW, subnets, route tables, security groups, VPC

## CLI Cleanup Commands

### Notification
```bash
SNS_TOPIC_ARN=$(aws sns list-topics --query "Topics[?ends_with(TopicArn, ':ecommerce-order-events')].TopicArn" --output text)
aws sns delete-topic --topic-arn $SNS_TOPIC_ARN
SQS_QUEUE_URL=$(aws sqs get-queue-url --queue-name ecommerce-order-shipping --query 'QueueUrl' --output text)
aws sqs delete-queue --queue-url $SQS_QUEUE_URL
```

### ECS
```bash
for SVC in product-service cart-service user-service order-service; do
  aws ecs update-service --cluster ecommerce-cluster --service ecommerce-$SVC --desired-count 0 > /dev/null
  aws ecs delete-service --cluster ecommerce-cluster --service ecommerce-$SVC --force > /dev/null
done
aws ecs delete-cluster --cluster ecommerce-cluster > /dev/null
```

### RDS
```bash
aws rds delete-db-instance --db-instance-identifier ecommercedb-instance --skip-final-snapshot > /dev/null
aws rds wait db-instance-deleted --db-instance-identifier ecommercedb-instance
```

### DynamoDB
```bash
aws dynamodb delete-table --table-name ecommerce-products > /dev/null
aws dynamodb delete-table --table-name ecommerce-cart > /dev/null
```

### VPC
```bash
VPC_ID=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=ecommerce-vpc" --query 'Vpcs[0].VpcId' --output text)
# Delete NAT Gateway, IGW, subnets, route tables, security groups, then VPC
aws ec2 delete-vpc --vpc-id $VPC_ID
```
