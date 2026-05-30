# Module 8: Notification and Integration (SNS and SQS)

## Overview
Set up event driven flows using Amazon SNS and SQS for order notifications.

## In this module
- Create SNS topic for order events
- Create SQS queue for order shipping
- Configure SNS subscriptions (Email + SQS)
- Update Parameter Store with SNS Topic ARN
- Test the notification workflow

## 7.1 Create SNS Topic

1. **SNS Console → Topics → Create topic**
2. **Type:** Standard
3. **Name:** `ecommerce-order-events`
4. **Create topic** and copy the **Topic ARN**

```bash
SNS_TOPIC_ARN=$(aws sns create-topic \
  --name ecommerce-order-events \
  --query 'TopicArn' --output text)
echo "SNS_TOPIC_ARN=$SNS_TOPIC_ARN"
```

## 7.2 Create SQS Queue

1. **SQS Console → Queues → Create queue**
2. **Name:** `ecommerce-order-shipping`

```bash
SQS_QUEUE_URL=$(aws sqs create-queue --queue-name ecommerce-order-shipping --query 'QueueUrl' --output text)
SQS_QUEUE_ARN=$(aws sqs get-queue-attributes --queue-url $SQS_QUEUE_URL --attribute-names QueueArn --query 'Attributes.QueueArn' --output text)
```

## 7.3 Configure SNS Subscriptions

**Email:**
1. Create subscription → Protocol: Email → Endpoint: your email
2. Confirm the subscription email

**SQS:**
1. Create subscription → Protocol: Amazon SQS → Endpoint: SQS queue ARN

```bash
aws sns subscribe --topic-arn $SNS_TOPIC_ARN --protocol email --notification-endpoint your-email@example.com
aws sns subscribe --topic-arn $SNS_TOPIC_ARN --protocol sqs --notification-endpoint $SQS_QUEUE_ARN
```

## 7.4 Update Parameter Store

1. **SSM Console → Parameter Store → Create parameter**
2. **Name:** `/ecommerce/dev/sns/topic-arn`
3. **Value:** your SNS Topic ARN

```bash
aws ssm put-parameter --name /ecommerce/dev/sns/topic-arn --type String --value $SNS_TOPIC_ARN
```

## 7.5 Restart Order Service

```bash
aws ecs update-service --cluster ecommerce-cluster --service ecommerce-order-service --force-new-deployment
```

## 7.6 Test Notification Workflow

1. Place an order through the frontend
2. Check email for order notification
3. Verify messages in SQS queue

## Next Steps
Proceed to **[Module 9: Custom Domain & SSL](./module09-custom-domain-and-ssl.md)**
