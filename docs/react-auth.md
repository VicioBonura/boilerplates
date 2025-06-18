# React Context e Autenticazione

## Setup Autenticazione Completa

### Tipi TypeScript
```typescript
// types/auth.d.ts
export interface User {
  id: string;
  username: string;
  email?: string;
}

export interface AuthState {
  user: User | null;
  isAuthenticated: boolean;
  token: string | null;
}

export interface AuthContextType extends AuthState {
  login: (credentials: LoginCredentials) => Promise<void>;
  logout: () => void;
  getToken: () => string | null;
}

export interface LoginCredentials {
  username: string;
  password: string;
}

export interface RegisterCredentials extends LoginCredentials {
  email?: string;
}
```

### AuthContext Setup
```typescript
// contexts/AuthContext/AuthContext.ts
import { createContext, useContext } from 'react';
import { AuthContextType } from '../../types/auth';

const AuthContext = createContext<AuthContextType>({
  user: null,
  isAuthenticated: false,
  token: null,
  login: () => Promise.resolve(),
  logout: () => {},
  getToken: () => null,
});

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within AuthProvider');
  }
  return context;
};

export default AuthContext;
```

### AuthProvider Implementation
```typescript
// contexts/AuthContext/AuthProvider.tsx
import { useState, PropsWithChildren, useEffect } from 'react';
import { jwtDecode } from 'jwt-decode';
import AuthContext from './AuthContext';
import { AuthState, User, LoginCredentials } from '../../types/auth';
import { loginUser, registerUser } from '../../services/authApi';

export const AuthProvider = ({ children }: PropsWithChildren) => {
  const [state, setState] = useState<AuthState>(() => {
    // Inizializza da localStorage
    const token = localStorage.getItem('authToken');
    if (token) {
      try {
        const decoded = jwtDecode<User>(token);
        return {
          user: decoded,
          isAuthenticated: true,
          token: token,
        };
      } catch {
        localStorage.removeItem('authToken');
      }
    }
    return {
      user: null,
      isAuthenticated: false,
      token: null,
    };
  });

  const login = async (credentials: LoginCredentials) => {
    try {
      const { token } = await loginUser(credentials);
      const user = jwtDecode<User>(token);
      
      localStorage.setItem('authToken', token);
      setState({
        user,
        isAuthenticated: true,
        token,
      });
    } catch (error) {
      throw error; // Re-throw per gestione errori nel componente
    }
  };

  const logout = () => {
    localStorage.removeItem('authToken');
    setState({
      user: null,
      isAuthenticated: false,
      token: null,
    });
  };

  const getToken = () => {
    return localStorage.getItem('authToken');
  };

  return (
    <AuthContext.Provider value={{ ...state, login, logout, getToken }}>
      {children}
    </AuthContext.Provider>
  );
};

export default AuthProvider;
```

## Services Autenticazione

### API Calls per Auth
```typescript
// services/authApi.ts
const AUTH_API_BASE = 'https://api.example.com';

export const loginUser = async (credentials: LoginCredentials) => {
  const response = await fetch(`${AUTH_API_BASE}/api/login`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(credentials),
  });

  if (!response.ok) {
    const error = await response.json();
    throw new Error(error.message || 'Login failed');
  }

  return response.json(); // { token: "jwt_token_here" }
};

export const registerUser = async (credentials: RegisterCredentials) => {
  const response = await fetch(`${AUTH_API_BASE}/api/register`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(credentials),
  });

  if (!response.ok) {
    const error = await response.json();
    throw new Error(error.message || 'Registration failed');
  }

  return response.json();
};
```

## Protezione delle Rotte

### ProtectedRoute Component
```typescript
// components/ProtectedRoute/ProtectedRoute.tsx
import { Navigate } from 'react-router';
import { useAuth } from '../../contexts/AuthContext/AuthContext';

interface ProtectedRouteProps {
  children: React.ReactNode;
  redirectTo?: string;
}

const ProtectedRoute = ({ 
  children, 
  redirectTo = '/login' 
}: ProtectedRouteProps) => {
  const { isAuthenticated } = useAuth();
  
  return isAuthenticated ? <>{children}</> : <Navigate to={redirectTo} replace />;
};

export default ProtectedRoute;
```

### Configurazione Routing con Protezione
```typescript
// routes/routes.tsx
import { createBrowserRouter } from 'react-router';
import MainLayout from '../layouts/MainLayout/MainLayout';
import Home from '../pages/Home/Home';
import Login from '../pages/Login/Login';
import Dashboard from '../pages/Dashboard/Dashboard';
import ProtectedRoute from '../components/ProtectedRoute/ProtectedRoute';

const router = createBrowserRouter([
  {
    path: '/',
    element: <MainLayout />,
    children: [
      {
        path: '/',
        element: <Home />,
      },
      {
        path: '/login',
        element: <Login />,
      },
      {
        path: '/dashboard',
        element: (
          <ProtectedRoute>
            <Dashboard />
          </ProtectedRoute>
        ),
      },
    ],
  },
]);

export default router;
```

