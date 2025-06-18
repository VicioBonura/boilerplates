#! /bin/bash
# --------------------------
#  React Generate Component 
# --------------------------

COMPONENT_PATH="$1"
COMPONENT_NAME=$(basename "$COMPONENT_PATH")
mkdir -p "$COMPONENT_PATH"
CSS_FILE="$COMPONENT_PATH/$COMPONENT_NAME.css"
TSX_FILE="$COMPONENT_PATH/$COMPONENT_NAME.tsx"

# Crea CSS
cat > "$CSS_FILE" << EOF
/* $COMPONENT_NAME */
EOF

# Crea TSX
cat > "$TSX_FILE" << EOF
import './$COMPONENT_NAME.css';

const $COMPONENT_NAME = () => {
  return (
    <div>
      <p>$COMPONENT_NAME</p>
    </div>
  );
};

export default $COMPONENT_NAME;
EOF