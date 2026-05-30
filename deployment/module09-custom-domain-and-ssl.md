# Module 9: Custom Domain & SSL 

## Overview
Access application using Custom domain name and enable HTTPS with SSL certificate

## Prerequisites
- A registered public domain name
- Amazon Route 53 configured as DNS provider

## 9.1 Route 53 Public Hosted Zone

1. Route53 Console → Hosted zones → Create hosted zone
2. Domain name: `yourdomain.com`, Type: Public hosted zone
3. Note the 4 nameservers and update at your domain registrar

## 9.2 Request SSL Certificate in ACM

**IMPORTANT:** Certificate must be in **us-east-1** region for CloudFront!

1. ACM Console → Switch to us-east-1 → Request certificate
2. Domain names: `yourdomain.com`, `www.yourdomain.com`
3. DNS validation
4. Click "Create records in Route53" to auto-validate

## 9.3 Add alternate domain name for CloudFront

1. CloudFront Console → Your distribution → Edit
2. Alternate domain names: Add `yourdomain.com` and `www.yourdomain.com`
3. Custom SSL certificate: Select your ACM certificate

## 9.4 Create Route53 Records

Create A records (Alias) pointing to your CloudFront distribution for both root domain and `www`.

## 9.5 Update Cognito Callback URLs

Add `https://yourdomain.com` and `https://www.yourdomain.com` to Cognito app client callback/sign-out URLs.

## 9.6 Test

Open `https://yourdomain.com` and verify SSL certificate is valid.

## Next Steps
Proceed to **[Module 10: Cleanup](./module10-cleanup.md)**
