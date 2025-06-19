# React Development Workflow - Approccio Metodico

## Timeline Sviluppo Progetto (6 ore)

### Fase 1: Analisi e Setup (45 minuti)
- **15 min**: Lettura approfondita requisiti
- **10 min**: Analisi API disponibili  
- **10 min**: Planning funzionalità e priorità
- **10 min**: Setup progetto e dipendenze

### Fase 2: Implementazione Core (3 ore)
- **60 min**: Routing e struttura base
- **90 min**: Chiamate API e data fetching
- **30 min**: Gestione stato e context

### Fase 3: Autenticazione (1.5 ore)
- **45 min**: Login/logout implementation
- **30 min**: Protezione rotte
- **15 min**: Persistenza stato auth

### Fase 4: UI e Rifinitura (45 minuti)
- **30 min**: Styling responsive
- **15 min**: Loading states e UX

### Fase 5: Testing e Deploy (30 minuti)
- **15 min**: Test compilazione e funzionalità
- **15 min**: Build e preparazione consegna

## Checklist Pre-Sviluppo

### Setup Workspace
- [ ] IDE configurato (Cursor/VSCode)
- [ ] Extensions React installate
- [ ] Git configurato
- [ ] Node.js e npm aggiornati
- [ ] Documentazione di riferimento disponibile

## Approccio Sistematico

### 1. Analisi Requisiti (CRITICAL)

#### Domande Chiave da Porsi:
- Quali sono le funzionalità OBBLIGATORIE?
- Quali API sono disponibili?
- Serve autenticazione?
- Che tipo di routing è necessario?
- Ci sono requisiti UI specifici?

#### Creazione Task List:
```markdown
## MUST HAVE (Obbligatori)
- [ ] Lista prodotti/items
- [ ] Dettaglio singolo item
- [ ] Autenticazione login/logout
- [ ] Protezione rotte

## SHOULD HAVE (Importanti)
- [ ] Form di creazione/modifica
- [ ] Gestione errori
- [ ] Loading states

## COULD HAVE (Se c'è tempo)
- [ ] Ricerca/filtri
- [ ] Animazioni
- [ ] Ottimizzazioni performance
```

### 2. Setup Progetto Rapido

#### Setup Automatico (Raccomandato):
```bash
# 1. Setup completo con script (2 minuti)
./scripts/setup.sh my-project
cd my-project
npm run dev
```

#### Setup Manuale (Solo se necessario):
```bash
# 1. Creare progetto
npm create vite@latest my-project -- --template react-ts
cd my-project

# 2. Installare dipendenze
npm install react-router react-icons
npm install jwt-decode  # Se c'è auth

# 3. Pulizia boilerplate
rm src/assets/react.svg public/vite.svg
echo "" > src/App.css
echo "" > src/index.css

# 4. Start development
npm run dev
```

#### Struttura Cartelle Immediate:
```bash
mkdir -p src/{components,pages,hooks,services,contexts,types,routes}
```

### 3. Implementazione Incrementale

#### Step 1: Routing Base (15 min)
```typescript
// routes/routes.tsx - MINIMO FUNZIONANTE
import { createBrowserRouter } from 'react-router';
import Home from '../pages/Home/Home';
import Detail from '../pages/Detail/Detail';

const router = createBrowserRouter([
  { path: '/', element: <Home /> },
  { path: '/detail/:id', element: <Detail /> },
]);

export default router;
```

#### Step 2: Pagine Skeleton (15 min)
```typescript
// pages/Home/Home.tsx
const Home = () => {
  return (
    <div>
      <h1>Home Page</h1>
      <p>TODO: Implementare lista</p>
    </div>
  );
};

export default Home;
```

#### Step 3: Generazione Rapida Componenti (15 min)
```bash
# Genera pagine necessarie
./scripts/gp.sh Detail
./scripts/gp.sh Login

# Genera componenti
./scripts/gc.sh ItemCard
./scripts/gc.sh Header

# Genera hooks per API
./scripts/gh.sh useItemsApi
./scripts/gh.sh useAuth
```

#### Step 4: API Integration (30 min)
```typescript
// Priorità: GET prima di POST/PUT/DELETE
// services/api.ts
export const fetchItems = async () => {
  const response = await fetch(`${API_BASE}/items`);
  if (!response.ok) throw new Error('Fetch failed');
  return response.json();
};

// hooks/useItemsApi.ts (generato con script)
export const useItemsList = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  
  useEffect(() => {
    setLoading(true);
    fetchItems()
      .then(setData)
      .finally(() => setLoading(false));
  }, []);
  
  return { data, loading };
};
```

