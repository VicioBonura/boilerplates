#!/bin/bash
# Script di attivazione ambiente progetto
# Usage: ./activate.sh

echo "  Attivazione ambiente progetto React..."

# Carica alias locali
if [ -f ".aliases" ]; then
    source .aliases
else
    echo "  -> File .aliases non trovato"
fi

# Mostra informazioni progetto
echo ""
echo "  Progetto: $(basename $(pwd))"
echo "  Comandi disponibili:"
echo "    rgc <name>     - Genera componente"
echo "    rgp <name>     - Genera pagina"  
echo "    rgh <name>     - Genera hook"
echo "    rgctx <name>   - Genera context"
echo "    rdev           - npm run dev"
echo "    rbuild         - npm run build"
echo ""

# Avvia shell interattiva con alias caricati
echo "  Shell attivata con alias locali. Digita 'exit' per uscire."
exec bash 