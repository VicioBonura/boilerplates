#!/bin/bash
# ---------------------------------
#  React-Project Setup MIN
# ---------------------------------
# Descrizione       : Setup minimo per progetto React
# Autore            : Vincenzo Bonura
# Data              : 2025-06-23
# Aggiornato        : 2025-06-23
# Versione          : 0.1.0
# ---------------------------------
# Utilizzo          :
#   rsetup-min name : Crea un nuovo progetto React con nome prj-name
# ---------------------------------
# Dependencies      :
#                   : shell.sh
#                   : ./modules/colors.sh
# ---------------------------------

PROJECT_NAME="$1"

if [ -z "$1" ]; then
  echo "  -> Uso: ./setup-min.sh nome-progetto"
  echo "  -> Esempio: ./setup-min.sh my-app"
  exit 1
fi

# Determina il percorso base dello script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Carica modulo colori
if [[ -f "$SCRIPT_DIR/modules/colors.sh" ]]; then
    source "$SCRIPT_DIR/modules/colors.sh"
else
    echo "  -> Errore: Modulo colors.sh non trovato in $SCRIPT_DIR/modules/"
    exit 1
fi

print_color -n "$CYAN" "  Configurazione progetto React:" 
echo " $PROJECT_NAME"

# ---------------------------------
#  Indice 
# ---------------------------------
# 1. Crea progetto Vite
# 2. Installa dipendenze
# 3. Pulizia boilerplate
# 4. Crea struttura cartelle
# 5. Crea file CSS base
# 6. Crea App.tsx
# 7. Pulizia App.css
# 8. Crea routes
# 9. Crea layout MainLayout
# 10. Crea pagina Home
# 11. Crea pagina 404
# 12. Test build
# ---------------------------------

# 1. Crea progetto Vite
print_info "  Creazione progetto Vite..."
npm create vite@latest "$PROJECT_NAME" -- --template react-ts

cd "$PROJECT_NAME"

# 2. Installa dipendenze
print_info "  Installazione dipendenze: react-router, react-icons..."
npm install
npm install react-router react-icons
print_info "  Installazione dipendenze opzionali: jwt-decode, son-server..."
npm install jwt-decode json-server

# 3. Pulizia boilerplate
print_info "  Pulizia boilerplate..."
rm -f public/vite.svg
mv src/assets/react.svg public/react.svg

# 4. Crea struttura cartelle
print_info "  Creazione struttura cartelle..."
mkdir -p src/{components,pages,hooks,routes,layouts}

# 5. Crea file CSS base
print_info "  Configurazione CSS base..."
cat > "src/index.css" << 'EOF'
/* Global */

@import url("https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap");

:root {
  /* Colors */
  --primary: #3e8ee9;
  --accent: #d79430;
  --primary-hover: hsl(from var(--bg-primary) h s calc(l - 10));
  --primary-active: hsl(from var(--bg-primary) h s calc(l - 15));

  --white: #f0f4f9;
  --black: #232323;
  --light-gray: color-mix(in hsl, var(--black) 10%, var(--white));
  --mid-gray: color-mix(in hsl, var(--black), var(--white));
  --dark-gray: color-mix(in hsl, var(--black) 70%, var(--white));

  --border-primary: var(--light-gray);

  /* Backgrounds */
  --bg-white: var(--white);
  --bg-black: var(--black);
  --bg-light: var(--light-gray);
  --bg-mid: var(--mid-gray);
  --bg-dark: var(--dark-gray);

  --bg-primary: var(--primary);
  --bg-primary-light: hsl(from var(--bg-primary) h s calc(l + 10));
  --bg-primary-dark: hsl(from var(--bg-primary) h s calc(l - 10));

  /* Sizes */
  --header-h: 6rem;
  --navbar-h: 4rem;
  --touch-h: 3rem;
  --footer-h: 2rem;

  /* Typography */
  --text-primary: var(--black);
  --text-negative: var(--white);
  --f-family: Montserrat, sans-serif;
  --icon-touch-size: calc(var(--touch-h) - 1rem);
}

*,
*::after,
*::before {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: var(--f-family);
  color: var(--text-primary);
  background-color: var(--bg-light);
}

button {
  cursor: pointer;
  border: none;
  background: none;
  font-family: inherit;
}

a {
  text-decoration: none;
  color: inherit;
}

img {
  max-width: 100%;
  height: auto;
}

