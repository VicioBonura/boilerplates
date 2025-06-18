#!/bin/bash
# --------------------------
#  React Quick Setup 
# --------------------------

PROJECT_NAME="$1"

if [ -z "$1" ]; then
  echo "Usage: ./setup.sh project-name"
  echo "Example: ./setup.sh my-app"
  exit 1
fi

echo "Setting up React project: $PROJECT_NAME"

# 1. Crea progetto Vite
echo "Creating Vite project..."
npm create vite@latest "$PROJECT_NAME" -- --template react-ts

cd "$PROJECT_NAME"

# 2. Installa dipendenze
echo "Installing dependencies..."
npm install
npm install react-router react-icons
echo "Installing optional dependencies..."
npm install jwt-decode

# 3. Pulizia boilerplate
echo "Cleaning boilerplate..."
rm -f src/assets/react.svg public/vite.svg

# 4. Crea struttura cartelle
echo "Creating folder structure..."
mkdir -p src/{components,pages,hooks,services,contexts,types,routes,layouts}

# 5. Crea file CSS base
echo "Setting up base CSS..."
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
echo "Setting up App.tsx..."
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
echo "Setting up basic routing..."
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

# 9. Crea MainLayout
echo "Creating MainLayout..."
mkdir -p "src/layouts/MainLayout"
cat > "src/layouts/MainLayout/MainLayout.tsx" << 'EOF'
import { Outlet } from 'react-router';
import './MainLayout.css';

const MainLayout = () => {
  return (
    <div id="app-container">
      <header>
        <h1>My Exam App</h1>
      </header>
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

header {
  padding: 1rem;
  background: #f8f9fa;
  border-bottom: 1px solid #dee2e6;
}

main {
  flex: 1;
  padding: 1rem;
}
EOF

# 10. Crea Home page
echo "Creating Home page..."
mkdir -p "src/pages/Home"
cat > "src/pages/Home/Home.tsx" << 'EOF'
import './Home.css';

const Home = () => {
  return (
    <div className="home-page">
      <h1>Welcome to Your App</h1>
      <p>Ready to start coding!</p>
      <div className="quick-actions">
        <button className="btn btn-primary">Get Started</button>
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

# 11. Crea 404 page
echo "Creating 404 page..."
mkdir -p "src/pages/NotFound"
cat > "src/pages/NotFound/NotFound.tsx" << 'EOF'
import { Link } from 'react-router';
import './NotFound.css';

const NotFound = () => {
  return (
    <div className="not-found">
      <h1>404 - Page Not Found</h1>
      <p>The page you're looking for doesn't exist.</p>
      <Link to="/" className="btn btn-primary">Go back to Home</Link>
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
echo "Testing build..."
npm run build

echo ""
echo "✅ Project setup complete!"
echo "📁 Project: $PROJECT_NAME"
echo "🌐 Start dev server: cd $PROJECT_NAME && npm run dev"
echo ""
echo "📋 What's been set up:"
echo "   ✅ Vite + React + TypeScript"
echo "   ✅ React Router with basic routing"
echo "   ✅ Folder structure for exam"
echo "   ✅ Basic CSS utilities"
echo "   ✅ MainLayout with Header"
echo "   ✅ Home and 404 pages"
echo "   ✅ Build tested successfully"
echo ""
echo "🚀 Ready for your exam! Good luck!" 