# React Automation Scripts

Collezione di script bash per accelerare lo sviluppo React.

## Quick Start

```bash
# Setup progetto completo
./setup-exam.sh my-exam-app

# Genera componente
./gc.sh MyComponent

# Genera pagina  
./gp.sh MyPage

# Genera hook
./gh.sh useMyHook

# Genera context
./gctx.sh MyContext
```

## Script Disponibili

| Script     | Descrizione             | Tempo Risparmiato |
|------------|-------------------------|-------------------|
| `setup.sh` | Setup progetto completo | ~15 min →  2 min  |
| `gc.sh`    | Genera componente React |  ~3 min → 10 sec  |
| `gp.sh`    | Genera pagina React     |  ~3 min → 10 sec  |
| `gh.sh`    | Genera custom hook      |  ~2 min → 10 sec  |
| `gctx.sh`  | Genera context completo | ~10 min → 30 sec  |

## Configurazione

```bash
# Rendi eseguibili (una volta)
chmod +x *.sh

# Verifica
ls -la *.sh
```

## Documentazione Completa

Per documentazione dettagliata vedi: [docs/react-automation.md](../docs/react-automation.md)

## Esempi d'Uso

### Setup Completo Progetto
```bash
# 1. Setup base
./setup-exam.sh equiprent-app
cd equiprent-app

# 2. Genera componenti necessari
./gc.sh EquipmentCard
./gc.sh BookingForm
./gp.sh Dashboard

# 3. Genera context auth
./gctx.sh Auth

# 4. Start development
npm run dev
```

### Workflow Tipico
```bash
# Analizza requisiti progetto (5 min)
# Poi esegui:

./setup-exam.sh exam-app        # 2 min
cd exam-app
./gp.sh Detail                  # 10 sec
./gp.sh Login                   # 10 sec  
./gc.sh ItemCard                # 10 sec
./gh.sh useItemsApi             # 10 sec
./gctx.sh Auth                  # 30 sec

# Totale setup: ~3 min vs ~25 min manuale
```

## Troubleshooting

### Permessi
```bash
chmod +x scripts/*.sh
```

### Path
```bash
# Da cartella boilerplates
./scripts/gc.sh MyComponent

# Con alias (raccomandato)
alias gc='./scripts/gc.sh'
gc MyComponent
```