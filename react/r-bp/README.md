# React Boilerplate - Documentazione Tecnica

## Panoramica del Progetto

//XXX Aggiungere descrizione del progetto
Boilerplate React completo realizzato con architettura moderna e responsive design. Il progetto implementa una Single Page Application (SPA) con routing client-side e struttura modulare scalabile.

### Stack Tecnologico

- **React 19** - Framework UI con hooks e componenti funzionali
- **TypeScript** - Type safety e intellisense migliorato
- **Vite** - Build tool moderno per sviluppo e produzione
- **React Router v7** - Gestione del routing client-side
- **React Icons** - Libreria di icone componibilizzate
- **JWT Decode** - Gestione token di autenticazione
- **CSS Custom Properties** - Sistema di design tokens

## Architettura del Progetto

### Struttura delle Directory

```
src/
├── components/          # Componenti riutilizzabili
│   ├── BrandLogo/      # Logo dell'applicazione
│   ├── Header/         # Header con navigazione desktop
│   ├── Navbar/         # Navigazione mobile bottom
│   ├── Hamburger/      # Menu burger per mobile
│   ├── OffCanvasMenu/  # Menu laterale sliding
│   ├── Footer/         # Footer dell'applicazione
│   ├── LoginForm/      # Form di autenticazione
│   └── LoadingSpinner/ # Indicatori di caricamento
├── pages/              # Pagine dell'applicazione
│   ├── Home/          # Homepage principale
│   ├── Login/         # Pagina di autenticazione
│   ├── Detail/        # //XXX Pagina dettaglio da implementare
│   ├── About/         # Informazioni applicazione
│   ├── Contact/       # Contatti e form
│   ├── Settings/      # Impostazioni utente
│   └── NotFound/      # Gestione errori 404
├── layouts/           # Layout condivisi
│   └── MainLayout/    # Layout principale con header/footer
├── hooks/             # Custom hooks
│   ├── useApi.ts     # Hook per chiamate API
│   └── useLocalStorage.ts # Persistenza locale
├── services/          # Servizi esterni
│   └── api.ts        # Configurazione client API
├── contexts/          # Context providers
│   └── index.tsx     # Wrapper per contexts globali
├── types/             # Definizioni TypeScript
│   └── index.ts      # Types condivisi dell'applicazione
├── config/            # Configurazioni
│   └── navigation.ts # Configurazione menu e routing
└── routes/            # Configurazione routing
    └── routes.tsx    # Definizione rotte applicazione
```

### Scelte Progettuali

#### 1. Layout Pattern

Il progetto utilizza il **Layout Pattern** con `MainLayout` che incapsula la struttura comune:

- **Header** fisso con navigazione desktop
- **Main content area** dinamica per le pagine
- **Footer** informativo
- **Navbar mobile** posizionata in bottom per accessibilità touch

**Motivazione**: Centralizza la gestione del layout, garantisce consistenza visiva e facilita modifiche globali all'interfaccia.

#### 2. Responsive Design Strategy

Implementazione di una strategia **Mobile-First** con breakpoint a 769px:

- **Mobile (< 769px)**: Navbar bottom + menu off-canvas per elementi secondari
- **Desktop (≥ 769px)**: Header completo con navigazione inline

**Motivazione**: Ottimizza l'esperienza utente sui dispositivi touch mantenendo la produttività desktop.

#### 3. Component Co-location

Ogni componente include il proprio file CSS:

```
ComponentName/
├── ComponentName.tsx
└── ComponentName.css
```

**Motivazione**: Facilita manutenzione, riduce conflitti CSS e migliora la riusabilità dei componenti.

#### 4. Configurazione Centralizzata

La navigazione è gestita tramite configurazione centralizzata in `config/navigation.ts`:

- **Type safety** per le voci di menu
- **Controllo granulare** della visibilità mobile/desktop
- **Ordinamento** personalizzabile delle voci

**Motivazione**: Semplifica modifiche alla struttura di navigazione e garantisce consistenza.

## Componenti Principali

### MainLayout

Layout wrapper che gestisce la struttura principale dell'applicazione utilizzando React Router Outlet pattern.

### Sistema di Navigazione