## Componenti Form

### Login Form Component
```typescript
// components/LoginForm/LoginForm.tsx
import { useState } from 'react';
import { useNavigate } from 'react-router';
import { useAuth } from '../../contexts/AuthContext/AuthContext';
import { LoginCredentials } from '../../types/auth';

const LoginForm = () => {
  const [credentials, setCredentials] = useState<LoginCredentials>({
    username: '',
    password: '',
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  
  const { login } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      await login(credentials);
      navigate('/dashboard');
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Login failed');
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setCredentials(prev => ({ ...prev, [name]: value }));
  };

  return (
    <form onSubmit={handleSubmit}>
      {error && <div className="error">{error}</div>}
      
      <div>
        <label htmlFor="username">Username:</label>
        <input
          id="username"
          name="username"
          type="text"
          value={credentials.username}
          onChange={handleChange}
          required
        />
      </div>

      <div>
        <label htmlFor="password">Password:</label>
        <input
          id="password"
          name="password"
          type="password"
          value={credentials.password}
          onChange={handleChange}
          required
        />
      </div>

      <button type="submit" disabled={loading}>
        {loading ? 'Logging in...' : 'Login'}
      </button>
    </form>
  );
};

export default LoginForm;
```

### User Info Display
```typescript
// components/UserInfo/UserInfo.tsx
import { useAuth } from '../../contexts/AuthContext/AuthContext';

const UserInfo = () => {
  const { user, isAuthenticated, logout } = useAuth();

  if (!isAuthenticated || !user) {
    return <div>Not logged in</div>;
  }

  return (
    <div>
      <span>Welcome, {user.username}!</span>
      <button onClick={logout}>Logout</button>
    </div>
  );
};

export default UserInfo;
```

## Hook per Chiamate Autenticate

### useAuthenticatedFetch Hook
```typescript
// hooks/useAuthenticatedFetch.ts
import { useAuth } from '../contexts/AuthContext/AuthContext';

export const useAuthenticatedFetch = () => {
  const { getToken } = useAuth();

  const authenticatedFetch = async (url: string, options: RequestInit = {}) => {
    const token = getToken();
    
    const config: RequestInit = {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        ...(token && { Authorization: `Bearer ${token}` }),
        ...options.headers,
      },
    };

    const response = await fetch(url, config);
    
    if (!response.ok) {
      throw new Error(`HTTP Error: ${response.status}`);
    }
    
    return response;
  };

  return authenticatedFetch;
};
```

## AppWrapper con Context

### Combinare Multiple Context
```typescript
// contexts/index.tsx
import { PropsWithChildren } from 'react';
import { AuthProvider } from './AuthContext/AuthProvider';
import { ToastProvider } from './ToastContext/ToastProvider';

const AppContextWrapper = ({ children }: PropsWithChildren) => {
  return (
    <AuthProvider>
      <ToastProvider>
        {children}
      </ToastProvider>
    </AuthProvider>
  );
};

export default AppContextWrapper;
```

### Utilizzo in App.tsx
```typescript
// App.tsx
import { RouterProvider } from 'react-router';
import router from './routes/routes';
import AppContextWrapper from './contexts';
import './App.css';

function App() {
  return (
    <AppContextWrapper>
      <RouterProvider router={router} />
    </AppContextWrapper>
  );
}

export default App;
```

## Best Practices Sicurezza

### Gestione Token JWT
```typescript
// utils/tokenUtils.ts
import { jwtDecode } from 'jwt-decode';

export const isTokenExpired = (token: string): boolean => {
  try {
    const decoded = jwtDecode(token);
    const currentTime = Date.now() / 1000;
    return decoded.exp ? decoded.exp < currentTime : true;
  } catch {
    return true;
  }
};

export const getTokenExpirationTime = (token: string): number | null => {
  try {
    const decoded = jwtDecode(token);
    return decoded.exp ? decoded.exp * 1000 : null;
  } catch {
    return null;
  }
};
```

### Auto-logout su Token Scaduto
```typescript
// In AuthProvider, aggiungere:
useEffect(() => {
  const token = getToken();
  if (token && isTokenExpired(token)) {
    logout();
  }
}, []);
```

## Checklist Autenticazione

- [ ] Context API setup con TypeScript
- [ ] Provider con localStorage persistence
- [ ] Login/logout functions implementate
- [ ] ProtectedRoute component creato
- [ ] Forms con gestione errori
- [ ] Token JWT handling
- [ ] Auto-logout su token scaduto
- [ ] Hook per chiamate autenticate

## Prossimo: [Workflow di Sviluppo](./react-development-workflow.md) 