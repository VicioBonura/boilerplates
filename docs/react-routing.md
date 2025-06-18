# React Routing e Layout

## Routing con React Router

### Setup Base con createBrowserRouter
```typescript
// routes/routes.tsx
import { createBrowserRouter } from "react-router";
import MainLayout from "../layouts/MainLayout/MainLayout";
import Home from "../pages/Home/Home";
import Detail from "../pages/Detail/Detail";

const router = createBrowserRouter([
  {
    path: "/",
    element: <MainLayout />,
    children: [
      {
        path: "/",
        element: <Home />,
      },
      {
        path: "/detail/:id",
        element: <Detail />,
      },
    ],
  },
]);

export default router;
```

### Hook di Navigazione
```typescript
import { useNavigate, useParams, useLocation } from 'react-router';

const MyComponent = () => {
  const navigate = useNavigate();
  const { id } = useParams();
  const location = useLocation();

  const handleGoToDetail = () => {
    navigate(`/detail/${id}`);
  };

  const handleGoBack = () => {
    navigate(-1); // Torna indietro
  };

  return (
    <div>
      <p>Current path: {location.pathname}</p>
      <p>ID from URL: {id}</p>
      <button onClick={handleGoToDetail}>Go to Detail</button>
      <button onClick={handleGoBack}>Go Back</button>
    </div>
  );
};
```

## Layout Patterns

### MainLayout Base
```typescript
// layouts/MainLayout/MainLayout.tsx
import { Outlet } from 'react-router';
import Header from '../../components/Header/Header';
import './MainLayout.css';

const MainLayout = () => {
  return (
    <div id="app-container">
      <Header />
      <main>
        <Outlet />
      </main>
    </div>
  );
};

export default MainLayout;
```

### CSS Layout Base
```css
/* layouts/MainLayout/MainLayout.css */
#app-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

main {
  flex: 1;
  padding: 1rem;
}

/* Responsive */
@media (max-width: 768px) {
  main {
    padding: 0.5rem;
  }
}
```

### Layout Avanzato con Sidebar
```typescript
// layouts/DashboardLayout/DashboardLayout.tsx
import { Outlet } from 'react-router';
import Header from '../../components/Header/Header';
import Sidebar from '../../components/Sidebar/Sidebar';
import './DashboardLayout.css';

const DashboardLayout = () => {
  return (
    <div className="dashboard-layout">
      <Header />
      <div className="dashboard-body">
        <Sidebar />
        <main className="main-content">
          <Outlet />
        </main>
      </div>
    </div>
  );
};

export default DashboardLayout;
```

### CSS Dashboard Layout
```css
/* layouts/DashboardLayout/DashboardLayout.css */
.dashboard-layout {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.dashboard-body {
  flex: 1;
  display: flex;
}

.main-content {
  flex: 1;
  padding: 1rem;
  overflow-y: auto;
}

@media (max-width: 768px) {
  .dashboard-body {
    flex-direction: column;
  }
}
```

## Route Protection

### Protected Layout
```typescript
// layouts/ProtectedLayout/ProtectedLayout.tsx
import { Outlet, Navigate } from 'react-router';
import { useAuth } from '../../contexts/AuthContext/AuthContext';
import LoadingSpinner from '../../components/LoadingSpinner/LoadingSpinner';

const ProtectedLayout = () => {
  const { isAuthenticated, loading } = useAuth();

  if (loading) return <LoadingSpinner />;
  if (!isAuthenticated) return <Navigate to="/login" replace />;

  return (
    <div className="protected-layout">
      <Outlet />
    </div>
  );
};

export default ProtectedLayout;
```

### Routing con Protezione
```typescript
// routes/routes.tsx - Esempio completo
const router = createBrowserRouter([
  {
    path: "/",
    element: <MainLayout />,
    children: [
      {
        path: "/",
        element: <Home />,
      },
      {
        path: "/login",
        element: <Login />,
      },
    ],
  },
  {
    path: "/dashboard",
    element: <ProtectedLayout />,
    children: [
      {
        path: "/dashboard",
        element: <DashboardLayout />,
        children: [
          {
            path: "/dashboard",
            element: <Dashboard />,
          },
          {
            path: "/dashboard/profile",
            element: <Profile />,
          },
        ],
      },
    ],
  },
]);
```

## Pattern Comuni

### Link vs Navigate
```typescript
import { Link, useNavigate } from 'react-router';

const Navigation = () => {
  const navigate = useNavigate();

  return (
    <nav>
      {/* Usa Link per navigazione standard */}
      <Link to="/home">Home</Link>
      <Link to="/about">About</Link>
      
      {/* Usa navigate() per navigazione programmatica */}
      <button onClick={() => navigate('/dashboard')}>
        Go to Dashboard
      </button>
    </nav>
  );
};
```

### Breadcrumbs
```typescript
// components/Breadcrumbs/Breadcrumbs.tsx
import { Link, useLocation } from 'react-router';

const Breadcrumbs = () => {
  const location = useLocation();
  const pathnames = location.pathname.split('/').filter(x => x);

  return (
    <nav className="breadcrumbs">
      <Link to="/">Home</Link>
      {pathnames.map((name, index) => {
        const routeTo = `/${pathnames.slice(0, index + 1).join('/')}`;
        const isLast = index === pathnames.length - 1;
        
        return isLast ? (
          <span key={name}> / {name}</span>
        ) : (
          <span key={name}>
            {' / '}
            <Link to={routeTo}>{name}</Link>
          </span>
        );
      })}
    </nav>
  );
};
```

## 404 e Error Handling

### 404 Page
```typescript
// pages/NotFound/NotFound.tsx
import { Link } from 'react-router';

const NotFound = () => {
  return (
    <div className="not-found">
      <h1>404 - Page Not Found</h1>
      <p>The page you're looking for doesn't exist.</p>
      <Link to="/">Go back to Home</Link>
    </div>
  );
};

export default NotFound;
```

### Aggiunta 404 al Router
```typescript
const router = createBrowserRouter([
  // ... altre rotte
  {
    path: "*",
    element: <NotFound />,
  },
]);
```

## Checklist Routing e Layout

- [ ] Router configurato con createBrowserRouter
- [ ] MainLayout con Outlet implementato
- [ ] Navigation con Link components
- [ ] useParams per parametri URL
- [ ] useNavigate per navigazione programmatica
- [ ] Protezione rotte se necessaria
- [ ] 404 page implementata
- [ ] Layout responsive

## Prossimo: [Context e Autenticazione](./react-auth.md) 