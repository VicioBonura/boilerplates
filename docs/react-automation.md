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
npm run dev
```

### Fase 2: Implementazione Core (30 minuti)
```bash
# Genera pagine necessarie
./scripts/gp.sh Home
./scripts/gp.sh Login

# Genera componenti
./scripts/gc.sh ItemCard
./scripts/gc.sh SearchForm

# Genera hooks per API
./scripts/gh.sh useItemsApi
./scripts/gh.sh useSearchApi
```

### Fase 3: Autenticazione
```bash
# Genera context per auth
./scripts/gctx.sh Auth

# Genera componenti auth
./scripts/gc.sh LoginForm
./scripts/gc.sh ProtectedRoute
```

## Utilizzo Avanzato

### Alias per Velocità
Aggiungere a `.bashrc` o `.zshrc`:

```bash
alias gc='./scripts/gc.sh'
alias gp='./scripts/gp.sh'
alias gh='./scripts/gh.sh'
alias gctx='./scripts/gctx.sh'
```

Utilizzo:
```bash
gc Header
gp Dashboard
gh useApi
gctx Auth
```

### Script Path Globale
Per usare gli script da qualsiasi cartella:

```bash
# Aggiungi al PATH
export PATH="$PATH:/path/to/boilerplates/scripts"

# Ora puoi usare da qualsiasi cartella
gc.sh MyComponent
gp.sh MyPage
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
chmod +x scripts/*.sh
```

### Script Non Trovato
```bash
# Verifica che sei nella cartella boilerplates
pwd
# Dovrebbe essere: /path/to/boilerplates

# Lista script disponibili
ls -la scripts/
```

### Errori di Sintassi
- Verifica bash version: `bash --version`
- I script richiedono bash 4+

## Template Rapidi

### Comando Setup Completo
```bash
# Setup + generazione base
./scripts/setup.sh my-project && cd my-project
./scripts/gp.sh Detail
./scripts/gc.sh ItemCard
./scripts/gh.sh useItemsApi
```

### Quick API Integration
```bash
# Dopo setup
mkdir -p src/services
echo "export const API_BASE = 'https://api.example.com';" > src/services/api.ts
```

### Quick Authentication Setup
```bash
./scripts/gctx.sh Auth
./scripts/gc.sh LoginForm
./scripts/gc.sh ProtectedRoute
```

## Prossimo: [Workflow di Sviluppo](./react-development-workflow.md) 