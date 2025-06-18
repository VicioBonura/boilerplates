#!/bin/bash
# --------------------------
#  React Generate Hook 
# --------------------------

HOOK_NAME="$1"
HOOK_FILE="src/hooks/$HOOK_NAME.ts"

if [ -z "$1" ]; then
  echo "Usage: ./gh.sh hookName"
  echo "Example: ./gh.sh useCounter"
  exit 1
fi

# Verifica che il nome inizi con "use"
if [[ ! "$HOOK_NAME" =~ ^use ]]; then
  echo "❌ Error: Hook name must start with 'use'"
  echo "Example: useCounter, useApi, useForm"
  exit 1
fi

mkdir -p "src/hooks"

# Crea Hook
cat > "$HOOK_FILE" << EOF
import { useState } from 'react';

// TODO: Define interface for hook return type
interface ${HOOK_NAME^}Return {
  // Add your return types here
}

const $HOOK_NAME = () => {
  const [state, setState] = useState();

  // TODO: Implement your hook logic here

  return {
    state,
    setState,
  };
};

export default $HOOK_NAME;
EOF