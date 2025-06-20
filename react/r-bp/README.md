# React Boilerplate (r-bp)

Boilerplate per applicazioni React. Setup minimale ma completo per iniziare rapidamente lo sviluppo.

## Struttura Progetto

```
src/
├── components/          # Componenti riutilizzabili
│   ├── Header/         # Header responsive
│   ├── Navbar/         # Navbar mobile
│   ├── DesktopSidebar/ # Sidebar desktop
│   ├── OffCanvasMenu/  # Menu hamburger
│   ├── Hamburger/      # Pulsante hamburger
│   ├── BrandLogo/      # Logo con sizing (sm, md, lg)
│   └── LoadingSpinner/ # Spinner loading
├── contexts/           # Context API setup
├── hooks/              # Custom hooks (useApi, useLocalStorage)
├── layouts/            # Layout principali
├── pages/              # Pagine dell'app
├── routes/             # Configurazione routing
├── services/           # API utilities
└── types/              # TypeScript definitions
```

## Funzionalità Incluse

- ✅ **React Router** - Routing configurato
- ✅ **TypeScript** - Tipizzazione completa
- ✅ **React Icons** - FontAwesome icons
- ✅ **CSS Custom Properties** - Sistema colori/spacing
- ✅ **Utility Classes** - Classes CSS pronte all'uso
- ✅ **API Service** - Utility per chiamate HTTP
- ✅ **Custom Hooks** - Hook per API e localStorage
- ✅ **Responsive Design** - Layout mobile + desktop
- ✅ **Desktop Sidebar** - Navigazione sidebar su schermi grandi
- ✅ **Context Setup** - Pronto per state management

## Quick Start

```bash
npm install
npm run dev
```

## Pattern Pronti all'Uso

### 1. Chiamate API

```tsx
import { useApi } from "./hooks/useApi";
import { api } from "./services/api";

const { data, loading, error } = useApi(() => api.get("/users"));
```

### 2. LocalStorage

```tsx
import { useLocalStorage } from "./hooks/useLocalStorage";

const [token, setToken] = useLocalStorage("auth_token", "");
```

### 3. Loading States

```tsx
import LoadingSpinner from "./components/LoadingSpinner/LoadingSpinner";

{
  loading && <LoadingSpinner />;
}
```

### 4. BrandLogo con Sizing

```tsx
import BrandLogo from './components/BrandLogo/BrandLogo';

<BrandLogo size="lg" />  // Header
<BrandLogo size="md" />  // OffCanvas
<BrandLogo size="sm" />  // Footer
```

### 5. Sidebar Personalizzabile

```tsx
import DesktopSidebar from "./components/DesktopSidebar/DesktopSidebar";

<DesktopSidebar title="Filtri">
  <div>Contenuti sidebar...</div>
</DesktopSidebar>;
```

### 6. Utility Classes

```tsx
<div className="flex flex-center p-2 mt-2">
  <button className="btn btn-primary w-full">Azione</button>
</div>
```

## Variabili CSS Disponibili

```css
/* Colori */
--primary: #3e8ee9
--accent: #d79430
--text-primary: #232323
--bg-light: #f0f4f9

/* Sizing */
--header-h: 6rem
--navbar-h: 4rem
--touch-h: 3rem
```

## Layout Responsivo

- **Mobile (≤768px)**: Header + Main + Navbar bottom + Menu hamburger
- **Desktop (>768px)**: Header con navigazione + Main + Sidebar opzionale
- **Auto-switch**: Layout cambia automaticamente

### Layout Desktop

- **Header**: Brand (sinistra) + Titolo + Navigazione (destra)
- **Sidebar**: Contenuti secondari (filtri, menu aggiuntivi)
- **Main**: Contenuto principale con spazio ottimizzato

## Durante l'Esame

1. **Parti da qui** - Il boilerplate è già configurato
2. **Aggiungi pagine** - Crea in `/pages` e aggiungi alle routes
3. **Usa utility classes** - Per styling rapido
4. **Pattern pronti** - Early return, loading states, etc.
5. **Layout flessibile** - Funziona su mobile e desktop
6. **Estendi context** - Uncomment AuthProvider quando serve
