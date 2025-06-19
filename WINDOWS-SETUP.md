# Setup Ambiente Windows (Git Bash)

## Configurazione rapida

### 1. Copia i file necessari
```bash
# Nel terminale Git Bash, vai alla cartella del progetto
cd /c/path/to/your/boilerplates

# Copia .bashrc nella home directory
cp .bashrc ~/.bashrc

# Oppure crea un link simbolico
ln -s "$(pwd)/.bashrc" ~/.bashrc
```

### 2. Attiva l'ambiente
```bash
# Ricarica la configurazione
source ~/.bashrc

# Attiva gli alias del progetto React
source ./shell.sh
```

### 3. Verifica il funzionamento
```bash
# Il prompt dovrebbe mostrare:
# nomeprogetto/cartella branch-name ★ ❯

# Testa gli alias
gs          # git status
react-help  # mostra tutti i comandi disponibili
```

## Caratteristiche del prompt

### Elementi visualizzati:
- **Path**: Solo ultimi 2 livelli (es: `boilerplates/react`)
- **Branch Git**: Nome del branch corrente
- **Simboli di stato**:
  - `★` = Modifiche non committate (dirty)
  - `≡` = Stash presenti
  - `↑` = Commit in avanti rispetto al remote
  - `↓` = Commit in dietro rispetto al remote
  - `↕` = Divergenza (avanti e dietro)
- **Prompt char**: `❯` verde se successo, rosso se errore

### Esempio di prompt:
```
boilerplates/react main ★ ≡ ↑ ❯
```

## Alias disponibili

### Git shortcuts:
- `gs` = git status
- `ga` = git add
- `gc` = git commit -m
- `gp` = git push  
- `gl` = git log --oneline --graph --all

### React project (dopo `source ./shell.sh`):
- `rdev` = npm run dev
- `rbuild` = npm run build
- `rpreview` = npm run preview
- `rlint` = npm run lint

### Generatori di codice:
- `rgc <nome>` = Genera componente
- `rgp <nome>` = Genera pagina
- `rgh <nome>` = Genera hook
- `rgctx <nome>` = Genera context

### Navigazione:
- `prj` = Vai alla root del progetto
- `src` = Vai a src/
- `comp` = Vai a src/components/
- `pages` = Vai a src/pages/
- `hooks` = Vai a src/hooks/

## Note per VSCode

### Terminale integrato:
1. Apri VSCode
2. `Ctrl+`` per aprire il terminale
3. Assicurati che sia impostato su Git Bash:
   - `Ctrl+Shift+P` → "Terminal: Select Default Profile" → "Git Bash"

### Auto-load configurazione:
Per caricare automaticamente la configurazione, aggiungi al tuo `~/.bash_profile`:
```bash
# Auto-load custom bashrc
if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi
```

## Risoluzione problemi

### Colori non funzionano:
```bash
# Verifica che colors.sh sia accessibile
ls scripts/modules/colors.sh

# Se necessario, aggiusta il percorso in .bashrc
```

### Prompt non si aggiorna:
```bash
# Ricarica la configurazione
source ~/.bashrc
```

### Git commands non funzionano:
```bash
# Verifica che Git sia nel PATH
git --version

# In Git Bash dovrebbe funzionare automaticamente
``` 