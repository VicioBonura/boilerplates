# Cursor Rules - React Boilerplates

## Contesto del Progetto
Questo progetto contiene boilerplates per lo sviluppo con React. L'approccio deve essere **KISS (Keep It Simple, Stupid)** per massimizzare l'efficienza durante lo sviluppo.

## Struttura Base del Progetto

### Dependencies Standard
```json
{
  "dependencies": {
    "react": "^19.1.0",
    "react-dom": "^19.1.0",
    "react-icons": "^5.5.0",
    "react-router": "^7.6.2"
  }
}
```

### Struttura Cartelle
```
src/
├── components/          # Componenti riutilizzabili
│   ├── Header/
│   ├── Navbar/
│   └── [ComponentName]/
├── contexts/           # Context API per state management
│   ├── AuthContext/
│   └── index.tsx
├── layouts/           # Layout principali
│   └── MainLayout/
├── pages/             # Pagine dell'app
│   ├── Home/
│   ├── Detail/
│   └── Login/
├── routes/            # Configurazione routing
│   └── routes.tsx
├── services/          # API calls
└── types/             # TypeScript types
```

## Routing con React Router

### Implementazione Standard
```tsx
import { createBrowserRouter } from "react-router";
import MainLayout from "../layouts/MainLayout/MainLayout";

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
        path: "/detail",
        element: <Detail />,
      }
    ],
  },
]);

export default router;
```

### App.tsx Setup
```tsx
import { RouterProvider } from "react-router";
import router from "./routes/routes";

function App() {
  return <RouterProvider router={router} />;
}
```

## Context API - Implementazione Semplice

### Struttura Context
```tsx
// contexts/AuthContext/AuthContext.ts
import { createContext, useContext } from 'react';

const AuthContext = createContext<AuthContextType>({
    user: null,
    isAuthenticated: false,
    token: null,
    login: () => Promise.resolve(),
    logout: () => {}
});

export const useAuth = () => {
    const context = useContext(AuthContext);
    if (!context) {
        throw new Error('Context not found');
    }
    return context;
}

export default AuthContext;
```

### Provider Implementation
```tsx
// contexts/AuthContext/AuthProvider.tsx
import { useState, PropsWithChildren } from 'react';
import AuthContext from './AuthContext';

export const AuthProvider = ({ children }: PropsWithChildren) => {
    const [state, setState] = useState<AuthState>({
        user: null,
        isAuthenticated: false,
        token: null,
    });

    const login = async (credentials) => {
        // Login logic
    }

    const logout = () => {
        setState({
            user: null,
            isAuthenticated: false,
            token: null,
        });
    }

    return (
        <AuthContext.Provider value={{...state, login, logout}}>
            {children}
        </AuthContext.Provider>
    );
}
```

### Wrapper per Multiple Context
```tsx
// contexts/index.tsx
import { PropsWithChildren } from "react";
import { AuthProvider } from "./AuthContext/AuthProvider";

const AppContextWrapper = ({ children }: PropsWithChildren) => {
    return (
        <AuthProvider>
            {children}
        </AuthProvider>
    )
}

export default AppContextWrapper;
```

## Icone - React Icons (FontAwesome)

### Import Standard
```tsx
import { FaHome, FaCopy, FaUser } from "react-icons/fa";
```

### Utilizzo nei Componenti
```tsx
const NavItem = () => (
    <Link to="/" aria-label="Home">
        <FaHome />
    </Link>
);
```

## Componenti - Approccio KISS

### Struttura Standard Componente
```tsx
// components/ComponentName/ComponentName.tsx
import "./ComponentName.css";

interface ComponentNameProps {
    // Props types
}

const ComponentName = ({ prop1, prop2 }: ComponentNameProps) => {
    // Early return per condizioni
    if (!prop1) return null;

    return (
        <div className="component-name">
            {/* JSX content */}
        </div>
    );
};

export default ComponentName;
```

### CSS Co-locato
Ogni componente ha il suo file CSS nella stessa cartella:
```
ComponentName/
├── ComponentName.tsx
└── ComponentName.css
```

## Layout Pattern

### MainLayout Standard
```tsx
import { Outlet } from "react-router";
import Header from "../components/Header/Header";

const MainLayout = () => {
    return (
        <>
            <Header />
            <main>
                <Outlet />
            </main>
        </>
    );
};
```

## Best Practices di Sviluppo

1. **Early Return**: Usare sempre quando possibile per evitare nesting
2. **Componenti Semplici**: Un componente = una responsabilità
3. **CSS Co-locato**: Ogni componente con il suo CSS
4. **Types Espliciti**: Definire sempre le interfacce TypeScript
5. **Context Minimale**: Solo per stato realmente globale
6. **Routing Oggetto**: Preferire createBrowserRouter
7. **Import Organizzati**: Raggruppare imports per tipo

## Convenzioni di Naming

- **Componenti**: PascalCase (es. `UserCard`)
- **File**: PascalCase per componenti, camelCase per utilities
- **Cartelle**: PascalCase per componenti
- **CSS Classes**: kebab-case (es. `user-card`)
- **Variabili**: camelCase

## Quick Start Commands

```bash
# Setup progetto
npm create vite@latest app-name -- --template react-ts
cd app-name
npm install react-router react-icons

# Dev server
npm run dev

# Build
npm run build
```

## Note Importanti

- Priorità: Funzionalità > Styling
- Usare il boilerplate b-app come base
- Implementare solo i context necessari
- CSS semplice, no framework pesanti
- Focus su TypeScript safety
- Testing non prioritario (tempo limitato) 