## Gestione Problemi Comuni

### Errori di Compilazione
```bash
# Comando salva-vita
npm run type-check
```

### API Non Funzionanti
```typescript
// Fallback con dati mock
const MOCK_DATA = [
  { id: 1, name: 'Item 1' },
  { id: 2, name: 'Item 2' },
];

const fetchItems = async () => {
  try {
    const response = await fetch(`${API_BASE}/items`);
    return response.json();
  } catch {
    console.warn('Using mock data');
    return MOCK_DATA;
  }
};
```

### Problemi di Routing
```typescript
// Debug routing
import { useLocation } from 'react-router';

const DebugRouter = () => {
  const location = useLocation();
  console.log('Current route:', location.pathname);
  return null;
};
```

## Prioritizzazione Durante lo Sviluppo

### Priority Matrix:
```
High Impact, Low Effort:
- Routing base
- Lista items con fetch
- CSS reset e layout basic

High Impact, High Effort:
- Autenticazione completa
- Form validation
- Error handling robusto

Low Impact, Low Effort:
- Icone FontAwesome
- Loading spinners
- Console.log cleanup

Low Impact, High Effort:
- Animazioni elaborate
- Ottimizzazioni performance
- Test unitari
```

## Strategie UI Rapide

### CSS Utility First
```css
/* index.css - Utilities veloci */
.flex { display: flex; }
.flex-col { flex-direction: column; }
.items-center { align-items: center; }
.justify-center { justify-content: center; }
.gap-4 { gap: 1rem; }
.p-4 { padding: 1rem; }
.mb-4 { margin-bottom: 1rem; }
.text-center { text-align: center; }
.btn {
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 0.25rem;
  cursor: pointer;
}
.btn-primary { background: #007bff; color: white; }
```

### Layout Responsive Minimo
```css
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}

@media (max-width: 768px) {
  .container { padding: 0 0.5rem; }
  .grid { grid-template-columns: 1fr; }
}
```

## Tecniche di Debug Rapido

### Console Debug Utilities
```typescript
// utils/debug.ts
export const log = (label: string, data: any) => {
  console.log(`${label}:`, data);
};

export const logError = (label: string, error: any) => {
  console.error(`${label}:`, error);
};

export const logAPI = (url: string, data: any) => {
  console.log(`API ${url}:`, data);
};
```

### Quick Error Boundaries
```typescript
// components/ErrorFallback.tsx
const ErrorFallback = ({ error }: { error: Error }) => (
  <div style={{ padding: '20px', border: '1px solid red' }}>
    <h2>Something went wrong:</h2>
    <pre>{error.message}</pre>
  </div>
);
```

## Checklist Pre-Deploy

### Testing Funzionalità (15 min)
- [ ] Navigazione tra tutte le pagine
- [ ] Chiamate API funzionanti
- [ ] Login/logout se presente
- [ ] Form submission se presente
- [ ] Responsive design basic

### Build e Deploy (15 min)
```bash
# 1. Clean build
npm run build

# 2. Test build locale
npm run preview

# 3. Check dimensioni bundle
ls -la dist/

# 4. Preparazione archivio
# Rimuovere node_modules prima!
rm -rf node_modules
zip -r my-project.zip . -x "*.git*" "node_modules/*"
```

### Documentazione Veloce
```markdown
# Relazione Progetto

## Tecnologie Utilizzate
- React 19 con TypeScript
- React Router v7
- Vite build tool

## Struttura Progetto
- `/src/components` - Componenti riutilizzabili
- `/src/pages` - Pagine applicazione
- `/src/services` - Chiamate API
- `/src/contexts` - Gestione stato globale

## Funzionalità Implementate
- [x] Lista items con API
- [x] Routing base
- [x] Autenticazione
- [x] Responsive design

## Deploy
URL: [link netlify/firebase]
```

## Mindset Giusto

### Remember:
- **Funzionalità > Estetica**
- **Working > Perfect**
- **Simple > Complex** 
- **Done > Best Practice**

### Time Boxing Rigido:
- Se una feature richiede più di 30 min → simplify
- Se un bug resiste per 15 min → workaround
- Se un'API non funziona → mock data

## Prossimo: [Pattern Comuni](./react-common-patterns.md) 