- **Header**: Navigazione primaria desktop con branding
- **Navbar**: Bottom navigation mobile-optimized
- **OffCanvasMenu**: Menu laterale per elementi secondari su mobile

### Sistema di Autenticazione

//XXX Implementare AuthContext e ProtectedRoutes
//XXX Configurare gestione token JWT
//XXX Integrare con backend API

## Gestione dello Stato

### Local State Management

Utilizzo di `useState` e `useReducer` per stato locale dei componenti.

### Global State Management

//XXX Implementare context per stato globale:

- AuthContext per autenticazione utente
- ThemeContext per gestione tema
- AppContext per configurazioni globali

### Persistenza Dati

Hook `useLocalStorage` per persistenza client-side di:

- Preferenze utente
- Token di autenticazione
- Configurazioni temporanee

## Sistema API

### Architettura REST Client

Service pattern con classe `ApiService` che centralizza:

- **Configurazione base URL** tramite environment variables
- **Gestione headers** comuni (Content-Type, Authorization)
- **Interceptor automatico** per token JWT
- **Error handling** centralizzato

### Hook useApi

Custom hook per data fetching con:

- **Loading states** automatici
- **Error handling** integrato
- **Cleanup** per prevent memory leaks
- **Refetch** functionality

## Styling e Design System

### CSS Custom Properties

Sistema di design tokens centralizzato:

```css
:root {
  --primary: #3e8ee9;
  --bg-primary: var(--primary);
  --header-h: 6rem;
  --navbar-h: 4rem;
  --touch-h: 3rem;
}
```

### Utility Classes

Set di classi utility per layout comuni:

- **Flexbox utilities**: `.flex`, `.flex-center`, `.items-center`
- **Button system**: `.btn`, `.btn-primary`
- **Container**: `.container` con responsive padding

## Funzionalità da Implementare

### Core Business Logic

//XXX Definire e implementare logica di business specifica
//XXX Integrare con requisiti dell'esame

### Data Management

//XXX Implementare gestione CRUD per entità principali
//XXX Configurare validazione form con librerie appropriate

### Advanced Features

//XXX Implementare ricerca e filtri
//XXX Aggiungere paginazione per liste
//XXX Integrare notifiche toast/alert

### Performance Optimization

//XXX Implementare lazy loading per componenti
//XXX Aggiungere memoization per componenti pesanti
//XXX Ottimizzare bundle size

### Security & Authentication

//XXX Implementare refresh token logic
//XXX Aggiungere route protection
//XXX Configurare CORS e security headers

## Testing Strategy

//XXX Implementare testing suite:

- Unit tests per utilities e hooks
- Component testing per UI components
- Integration tests per flussi principali
- E2E tests per user journeys critici

## Deployment Configuration

### Build Optimization

Configurazione Vite per:

- **Code splitting** automatico
- **Asset optimization** (immagini, CSS)
- **Bundle analysis** per performance monitoring

### Environment Configuration

//XXX Configurare environment variables per:

- API endpoints (dev/staging/prod)
- Feature flags
- Analytics tracking IDs

## Performance Considerations

### Runtime Optimization

- **React.memo** per componenti pure
- **useMemo/useCallback** per expensive computations
- **Lazy loading** per route splitting

### Network Optimization

- **API response caching** tramite browser cache headers
- **Request debouncing** per search/filter inputs
- **Optimistic updates** per migliore UX

## Browser Support

Target compatibility:

- **Modern browsers**: Chrome 90+, Firefox 88+, Safari 14+
- **Mobile**: iOS Safari 14+, Chrome Mobile 90+
- **Fallbacks**: Graceful degradation per features non supportate

## Development Workflow

### Scripts NPM

```bash
npm run dev      # Server di sviluppo con HMR
npm run build    # Build produzione con ottimizzazioni
npm run preview  # Preview build locale
npm run lint     # Linting ESLint con auto-fix
```

### Code Style

Configurazione ESLint con:

- **React Hooks rules** per best practices
- **TypeScript strict mode** per type safety
- **Import ordering** per consistenza

---

**Nota**: Questo README serve come documentazione base del boilerplate. Durante l'implementazione dell'applicazione finale, aggiornare le sezioni marcate con `//XXX` con i dettagli specifici della soluzione implementata.
