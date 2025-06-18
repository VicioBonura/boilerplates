#!/bin/bash
# --------------------------
#  React Quick Setup 
# --------------------------

PROJECT_NAME="$1"

if [ -z "$1" ]; then
  echo "  -> Uso: ./setup.sh nome-progetto"
  echo "  -> Esempio: ./setup.sh my-app"
  exit 1
fi

echo "  Configurazione progetto React: $PROJECT_NAME"

# 1. Crea progetto Vite
echo "  Creazione progetto Vite..."
npm create vite@latest "$PROJECT_NAME" -- --template react-ts

cd "$PROJECT_NAME"

# 2. Installa dipendenze
echo "  Installazione dipendenze..."
npm install
npm install react-router react-icons
echo "  Installazione dipendenze opzionali..."
npm install jwt-decode

# 3. Pulizia boilerplate
echo "  Pulizia boilerplate..."
rm -f src/assets/react.svg public/vite.svg

# 4. Crea struttura cartelle
echo "  Creazione struttura cartelle..."
mkdir -p src/{components,pages,hooks,services,contexts,types,routes,layouts}

# 5. Crea file CSS base
echo "  Configurazione CSS base..."
cat > "src/index.css" << 'EOF'
/* Global */

@import url("https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap");

:root {
  /* Colors */
  --primary: #3e8ee9;
  --accent: #d79430;
  --text-primary: #232323;
  --text-negative: #f0f4f9;
  --primary-hover: hsl(from var(--primary) h s calc(l + 20));

  /* Backgrounds */
  --bg-light: #f0f4f9;
  --bg-primary: var(--primary);
  --bg-primary-light: hsl(from var(--bg-primary) h s calc(l + 20));
  --bg-primary-dark: hsl(from var(--bg-primary) h s calc(l - 20));
  --bg-dark: #404040;

  /* Sizes */
  --header-h: 6rem;
  --navbar-h: 4rem;
  --touch-h: 3rem;
  --footer-h: 3rem;

  /* Typography */
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
.flex { display: flex; }
.flex-col { flex-direction: column; }
.items-center { align-items: center; }
.justify-center { justify-content: center; }
.flex-center { align-items: center; justify-content: center; }

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
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}

@media (max-width: 768px) {
  .container { 
    padding: 0 0.5rem; 
  }
}
EOF

# 6. Crea App.tsx base
echo "  Configurazione App.tsx..."
cat > "src/App.tsx" << 'EOF'
import { RouterProvider } from "react-router";
import router from "./routes/routes";
import "./App.css";

function App() {
  return <RouterProvider router={router} />;
}

export default App;
EOF

# 7. Pulisci App.css
echo "" > "src/App.css"

# 8. Crea routes base
echo "  Configurazione routing base..."
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
    ],
  },
  {
    path: "*",
    element: <NotFound />,
  },
]);

export default router;
EOF

# 9. Crea componente Header
echo "  Creazione componente Header..."
mkdir -p "src/components/Header"
cat > "src/components/Header/Header.tsx" << 'EOF'
import './Header.css';

const Header = () => {
  return (
    <header>
      <h1>La Mia App</h1>
    </header>
  );
};

export default Header;
EOF

cat > "src/components/Header/Header.css" << 'EOF'
header {
  height: var(--header-h);
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--text-negative);
  background: var(--bg-primary);
}
EOF

# 10. Crea MainLayout
echo "  Creazione MainLayout..."
mkdir -p "src/layouts/MainLayout"
cat > "src/layouts/MainLayout/MainLayout.tsx" << 'EOF'
import { Outlet } from 'react-router';
import Header from '../../components/Header/Header';
import './MainLayout.css';

const MainLayout = () => {
  return (
    <div id="app-container">
      <Header />
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
  min-height: 100vh;
}

main {
  flex: 1;
  padding: 1rem;
}
EOF

# 11. Crea Home page
echo "  Creazione pagina Home..."
mkdir -p "src/pages/Home"
cat > "src/pages/Home/Home.tsx" << 'EOF'
import './Home.css';

const Home = () => {
  return (
    <div className="home-page">
      <h1>Benvenuto nella tua App</h1>
      <p>Pronto per iniziare a codificare!</p>
      <div className="quick-actions">
        <button className="btn btn-primary">Inizia</button>
      </div>
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
  color: #333;
}

.quick-actions {
  margin-top: 2rem;
}
EOF

# 12. Crea 404 page
echo "  Creazione pagina 404..."
mkdir -p "src/pages/NotFound"
cat > "src/pages/NotFound/NotFound.tsx" << 'EOF'
import { Link } from 'react-router';
import './NotFound.css';

const NotFound = () => {
  return (
    <div className="not-found">
      <h1>404 - Pagina Non Trovata</h1>
      <p>La pagina che stai cercando non esiste.</p>
      <Link to="/" className="btn btn-primary">Torna alla Home</Link>
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

# 13. Test build
echo "  Test della build..."
npm run build

echo ""
echo "  Configurazione progetto completata!"
echo "  Progetto: $PROJECT_NAME"
echo "  Avvia server dev: cd $PROJECT_NAME && npm run dev"
echo ""
echo "  Cosa è stato configurato:"
echo "    Vite + React + TypeScript"
echo "    React Router con routing base"
echo "    Struttura cartelle per il progetto"
echo "    CSS utilities base"
echo "    Componente Header"
echo "    MainLayout con Header importato"
echo "    Pagine Home e 404"
echo "    Build testata con successo"
echo ""