/* Utility Classes */
.flex {
  display: flex;
}
.flex-col {
  flex-direction: column;
}
.items-center {
  align-items: center;
}
.justify-center {
  justify-content: center;
}
.flex-center {
  align-items: center;
  justify-content: center;
}

.btn {
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 0.25rem;
  cursor: pointer;
}

.btn-primary {
  background: var(--bg-primary);
  color: var(--text-negative);
}

.btn-primary:hover {
  background: var(--bg-primary-light);
}

.container {
  margin: 0 auto;
  padding: 0 1rem;
}

@media (min-width: 768px) {
  .container {
    max-width: 1200px;
  }
}
EOF

# 6. Crea App.tsx
print_info "  Configurazione App.tsx..."
cat > "src/App.tsx" << 'EOF'
import { RouterProvider } from "react-router";
import router from "./routes/routes";
import "./App.css";

function App() {
  return (
    <RouterProvider router={router} />
  );
}

export default App;
EOF

# 7. Pulizia App.css
print_info "  Pulizia App.css..."
echo "" > "src/App.css"

# 8. Crea routes
print_info "  Configurazione routing..."
cat > "src/routes/routes.tsx" << 'EOF'
import { createBrowserRouter } from "react-router";
import MainLayout from "../layouts/MainLayout/MainLayout";
import Home from "../pages/Home/Home";
import NotFound from "../pages/NotFound/NotFound";

const router = createBrowserRouter([
  {
    path: "/",
    element: <MainLayout />,
    children: [
      {
        path: "/",
        element: <Home />,
      },
      {
        path: "*",
        element: <NotFound />,
      },
    ],
  },
]);

export default router;
EOF

# 9. Crea layout MainLayout
print_info "  Creazione MainLayout..."
mkdir -p src/layouts/MainLayout
cat > "src/layouts/MainLayout/MainLayout.tsx" << 'EOF'
import { Outlet } from "react-router";
import "./MainLayout.css";

const MainLayout = () => {
  return (
    <div id="app-container">
      <main>
        <Outlet />
      </main>
    </div>
  );
};

export default MainLayout;
EOF

cat > "src/layouts/MainLayout/MainLayout.css" << 'EOF'
#app-container {
  display: flex;
  flex-direction: column;
  min-height: 100dvh;
  overflow-x: hidden;
  padding-bottom: var(--navbar-h);
}

main {
  flex: 1;
  padding: 1rem;
}

/* Layout Desktop */
@media (min-width: 769px) {
  #app-container {
    padding-bottom: 0;
  }
}
EOF

# 10. Crea pagina Home
print_info "  Creazione pagina Home..."
mkdir -p src/pages/Home
cat > "src/pages/Home/Home.tsx" << EOF
import './Home.css';

const Home = () => {
  return (
    <div className="home-page">
      <h1>$PROJECT_NAME App</h1>
      <p>Homepage</p>
    </div>
  );
};

export default Home;
EOF

cat > "src/pages/Home/Home.css" << 'EOF'
.home-page {
  text-align: center;
  padding: 2rem;
}

.home-page h1 {
  margin-bottom: 1rem;
}

EOF

# 11. Crea pagina NotFound
print_info "  Creazione pagina 404..."
mkdir -p src/pages/NotFound
cat > "src/pages/NotFound/NotFound.tsx" << 'EOF'
import { Link } from "react-router";
import "./NotFound.css";

const NotFound = () => {
  return (
    <div className="not-found">
      <h1>404 - Page Not Found</h1>
      <p>The page you are looking for does not exist.</p>
      <Link to="/" className="btn btn-primary">Go to Home</Link>
    </div>
  );
};

export default NotFound;
EOF

cat > "src/pages/NotFound/NotFound.css" << 'EOF'
.not-found {
  text-align: center;
  padding: 4rem 2rem;
}

.not-found h1 {
  margin-bottom: 1rem;
  color: #dc3545;
}

.not-found p {
  margin-bottom: 2rem;
  color: #666;
}
EOF

# 12. Test build
print_warning "  Test della build..."
npm run build

echo ""
print_success "  Configurazione progetto completata!"
print_color -n "$CYAN" "  Progetto: "
echo " $PROJECT_NAME"
echo ""
print_info "  Sono stati configurati:"
echo "    Vite + React + TypeScript"
echo "    dipendenze: react-router, react-icons, jwt-decode, json-server"
echo "    Struttura cartelle"
echo "    CSS utilities e variabili"
echo "    MainLayout"
echo "    Pagine: Home, 404"
echo "    Routes"
echo "    Build testata"

cd "$PROJECT_ROOT"