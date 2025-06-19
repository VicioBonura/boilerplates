# React Setup

## Setup Rapido

### Creazione Progetto
```bash
# Template TypeScript + React
npm create vite@latest app-name -- --template react-ts
cd app-name
npm install
```

### Dipendenze Essenziali
```bash
# Routing
npm install react-router

# Icone FontAwesome
npm install react-icons

# Opzionali ma utili
npm install jwt-decode  # Per JWT tokens
```

### Pulizia Boilerplate Vite
Rimuovere/modificare questi file:
```bash
# Rimuovere
rm src/assets/react.svg
rm public/vite.svg

# Svuotare
echo "" > src/App.css
echo "" > src/index.css
```

## Struttura Progetto Ottimale

```
src/
├── components/          # Componenti riutilizzabili
│   └── Header/
│       ├── Header.tsx
│       └── Header.css
├── pages/              # Pagine
│   ├── Home/
│   │   ├── Home.tsx
│   │   └── Home.css
│   └── Detail/
│       ├── Detail.tsx
│       └── Detail.css
├── hooks/              # Custom hooks
│   ├── useApi.ts
│   └── useAuth.ts
├── services/           # API calls
│   └── api.ts
├── contexts/           # Context API
│   ├── AuthContext/
│   │   ├── AuthContext.ts
│   │   └── AuthProvider.tsx
│   └── index.tsx
├── types/              # TypeScript types
│   ├── api.d.ts
│   └── auth.d.ts
└── routes/             # Configurazione routing
    └── routes.tsx
```

## Configurazione Base

### tsconfig.json
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
```

### vite.config.ts - Configurazione Base
```typescript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,    // Porta personalizzata
    open: true     // Apri browser automaticamente
  }
})
```

## Package.json

```json
{
  "scripts": {
    "dev": "vite",
    "build": "tsc -b && vite build",
    "lint": "eslint .",
    "preview": "vite preview",
    "type-check": "tsc --noEmit"
  }
}
```

## File di Base

### src/main.tsx
```tsx
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import App from './App.tsx'
import './index.css'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>,
)
```

### src/App.tsx (con Router)
```tsx
import { RouterProvider } from "react-router";
import router from "./routes/routes";
import AppContextWrapper from "./contexts";
import "./App.css";

function App() {
  return (
    <AppContextWrapper>
      <RouterProvider router={router} />
    </AppContextWrapper>
  );
}

export default App;
```

### src/index.css (Reset CSS minimo)
```css
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 
               Oxygen, Ubuntu, Cantarell, sans-serif;
  line-height: 1.6;
  color: #333;
}

button {
  cursor: pointer;
  border: none;
  background: none;
  font-family: inherit;
}

a {
  text-decoration: none;
  color: inherit;
}

img {
  max-width: 100%;
  height: auto;
}
```

## Comandi Rapidi Durante lo Sviluppo

```bash
# Verifica compilazione
npm run build

# Controllo tipi TypeScript
npm run type-check

# Lint del codice
npm run lint

# Anteprima build
npm run preview
```

## Troubleshooting Comune

### Errori di Importazione
```typescript
// ❌ Evitare
import React from 'react';

// ✅ Preferire (con nuova JSX transform)
import { useState, useEffect } from 'react';
```

### Errori di Routing
```typescript
// ❌ Import sbagliato
import { BrowserRouter } from 'react-router-dom';

// ✅ Import corretto (React Router v7)
import { createBrowserRouter } from 'react-router';
```

### Errori TypeScript Comuni
```typescript
// ❌ Any type
const [data, setData] = useState(null);

// ✅ Typed state
interface ApiData {
  id: number;
  name: string;
}
const [data, setData] = useState<ApiData[]>([]);
```

## Checklist Setup

- [ ] Progetto creato con Vite + TypeScript
- [ ] Dipendenze installate (react-router, react-icons)
- [ ] Struttura cartelle impostata
- [ ] Boilerplate pulito
- [ ] App.tsx configurato con routing
- [ ] CSS reset applicato
- [ ] Compilazione testata (`npm run build`)

## Prossimo: [Hooks e Gestione Stato](./react-hooks.md) 