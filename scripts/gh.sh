#!/bin/bash
# --------------------------
#  React Generate Hook 
# --------------------------

HOOK_NAME="$1"
HOOK_FILE="src/hooks/$HOOK_NAME.ts"

if [ -z "$1" ]; then
  echo "  -> Uso: ./gh.sh nomeHook"
  echo "  -> Esempio: ./gh.sh useCounter"
  exit 1
fi

# Verifica che il nome inizi con "use"
if [[ ! "$HOOK_NAME" =~ ^use ]]; then
  echo "  -> Errore: Il nome dell'hook deve iniziare con 'use'"
  echo "     Esempio: useCounter, useApi, useForm"
  exit 1
fi

mkdir -p "src/hooks"

# Crea Hook
cat > "$HOOK_FILE" << EOF
import { useState } from 'react';

// TODO: Interfaccia
interface ${HOOK_NAME^}Return {
  // Aggiungere return types
}

const $HOOK_NAME = () => {
  const [state, setState] = useState();

  // TODO: Logica

  return {
    state,
    setState,
  };
};

export default $HOOK_NAME;
EOF

echo "  Hook $HOOK_NAME creato con successo!"