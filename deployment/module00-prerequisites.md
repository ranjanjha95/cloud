# Module 0: Prerequisites

## Overview
Ensure you have the required tools and access before starting the AWS deployment.

## Prerequisites

### 1. AWS Account
- An AWS account with administrative access
- AWS CLI configured with Access Key ID and Secret Access Key

### 2. Required Tools
- **Git** — version control
- **Docker** — container runtime
- **Node.js 20+** and **npm** — for building the React frontend
- **AWS CLI v2** — for interacting with AWS services

## Step 1: Clone Repository

```bash
git clone https://github.com/awswithchetan/ecommerce-web-app.git
cd ecommerce-web-app
```

## Step 2: Install Required Tools

```bash
bash install-prerequisites.sh
```

## Step 3: Verify Tool Installation

```bash
aws --version
docker --version
node --version
npm --version
git --version
```

## Step 4: Configure AWS CLI

```bash
aws configure
```

```
AWS Access Key ID [None]: <your-access-key-id>
AWS Secret Access Key [None]: <your-secret-access-key>
Default region name [None]: ap-south-1
Default output format [None]: json
```

## Step 5: Set Default Region

```bash
export AWS_DEFAULT_REGION=ap-south-1
```

## Next Steps
Proceed to **[Module 1: Networking Foundation](./module01-networking.md)**
