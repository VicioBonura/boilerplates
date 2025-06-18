# React Automation Scripts

## Script Disponibili

### Setup Completo

#### `setup.sh` - Setup Progetto Completo
Crea un progetto React completamente configurato in 1 comando.

```bash
./scripts/setup.sh my-app
```

**Cosa fa:**
- Crea progetto Vite + React + TypeScript
- Installa dipendenze essenziali (react-router, react-icons, jwt-decode)
- Crea struttura cartelle ottimale
- Setup CSS utilities e reset
- Configura routing base con MainLayout
- Crea pagine Home e 404
- Testa la build per verificare tutto funzioni

**Tempo di setup:** ~2-3 minuti vs 15-20 minuti manuali

### Generatori di Codice

#### `gc.sh` - Generate Component
Crea un componente React con TypeScript e CSS.

```bash
./scripts/gc.sh Header
```

**Output:**
```
src/components/Header/
├── Header.tsx
└── Header.css
```

**Template generato:**
```typescript
import './Header.css';

const Header = () => {
  return (
    <div>
      <p>Header</p>
    </div>
  );
};

export default Header;
```

#### `gp.sh` - Generate Page
Crea una pagina React con styling base.

```bash
./scripts/gp.sh Home
./scripts/gp.sh Dashboard
```

**Output:**
```
src/pages/Home/
├── Home.tsx
└── Home.css
```

**Template generato:**
```typescript
import './Home.css';

const Home = () => {
  return (
    <div className="home-page">
      <h1>Home Page</h1>
      <p>Welcome to the Home page!</p>
    </div>
  );
};

export default Home;
```

#### `gh.sh` - Generate Hook
Crea un custom hook con TypeScript.

```bash
./scripts/gh.sh useCounter
./scripts/gh.sh useApi
```

**Validazione:** Verifica che il nome inizi con "use"

**Output:**
```
src/hooks/useCounter.ts
```

**Template generato:**
```typescript
import { useState } from 'react';

interface UseCounterReturn {
  // Add your return types here
}

const useCounter = () => {
  const [state, setState] = useState();

  // TODO: Implement your hook logic here

  return {
    state,
    setState,
  };
};

export default useCounter;
```

#### `gctx.sh` - Generate Context
Crea un Context completo con Provider e hook personalizzato.

```bash
./scripts/gctx.sh Auth
./scripts/gctx.sh Theme
```

**Output:**
```
src/contexts/AuthContext/
├── AuthContext.ts
└── AuthProvider.tsx
src/types/
└── auth.d.ts
```

**Cosa genera:**
- Context definition
- Provider component
- Custom hook (useAuth)
- TypeScript interfaces

## Workflow Consigliato

### Fase 1: Setup (2 minuti)
```bash
# Setup progetto completo
./scripts/setup.sh my-app
cd my-app

# Attiva ambiente con alias
./activate.sh

# Avvia sviluppo
rdev
```

### Fase 2: Implementazione Core (30 minuti)
```bash
# Genera pagine necessarie
rgp Home
rgp Login

# Genera componenti
rgc ItemCard
rgc SearchForm

# Genera hooks per API
rgh useItemsApi
rgh useSearchApi
```

### Fase 3: Autenticazione
```bash
# Genera context per auth
rgctx Auth

# Genera componenti auth
rgc LoginForm
rgc ProtectedRoute
```

## Utilizzo Avanzato

### Alias Locali al Progetto

```bash
# Attiva ambiente con alias
./activate.sh

rgc Header        # invece di ./scripts/gc.sh Header
rdev              # invece di npm run dev
rgp Dashboard     # invece di ./scripts/gp.sh Dashboard
rgctx Auth        # invece di ./scripts/gctx.sh Auth
```

**Come funziona:**
- `./activate.sh` carica gli alias e apre una shell dedicata
- Gli alias sono prefissati con "r" (React) per evitare conflitti
- Digita `exit` per tornare alla shell normale

**Alias disponibili:**
- `rgc` - Generate Component
- `rgp` - Generate Page  
- `rgh` - Generate Hook
- `rgctx` - Generate Context
- `rsetup` - Setup Project
- `rdev` - npm run dev
- `rbuild` - npm run build

### Utilizzo Manuale

```bash
# Comandi completi
./scripts/gc.sh MyComponent
./scripts/gp.sh MyPage
./scripts/gh.sh useMyHook
./scripts/gctx.sh MyContext
```

## Personalizzazione Script

### Modifica Template Componente
Edita `scripts/gc.sh` per modificare il template default:

```bash
# Linea 19-29 in gc.sh
cat > "$TSX_FILE" << EOF
import './$COMPONENT_NAME.css';

const $COMPONENT_NAME = () => {
  return (
    <div className="${COMPONENT_NAME,,}">
      {/* Your custom template here */}
    </div>
  );
};

export default $COMPONENT_NAME;
EOF
```

## Troubleshooting

### Permessi Negati
```bash
chmod +x scripts/*.sh .aliases activate.sh
```

### Alias Non Funzionano
```bash
# Verifica che l'ambiente sia attivo
./activate.sh

# Oppure carica manualmente
source .aliases
```

### Script Non Trovato
```bash
# Verifica posizione corretta
pwd
ls -la scripts/

# Lista script disponibili
ls scripts/*.sh
```

### Errori di Sintassi
- Verifica bash version: `bash --version` (richiesto 4+)
- Su Git Bash (Windows): assicurati di essere in modalità bash

## Template Rapidi

### Comando Setup Completo
```bash
# Setup + generazione base
./scripts/setup.sh my-project && cd my-project
./activate.sh

# Generazione componenti con alias
rgp Detail
rgc ItemCard
rgh useItemsApi
```

### Quick API Integration
```bash
# Dopo setup
mkdir -p src/services
echo "export const API_BASE = 'https://api.example.com';" > src/services/api.ts
```

### Quick Authentication Setup
```bash
# Con ambiente attivo
rgctx Auth
rgc LoginForm
rgc ProtectedRoute
```

## Prossimo: [Workflow di Sviluppo](./react-development-workflow.md) 