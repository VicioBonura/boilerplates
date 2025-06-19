# React - Appunti di Studio

Raccolta di note e riferimenti per React, basati sul corso ITS e progetti pratici

## Struttura degli Appunti

### Setup e Struttura
- **[[react-setup.md]]** - Installazione, configurazione e struttura progetto
- **[[react-boilerplate.md]]** - Template di partenza e convenzioni

### Concetti Fondamentali
- **[[react-hooks.md]]** - useState, useEffect e custom hooks
- **[[react-components.md]]** - Componenti, props e best practices
- **[[react-routing.md]]** - React Router, navigazione e layout

### Gestione Stato e API
- **[[react-context.md]]** - Context API e stato globale
- **[[react-api.md]]** - Fetch, custom hooks per API e gestione errori
- **[[react-auth.md]]** - Autenticazione e localStorage

### Sviluppo e Pattern
- **[[react-automation.md]]** - Script di automazione per velocizzare lo sviluppo
- **[[react-development-workflow.md]]** - Approccio metodico allo sviluppo
- **[[react-common-patterns.md]]** - Pattern frequenti e soluzioni rapide

## Quick Start

### Setup Iniziale (2 minuti con script!)
```bash
# Setup automatico completo
./scripts/setup.sh my-project
cd my-project && npm run dev

# OPPURE setup manuale (10 minuti)
npm create vite@latest app-name -- --template react-ts
cd app-name
npm install react-router react-icons
npm run dev
```

### Scaffolding iniziale
```
src/
├── components/    # Componenti
├── hooks/         # Custom hooks
├── layouts/       # Layout
├── pages/         # Pagine
├── services/      # API calls
├── contexts/      # Context
├── types/         # TypeScript types
└── routes/        # Routing
```

## Checklist

### Preparazione
- [ ] Boilerplate testato e funzionante
- [ ] Dipendenze standard installate
- [ ] Struttura cartelle standardizzata

### Durante lo Sviluppo
- [ ] Lettura completa dei requisiti
- [ ] Analisi API disponibili
- [ ] Planning delle funzionalità
- [ ] Implementazione incrementale
- [ ] Test di compilazione finale

## Priorità nello Sviluppo

1. **Funzionalità Core** (60% del tempo)
   - Routing base
   - Chiamate API
   - Gestione stato

2. **Autenticazione** (20% del tempo)
   - Login/logout
   - Context per auth
   - Protection delle rotte

3. **UI e UX** (20% del tempo)
   - Styling responsive
   - Loading states
   - Error handling

## Concetti Chiave da Ricordare

### Hook Essenziali
- `useState` per stato locale
- `useEffect` per side effects
- `useContext` per stato globale
- `useParams` per parametri route
- `useNavigate` per navigazione programmatica

### Pattern Ricorrenti
- Early return per condizioni
- Custom hooks per logica riutilizzabile
- Context + Provider per stato globale
- Fetch con async/await e error handling

### TypeScript Best Practices
- Interfacce per props e dati API
- Tipizzazione degli stati
- Type safety per eventi

## Collegamenti Rapidi

- [Setup e Configurazione](./react-setup.md)
- [Script di Automazione](./react-automation.md)
- [Hooks e Stato](./react-hooks.md)
- [Routing e Layout](./react-routing.md)
- [Gestione API](./react-api.md)
- [Context e Autenticazione](./react-auth.md)
- [Workflow di Sviluppo](./react-development-workflow.md)