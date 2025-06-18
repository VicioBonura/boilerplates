#!/bin/bash
# --------------------------
#  React Generate Context 
# --------------------------

CONTEXT_NAME="$1"
CONTEXT_PATH="src/contexts/${CONTEXT_NAME}Context"

if [ -z "$1" ]; then
  echo "  -> Uso: ./gctx.sh NomeContext"
  echo "  -> Esempio: ./gctx.sh Auth"
  exit 1
fi

mkdir -p "$CONTEXT_PATH"

CONTEXT_FILE="$CONTEXT_PATH/${CONTEXT_NAME}Context.ts"
PROVIDER_FILE="$CONTEXT_PATH/${CONTEXT_NAME}Provider.tsx"
TYPES_FILE="src/types/${CONTEXT_NAME,,}.d.ts"

# Crea types file
mkdir -p "src/types"
cat > "$TYPES_FILE" << EOF
export interface ${CONTEXT_NAME}State {
  // TODO: Interfaccia
  loading: boolean;
}

export interface ${CONTEXT_NAME}ContextType extends ${CONTEXT_NAME}State {
  // TODO: Definire i metodi del context
  // Esempio: login: (credentials: LoginData) => Promise<void>;
}
EOF

# Crea Context
cat > "$CONTEXT_FILE" << EOF
import { createContext, useContext } from 'react';
import { ${CONTEXT_NAME}ContextType } from '../../types/${CONTEXT_NAME,,}';

const ${CONTEXT_NAME}Context = createContext<${CONTEXT_NAME}ContextType>({
  loading: false,
  // TODO: Aggiungere valori di default per il context
});

export const use${CONTEXT_NAME} = () => {
  const context = useContext(${CONTEXT_NAME}Context);
  if (!context) {
    throw new Error('use${CONTEXT_NAME} deve essere usato all\'interno di ${CONTEXT_NAME}Provider');
  }
  return context;
};

export default ${CONTEXT_NAME}Context;
EOF

# Crea Provider
cat > "$PROVIDER_FILE" << EOF
import { useState, PropsWithChildren } from 'react';
import ${CONTEXT_NAME}Context from './${CONTEXT_NAME}Context';
import { ${CONTEXT_NAME}State } from '../../types/${CONTEXT_NAME,,}';

export const ${CONTEXT_NAME}Provider = ({ children }: PropsWithChildren) => {
  const [state, setState] = useState<${CONTEXT_NAME}State>({
    loading: false,
    // TODO: Inizializzare stato
  });

  // TODO: Implementare i metodi del context
  // Esempio: login
  // const login = async (credentials: LoginData) => {
  //   setState(prev => ({ ...prev, loading: true }));
  //   try {
  //     // Logica di login
  //   } finally {
  //     setState(prev => ({ ...prev, loading: false }));
  //   }
  // };

  return (
    <${CONTEXT_NAME}Context.Provider value={{ ...state }}>
      {children}
    </${CONTEXT_NAME}Context.Provider>
  );
};

export default ${CONTEXT_NAME}Provider;
EOF

echo "  Context '${CONTEXT_NAME}' creato con successo!"
echo "  File creati:"
echo "    - $CONTEXT_FILE"
echo "    - $PROVIDER_FILE"
echo "    - $TYPES_FILE"
echo ""
echo "  Passi successivi:"
echo "    1. Definire l'interfaccia di stato in $TYPES_FILE"
echo "    2. Implementare i metodi del context in $PROVIDER_FILE"
echo "    3. Aggiungere il provider al tuo App.tsx"
echo "    4. Usare l'hook use${CONTEXT_NAME}() nei tuoi componenti" 