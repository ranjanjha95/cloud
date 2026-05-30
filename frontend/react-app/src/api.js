import awsConfig from './aws-config';

const API_BASE_URL = awsConfig.API.baseUrl || process.env.REACT_APP_API_URL || 'http://localhost:8080/api';

const getAuthHeaders = async () => {
  try {
    const { fetchAuthSession } = await import('aws-amplify/auth');
    const session = await fetchAuthSession();
    const token = session.tokens?.idToken?.toString();
    if (token) {
      const payload = session.tokens?.idToken?.payload;
      return {
        'Authorization': `Bearer ${token}`,
        'X-User-Id': payload?.sub || '',
        'X-User-Email': payload?.email || '',
        'X-User-Name': payload?.name || payload?.username || ''
      };
    }
    return {};
  } catch (error) {
    return {};
  }
};

export const api = {
  getProducts: () => fetch(`${API_BASE_URL}/products`).then(res => res.json()),
  getProduct: (id) => fetch(`${API_BASE_URL}/products/${id}`).then(res => res.json()),
  getCart: async () => {
    const headers = await getAuthHeaders();
    return fetch(`${API_BASE_URL}/cart`, { headers }).then(res => res.json());
  },
  addToCart: async (productId, quantity, price) => {
    const headers = await getAuthHeaders();
    return fetch(`${API_BASE_URL}/cart/items`, {
      method: 'POST',
      headers: { ...headers, 'Content-Type': 'application/json' },
      body: JSON.stringify({ product_id: productId, quantity, price })
    }).then(res => res.json());
  },
  removeFromCart: async (productId) => {
    const headers = await getAuthHeaders();
    return fetch(`${API_BASE_URL}/cart/items/${productId}`, { method: 'DELETE', headers }).then(res => res.json());
  },
  createOrder: async () => {
    const headers = await getAuthHeaders();
    return fetch(`${API_BASE_URL}/orders`, {
      method: 'POST',
      headers: { ...headers, 'Content-Type': 'application/json' },
      body: JSON.stringify({})
    }).then(res => res.json());
  },
  getOrders: async () => {
    const headers = await getAuthHeaders();
    return fetch(`${API_BASE_URL}/orders`, { headers }).then(res => res.json());
  },
  getProfile: async () => {
    const headers = await getAuthHeaders();
    return fetch(`${API_BASE_URL}/users/profile`, { headers }).then(res => res.json());
  },
  createProfile: async (email, name) => {
    const headers = await getAuthHeaders();
    const { fetchAuthSession } = await import('aws-amplify/auth');
    const session = await fetchAuthSession();
    const userId = session.tokens?.idToken?.payload?.sub;
    return fetch(`${API_BASE_URL}/users/profile`, {
      method: 'POST',
      headers: { ...headers, 'Content-Type': 'application/json' },
      body: JSON.stringify({ cognito_sub: userId, email, name })
    }).then(res => res.json());
  },
};
