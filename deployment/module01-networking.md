# Module 1: Networking Foundation

## Overview
Create VPC infrastructure with public and private subnets across 2 availability zones.

## In this module
- **VPC** - Virtual Private Cloud with 10.10.0.0/16 CIDR
- **Public Subnets** - 2 subnets for internet-facing resources
- **Private ECS Subnets** - 2 subnets for application services
- **Private Database Subnets** - 2 subnets for RDS instances
- **Internet Gateway** - Internet access for public subnets
- **NAT Gateway** - Outbound internet access for private subnets
- **Route Tables** - Traffic routing configuration

## Subnet Layout

| Subnet Type | Name | CIDR | AZ |
|-------------|------|------|----|
| Public | ecommerce-public-subnet-1 | 10.10.0.0/24 | ap-south-1a |
| Public | ecommerce-public-subnet-2 | 10.10.1.0/24 | ap-south-1b |
| Private ECS | ecommerce-private-ecs-1 | 10.10.10.0/24 | ap-south-1a |
| Private ECS | ecommerce-private-ecs-2 | 10.10.11.0/24 | ap-south-1b |
| Private DB | ecommerce-private-database-1 | 10.10.20.0/24 | ap-south-1a |
| Private DB | ecommerce-private-database-2 | 10.10.21.0/24 | ap-south-1b |

## 1.1: Create VPC

1. **VPC Console → Your VPCs → Create VPC**
2. **Name:** `ecommerce-vpc`
3. **IPv4 CIDR block:** `10.10.0.0/16`
4. **Create VPC**

```bash
VPC_ID=$(aws ec2 create-vpc --cidr-block 10.10.0.0/16 --query 'Vpc.VpcId' --output text)
aws ec2 create-tags --resources $VPC_ID --tags Key=Name,Value=ecommerce-vpc
echo "VPC_ID=$VPC_ID"
```

## 1.2: Create Internet Gateway

1. **VPC Console → Internet Gateways → Create internet gateway**
2. **Name:** `ecommerce-igw`
3. **Actions → Attach to VPC → ecommerce-vpc**

```bash
IGW_ID=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
aws ec2 create-tags --resources $IGW_ID --tags Key=Name,Value=ecommerce-igw
aws ec2 attach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID
```

## 1.3: Create Subnets

Create all 6 subnets from the table above using VPC Console or CLI.

## 1.4: Create NAT Gateway

1. **VPC Console → NAT Gateways → Create NAT gateway**
2. **Name:** `ecommerce-nat-gateway`
3. **Subnet:** ecommerce-public-subnet-1
4. **Allocate Elastic IP**

```bash
EIP_ALLOC=$(aws ec2 allocate-address --domain vpc --query 'AllocationId' --output text)
NAT_GW_ID=$(aws ec2 create-nat-gateway --subnet-id $PUB_SUBNET_1 --allocation-id $EIP_ALLOC --query 'NatGateway.NatGatewayId' --output text)
aws ec2 wait nat-gateway-available --nat-gateway-ids $NAT_GW_ID
```

## 1.5: Create Route Tables

- **Public RT:** Route `0.0.0.0/0` → Internet Gateway, associate public subnets
- **Private ECS RT:** Route `0.0.0.0/0` → NAT Gateway, associate ECS subnets
- **Private DB RT:** No internet route, associate DB subnets

## Next Steps
Proceed to **[Module 2: Authentication](./module02-cognito-authentication.md)**
