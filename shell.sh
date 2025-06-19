#!/bin/bash
# ---------------------------------
#  Setup React-Project Shell
# ---------------------------------
# Descrizione         : Script per l'avvio dell'ambiente di sviluppo React
# Autore              : Vincenzo Bonura
# Data                : 2025-06-18
# Aggiornato          : 2025-06-19
# Versione            : 0.1.1
# ---------------------------------
# Utilizzo            :
#   source ./shell.sh : Attiva l'ambiente
#   react-help        : Mostra la guida
# ---------------------------------
# Dependencies        :
#                     : bash / zsh
# ---------------------------------

# Percorso assoluto
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$PROJECT_ROOT/scripts"

echo "  Attivazione ambiente progetto React..."
echo "  Percorso progetto: $PROJECT_ROOT"

# Verifica esistenza scripts
if [[ ! -d "$SCRIPTS_DIR" ]]; then
    echo "  -> Errore: Directory scripts non trovata in $SCRIPTS_DIR"
    return 1
fi

# Determina shell  
if command -v zsh &> /dev/null && [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_CMD="zsh"
else
    SHELL_CMD="bash"
fi

echo "  Shell: $SHELL_CMD"

# Variabili ambiente
export REACT_PROJECT_ROOT="$PROJECT_ROOT"
export REACT_SCRIPTS_DIR="$SCRIPTS_DIR"

# Script di automazione (percorsi assoluti)
alias rgc='"$REACT_SCRIPTS_DIR/gc.sh"'
alias rgp='"$REACT_SCRIPTS_DIR/gp.sh"'
alias rgh='"$REACT_SCRIPTS_DIR/gh.sh"'
alias rgctx='"$REACT_SCRIPTS_DIR/gctx.sh"'
alias rsetup='"$REACT_SCRIPTS_DIR/setup.sh"'

# Comandi npm
alias rdev='npm run dev'
alias rbuild='npm run build'
alias rpreview='npm run preview'
alias rlint='npm run lint'

# Git shortcuts
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'

# Navigation helpers
alias prj='cd "$REACT_PROJECT_ROOT"'
alias src='cd src'
alias comp='cd src/components'
alias pages='cd src/pages'
alias hooks='cd src/hooks'

# Project info function
react-help() {
    echo ""
    echo "  React Development Environment"
    echo "  Progetto: $(basename "$REACT_PROJECT_ROOT")"
    echo "  PWD: $(pwd)"
    echo ""
    echo "  Script disponibili:"
    echo "    rgc <name>     - Genera componente"
    echo "    rgp <name>     - Genera pagina"
    echo "    rgh <name>     - Genera hook"
    echo "    rgctx <name>   - Genera context"
    echo "    rsetup <name>  - Setup nuovo progetto"
    echo ""
    echo "  Comandi npm:"
    echo "    rdev           - npm run dev"
    echo "    rbuild         - npm run build"
    echo ""
    echo "  Navigazione:"
    echo "    prj           - Vai alla root del progetto"
    echo "    src            - Vai a src/"
    echo "    comp           - Vai a src/components/"
    echo "    pages          - Vai a src/pages/"
    echo "    hooks          - Vai a src/hooks/"
    echo ""
}

echo ""
echo "✓ Ambiente React attivato!"
echo "  Gli alias e le funzioni sono ora disponibili."
echo ""

# Mostra i comandi disponibili
react-help 