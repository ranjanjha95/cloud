const awsConfig = {
  Auth: {
    Cognito: {
      userPoolId: 'YOUR_USER_POOL_ID',
      userPoolClientId: 'YOUR_USER_POOL_CLIENT_ID',
      loginWith: {
        email: true,
      },
    }
  },
  API: {
    baseUrl: 'YOUR_API_GATEWAY_URL'
  }
};

export default awsConfig;
