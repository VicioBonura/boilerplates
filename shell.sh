#!/bin/bash
# ---------------------------------
#  Setup React-Project Shell
# ---------------------------------
# Descrizione         : Estende la shell con alias per React e GIT
#                     : e include funzioni per React da ./scripts/
# Autore              : Vincenzo Bonura
# Data                : 2025-06-18
# Aggiornato          : 2025-06-19
# Versione            : 0.1.3
# ---------------------------------
# Utilizzo            :
#   source ./shell.sh : Attiva l'ambiente
#   react-help        : Mostra la guida
# ---------------------------------
# Dependencies          :
#                       : ./scripts/*
# ---------------------------------

# Percorso assoluto
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$PROJECT_ROOT/scripts"

# Verifica esistenza scripts
if [[ ! -d "$SCRIPTS_DIR" ]]; then
    echo "  -> Errore: Directory scripts non trovata in $SCRIPTS_DIR"
    return 1
fi

# Colori
source $SCRIPTS_DIR/modules/colors.sh

print_info "  Attivazione ambiente progetto React..."
print_color -n "$CYAN" "  Percorso root:"
echo " $PROJECT_ROOT"

# Determina shell  
if command -v zsh &> /dev/null && [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_CMD="zsh"
else
    SHELL_CMD="bash"
fi

print_color -n "$CYAN" "  Shell:"
echo " $SHELL_CMD"

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
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --all'

# Navigation helpers
alias prj='cd "$REACT_PROJECT_ROOT"'
alias src='cd src'
alias comp='cd src/components'
alias pages='cd src/pages'
alias hooks='cd src/hooks'

# Project info function
react-help() {
    echo ""
    print_success "  React Development Environment"
    print_color -n "$CYAN" "    Root ambiente:"
    echo " $(basename "$REACT_PROJECT_ROOT")"
    print_color -n "$CYAN" "    PWD:"
    echo " $(pwd)"
    echo ""
    print_color "$DARKGRAY" "  Script disponibili:"
    echo "    rgc <name>     - Genera componente"
    echo "    rgp <name>     - Genera pagina"
    echo "    rgh <name>     - Genera hook"
    echo "    rgctx <name>   - Genera context"
    echo "    rsetup <name>  - Setup nuovo progetto"
    echo ""
    print_color "$DARKGRAY" "  Comandi npm:"
    echo "    rdev           - npm run dev"
    echo "    rbuild         - npm run build"
    echo "    rpreview       - npm run preview"
    echo "    rlint          - npm run lint"
    echo ""
    print_color "$DARKGRAY" "  Comandi Git:"
    echo "    gs             - git status"
    echo "    ga             - git add"
    echo "    gc             - git commit -m"
    echo "    gp             - git push"
    echo "    gl             - git log --oneline --graph --all"
    echo ""
    print_color "$DARKGRAY" "  Navigazione:"
    echo "    prj            - Vai alla root del progetto"
    echo "    src            - Vai a src/"
    echo "    comp           - Vai a src/components/"
    echo "    pages          - Vai a src/pages/"
    echo "    hooks          - Vai a src/hooks/"
    echo ""
}

echo ""
print_success "✔ Ambiente React attivato!"
print_debug "  Gli alias e le funzioni sono ora disponibili."
print_debug "  Per maggiori informazioni, esegui: react-help"
echo ""