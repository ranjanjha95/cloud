# Module 2: Authentication with Cognito

## Overview
Set up AWS Cognito User Pool and App Client for user authentication and authorization.

## 2.1 Create User Pool

1. Go to **AWS Cognito Console** → **User pools** → **Create user pool**
2. **Define your application**: Select **Single-page application (SPA)**
3. **Name your application**: Enter `ecommerce-app`
4. **Options for sign-in identifiers**: Select **Email**
5. **Required attributes for sign-up**: Select **email** and **name**
6. Click **Create user directory**

```bash
USER_POOL_ID=$(aws cognito-idp create-user-pool \
  --pool-name ecommerce-app \
  --auto-verified-attributes email \
  --username-attributes email \
  --schema '[{"Name":"email","Required":true},{"Name":"name","Required":true}]' \
  --query 'UserPool.Id' --output text)
echo "USER_POOL_ID=$USER_POOL_ID"
```

## 2.2 Configure App Client

- Go to your User Pool → **App integration** tab → **App clients**
- Enable: **ALLOW_USER_PASSWORD_AUTH**, **ALLOW_USER_SRP_AUTH**, **ALLOW_REFRESH_TOKEN_AUTH**

```bash
CLIENT_ID=$(aws cognito-idp create-user-pool-client \
  --user-pool-id $USER_POOL_ID \
  --client-name ecommerce-app \
  --no-generate-secret \
  --explicit-auth-flows ALLOW_USER_PASSWORD_AUTH ALLOW_USER_SRP_AUTH ALLOW_REFRESH_TOKEN_AUTH \
  --query 'UserPoolClient.ClientId' --output text)
echo "CLIENT_ID=$CLIENT_ID"
```

## Save These Values
- **User Pool ID** (e.g., `ap-south-1_xxxxxxxxx`)
- **App Client ID** (e.g., `1a2b3c4d5e6f7g8h9i0j1k2l3m`)

## Next Steps
Proceed to **[Module 3: Frontend Deployment](./module03-frontend-deployment.md)**
