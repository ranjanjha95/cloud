# Module 7: Frontend-Backend Integration

## Overview
Update the React application with the API Gateway URL, rebuild, and redeploy to S3.

## 7.1 Update frontend with API Gateway URL

Edit `frontend/react-app/src/aws-config.js`:
```javascript
const awsConfig = {
  Auth: {
    Cognito: {
      userPoolId: '<COGNITO_USER_POOL_ID>',
      userPoolClientId: '<COGNITO_CLIENT_ID>',
      loginWith: { email: true },
    }
  },
  API: {
    baseUrl: '<API_GATEWAY_URL>'  // e.g., https://xxxxxxxxxx.execute-api.us-east-1.amazonaws.com
  }
};
export default awsConfig;
```

## 7.2 Rebuild and redeploy to S3

```bash
npm run build
aws s3 sync build/ s3://<your-frontend-bucket-name> --delete --exclude "images/*"
```

## 7.3 Invalidate CloudFront Cache

```bash
aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths "/*"
```

## 7.4 Test the Application

Open your CloudFront URL and test:
- Login / signup (Cognito)
- Product listing loads
- Add items to cart
- Place order
- View order history

## Next Steps
Proceed to **[Module 8: Notification](./module08-notification.md)**
