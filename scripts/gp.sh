#!/bin/bash
# --------------------------
#  React Generate Page 
# --------------------------

PAGE_PATH="src/pages/$1"
PAGE_NAME="$1"

if [ -z "$1" ]; then
  echo "Usage: ./gp.sh PageName"
  echo "Example: ./gp.sh Home"
  exit 1
fi

mkdir -p "$PAGE_PATH"
CSS_FILE="$PAGE_PATH/$PAGE_NAME.css"
TSX_FILE="$PAGE_PATH/$PAGE_NAME.tsx"

# Crea CSS
cat > "$CSS_FILE" << EOF
/* $PAGE_NAME Page */
.${PAGE_NAME,,}-page {
  padding: 1rem;
}

.${PAGE_NAME,,}-page h1 {
  margin-bottom: 1rem;
}
EOF

# Crea TSX
cat > "$TSX_FILE" << EOF
import './$PAGE_NAME.css';

const $PAGE_NAME = () => {
  return (
    <div className="${PAGE_NAME,,}-page">
      <h1>$PAGE_NAME Page</h1>
      <p>Welcome to the $PAGE_NAME page!</p>
    </div>
  );
};

export default $PAGE_NAME;
EOF