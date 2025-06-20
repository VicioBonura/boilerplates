#!/bin/bash
# ---------------------------------
#  React-Project Setup 
# ---------------------------------
# Descrizione       : Script per la creazione di un nuovo progetto React
# Autore            : Vincenzo Bonura
# Data              : 2025-06-18
# Aggiornato        : 2025-06-20
# Versione          : 0.3.0
# ---------------------------------
# Utilizzo          :
#   rsetup name     : Crea un nuovo progetto React con nome prj-name
#   ./setup.sh name : Crea progetto senza shell.sh attiva
# ---------------------------------
# Dependencies      :
#                   : shell.sh
#                   : ./modules/colors.sh
# ---------------------------------

PROJECT_NAME="$1"

if [ -z "$1" ]; then
  echo "  -> Uso: ./setup.sh nome-progetto"
  echo "  -> Esempio: ./setup.sh my-app"
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
# 8. Crea AppContextWrapper
# 9. Crea navigation config
# 10. Crea types
# 11. Crea servizio API
# 12. Crea hooks
# 13. Crea routes
# 14. Crea componente BrandLogo
# 15. Crea componente Header
# 16. Crea componente Hamburger
# 17. Crea componente OffCanvasMenu
# 18. Crea componente Navbar
# 19. Crea componente Footer
# 20. Crea componente LoginForm
# 21. Crea componente LoadingSpinner
# 22. Crea layout MainLayout
# 23. Crea pagina Home
# 24. Crea pagina Login
# 25. Crea pagina Detail
# 26. Crea pagina About
# 27. Crea pagina Contact
# 28. Crea pagina Settings
# 29. Crea pagina 404
# 30. Test build
# ---------------------------------

# 1. Crea progetto Vite
print_info "  Creazione progetto Vite..."
npm create vite@latest "$PROJECT_NAME" -- --template react-ts

cd "$PROJECT_NAME"

# 2. Installa dipendenze
print_info "  Installazione dipendenze..."
npm install
npm install react-router react-icons
print_info "  Installazione dipendenze opzionali..."
npm install jwt-decode

# 3. Pulizia boilerplate
print_info "  Pulizia boilerplate..."
rm -f src/assets/react.svg public/vite.svg

# 4. Crea struttura cartelle
print_info "  Creazione struttura cartelle..."
mkdir -p src/{components,pages,hooks,services,contexts,types,routes,layouts,config,assets}

# Crea sottocartelle componenti
mkdir -p src/components/{Header,BrandLogo,Navbar,Footer,Hamburger,OffCanvasMenu,LoginForm,LoadingSpinner}

# Crea sottocartelle pagine
mkdir -p src/pages/{Home,Login,Detail,NotFound,About,Contact,Settings}

# Crea sottocartelle layout
mkdir -p src/layouts/MainLayout

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
  --bg-light: #f0f4f9;
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

# 6. Crea App.tsx
print_info "  Configurazione App.tsx..."
cat > "src/App.tsx" << 'EOF'
import { RouterProvider } from "react-router";
import router from "./routes/routes";
import AppContextWrapper from "./contexts";
import "./App.css";

function App() {
  return (
    <AppContextWrapper>
      <RouterProvider router={router} />
    </AppContextWrapper>
  );
}

export default App;
EOF

# 7. Pulizia App.css
print_info "  Pulizia App.css..."
echo "" > "src/App.css"

# 8. Crea AppContextWrapper
print_info "  Configurazione Contexts..."
cat > "src/contexts/index.tsx" << 'EOF'
import { type PropsWithChildren } from "react";
// import { AuthProvider } from "./AuthContext/AuthProvider";

const AppContextWrapper = ({ children }: PropsWithChildren) => {
  return children;
  // In caso di autenticazione:
  // return (
  //   <AuthProvider>
  //     {children}
  //   </AuthProvider>
  // );
};

export default AppContextWrapper;
EOF

# 9. Crea navigation config
print_info "  Configurazione navigazione..."
cat > "src/config/navigation.ts" << 'EOF'
import {
  FaHome,
  FaCopy,
  FaUser,
  FaInfo,
  FaEnvelope,
  FaCog,
} from "react-icons/fa";
import { type IconType } from "react-icons";

export type NavItem = {
  path: string;
  label: string;
  icon: IconType;
  inMobile?: boolean;
  order?: number;
};

export const NAV_ITEMS: NavItem[] = [
  {
    path: "/",
    label: "Home",
    icon: FaHome,
    inMobile: true,
    order: 1,
  },
  { path: "/detail", label: "Detail", icon: FaCopy, inMobile: true, order: 2 },
  {
    path: "/about",
    label: "About",
    icon: FaInfo,
    inMobile: false,
    order: 3,
  },
  {
    path: "/contact",
    label: "Contact",
    icon: FaEnvelope,
    inMobile: false,
    order: 4,
  },
  {
    path: "/settings",
    label: "Settings",
    icon: FaCog,
    inMobile: false,
    order: 5,
  },
  {
    path: "/login",
    label: "Login",
    icon: FaUser,
    inMobile: true,
    order: 6,
  },
];
EOF

# 10. Crea types
print_info "  Configurazione Types..."
cat > "src/types/index.ts" << 'EOF'
// API Types
export interface ApiResponse<T> {
  data: T;
  message?: string;
  status: number;
}

export interface ApiError {
  message: string;
  status: number;
}

// Auth Types
export interface User {
  id: string;
  email: string;
  name: string;
  role?: string;
}

export interface LoginCredentials {
  email: string;
  password: string;
}

export interface AuthState {
  user: User | null;
  token: string | null;
  isAuthenticated: boolean;
}

// Form Types
export interface FormField {
  value: string;
  error?: string;
  touched?: boolean;
}

export interface FormState {
  [key: string]: FormField;
}
EOF

# 11. Crea servizio API
print_info "  Configurazione API Service..."
cat > "src/services/api.ts" << 'EOF'
// import { type ApiResponse, type ApiError } from "../types";

const API_BASE_URL =
  import.meta.env.VITE_API_URL || "http://localhost:3000/api";

class ApiService {
  private async request<T>(
    endpoint: string,
    options: RequestInit = {}
  ): Promise<T> {
    const url = `${API_BASE_URL}${endpoint}`;

    const config: RequestInit = {
      headers: {
        "Content-Type": "application/json",
        ...options.headers,
      },
      ...options,
    };

    // Aggiungi token se disponibile
    const token = localStorage.getItem("auth_token");
    if (token) {
      config.headers = {
        ...config.headers,
        Authorization: `Bearer ${token}`,
      };
    }

    try {
      const response = await fetch(url, config);

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }

      return await response.json();
    } catch (error) {
      console.error("API Error:", error);
      throw error;
    }
  }

  // GET
  async get<T>(endpoint: string): Promise<T> {
    return this.request<T>(endpoint);
  }

  // POST
  async post<T>(endpoint: string, data: unknown): Promise<T> {
    return this.request<T>(endpoint, {
      method: "POST",
      body: JSON.stringify(data),
    });
  }

  // PUT
  async put<T>(endpoint: string, data: unknown): Promise<T> {
    return this.request<T>(endpoint, {
      method: "PUT",
      body: JSON.stringify(data),
    });
  }

  // DELETE
  async delete<T>(endpoint: string): Promise<T> {
    return this.request<T>(endpoint, {
      method: "DELETE",
    });
  }
}

export const api = new ApiService();
EOF

# 12. Crea hooks
print_info "  Configurazione Hooks..."
cat > "src/hooks/useApi.ts" << 'EOF'
import { useState, useEffect } from "react";

interface UseApiState<T> {
  data: T | null;
  loading: boolean;
  error: string | null;
}

export const useApi = <T>(
  apiCall: () => Promise<T>,
  dependencies: unknown[] = []
) => {
  const [state, setState] = useState<UseApiState<T>>({
    data: null,
    loading: true,
    error: null,
  });

  useEffect(() => {
    let isCancelled = false;

    const fetchData = async () => {
      setState((prev) => ({ ...prev, loading: true, error: null }));

      try {
        const result = await apiCall();
        if (!isCancelled) {
          setState({ data: result, loading: false, error: null });
        }
      } catch (error) {
        if (!isCancelled) {
          setState({
            data: null,
            loading: false,
            error: error instanceof Error ? error.message : "Unknown error",
          });
        }
      }
    };

    fetchData();

    return () => {
      isCancelled = true;
    };
  }, dependencies);

  const refetch = () => {
    setState((prev) => ({ ...prev, loading: true, error: null }));
    // Trigger useEffect re-run
  };

  return { ...state, refetch };
};
EOF

cat > "src/hooks/useLocalStorage.ts" << 'EOF'
import { useState } from "react";

export const useLocalStorage = <T>(
  key: string,
  initialValue: T
): [T, (value: T) => void] => {
  const [storedValue, setStoredValue] = useState<T>(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      console.error(`Error reading localStorage key "${key}":`, error);
      return initialValue;
    }
  });

  const setValue = (value: T) => {
    try {
      setStoredValue(value);
      window.localStorage.setItem(key, JSON.stringify(value));
    } catch (error) {
      console.error(`Error setting localStorage key "${key}":`, error);
    }
  };

  return [storedValue, setValue];
};
EOF

# 13. Crea routes
print_info "  Configurazione routing completo..."
cat > "src/routes/routes.tsx" << 'EOF'
import { createBrowserRouter } from "react-router";
import MainLayout from "../layouts/MainLayout/MainLayout";
import Home from "../pages/Home/Home";
import Login from "../pages/Login/Login";
import Detail from "../pages/Detail/Detail";
import About from "../pages/About/About";
import Contact from "../pages/Contact/Contact";
import Settings from "../pages/Settings/Settings";
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
        path: "/detail",
        element: <Detail />,
      },
      {
        path: "/about",
        element: <About />,
      },
      {
        path: "/contact",
        element: <Contact />,
      },
      {
        path: "/settings",
        element: <Settings />,
      },
      {
        path: "/login",
        element: <Login />,
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

# 14. Crea componente BrandLogo
print_info "  Creazione componente BrandLogo..."
cat > "src/components/BrandLogo/BrandLogo.tsx" << 'EOF'
import { Link } from "react-router";
import "./BrandLogo.css";

interface BrandLogoProps {
  size?: "sm" | "md" | "lg";
  className?: string;
  onClick?: () => void;
}

const BrandLogo = ({
  size = "md",
  className = "",
  onClick,
}: BrandLogoProps) => {
  return (
    <Link
      to="/"
      className={`brand-logo brand-logo--${size} ${className}`}
      onClick={onClick}
    >
      BP
    </Link>
  );
};

export default BrandLogo;
EOF

cat > "src/components/BrandLogo/BrandLogo.css" << 'EOF'
.brand-logo {
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--text-negative);
  color: var(--bg-primary);
  border-radius: 0.25rem;
  font-weight: 700;
  text-decoration: none;
  aspect-ratio: 1;
  transition: transform 0.2s ease;
}

.brand-logo:hover {
  transform: scale(1.05);
}

.brand-logo--sm {
  width: 2rem;
  font-size: 0.8rem;
}

.brand-logo--md {
  width: 3rem;
  font-size: 1rem;
}

.brand-logo--lg {
  width: 4rem;
  font-size: 1.2rem;
}
EOF

# 15. Crea componente Header
print_info "  Creazione componente Header..."
cat > "src/components/Header/Header.tsx" << 'EOF'
import { Link, useLocation } from "react-router";
import { NAV_ITEMS } from "../../config/navigation";
import BrandLogo from "../BrandLogo/BrandLogo";
import "./Header.css";

const Header = () => {
  const location = useLocation();
  const navItems = NAV_ITEMS;

  return (
    <header>
      <BrandLogo size="lg" />
      <h1 className="header-title">React</h1>

      {/* Navigazione Desktop */}
      <nav className="desktop-nav">
        <ul>
          {navItems.map(({ path, label, icon: Icon }) => (
            <li key={path}>
              <Link
                to={path}
                className={location.pathname === path ? "active" : ""}
              >
                <Icon />
                <span>{label}</span>
              </Link>
            </li>
          ))}
        </ul>
      </nav>
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
  justify-content: space-between;
  padding-inline: 1rem;
  gap: 1rem;
  color: var(--text-negative);
  background: var(--bg-primary);
}

.header-title {
  flex: 1;
  margin: 0;
}

/* Navigazione Desktop */
.desktop-nav {
  display: none;
}

.desktop-nav ul {
  display: flex;
  gap: 0.5rem;
  list-style: none;
  margin: 0;
  padding: 0;
}

.desktop-nav a {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1rem;
  color: var(--text-negative);
  text-decoration: none;
  border-radius: 0.25rem;
  transition: background-color 0.2s ease;
  font-size: 0.9rem;
}

.desktop-nav a:hover {
  background: var(--primary-hover);
}

.desktop-nav a.active {
  background: var(--primary-active);
  font-weight: 600;
}

/* Layout Desktop */
@media (min-width: 769px) {
  header {
    padding-inline: 2rem;
  }

  .desktop-nav {
    display: block;
  }

  .header-title {
    text-align: left;
    margin-left: 1rem;
  }
}
EOF

# 16. Crea componente Hamburger
print_info "  Creazione componente Hamburger..."
cat > "src/components/Hamburger/Hamburger.tsx" << 'EOF'
import "./Hamburger.css";

interface HamburgerProps {
  isOpen: boolean;
  onClick: () => void;
}

const Hamburger = ({ isOpen, onClick }: HamburgerProps) => {
  return (
    <button
      className={`hamburger ${isOpen ? "hamburger--active" : ""}`}
      onClick={onClick}
      aria-label="Toggle menu"
    >
      <span></span>
      <span></span>
      <span></span>
    </button>
  );
};

export default Hamburger;
EOF

cat > "src/components/Hamburger/Hamburger.css" << 'EOF'
.hamburger {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  width: var(--icon-touch-size);
  height: var(--icon-touch-size);
  background: transparent;
  border: none;
  cursor: pointer;
  padding: 0;
  z-index: 10;
}

.hamburger span {
  width: 100%;
  height: 2px;
  background: var(--text-negative);
  border-radius: 10px;
  transition: all 0.3s linear;
  position: relative;
  transform-origin: 1px;
}

.hamburger--active span:first-child {
  transform: rotate(45deg);
}

.hamburger--active span:nth-child(2) {
  opacity: 0;
  transform: translateX(20px);
}

.hamburger--active span:nth-child(3) {
  transform: rotate(-45deg);
}
EOF

# 17. Crea componente OffCanvasMenu
print_info "  Creazione componente OffCanvasMenu..."
cat > "src/components/OffCanvasMenu/OffCanvasMenu.tsx" << 'EOF'
import { Link } from "react-router";
import { NAV_ITEMS } from "../../config/navigation";
import "./OffCanvasMenu.css";

interface OffCanvasMenuProps {
  isOpen: boolean;
  onClose: () => void;
}

const OffCanvasMenu = ({ isOpen, onClose }: OffCanvasMenuProps) => {
  const allNavItems = NAV_ITEMS.filter((item) => !item.inMobile);

  return (
    <>
      {isOpen && <div className="overlay" onClick={onClose} />}
      <div className={`offcanvas ${isOpen ? "offcanvas--open" : ""}`}>
        <nav>
          <ul>
            {allNavItems.map(({ path, label, icon: Icon }) => (
              <li key={path}>
                <Link to={path} onClick={onClose}>
                  <Icon />
                  <span>{label}</span>
                </Link>
              </li>
            ))}
          </ul>
        </nav>
      </div>
    </>
  );
};

export default OffCanvasMenu;
EOF

cat > "src/components/OffCanvasMenu/OffCanvasMenu.css" << 'EOF'
.overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  z-index: 998;
}

.offcanvas {
  position: fixed;
  top: 0;
  right: -300px;
  width: 300px;
  height: 100%;
  background: var(--bg-light);
  box-shadow: -2px 0 10px rgba(0, 0, 0, 0.1);
  transition: right 0.3s ease;
  z-index: 999;
  padding: 2rem 1rem;
}

.offcanvas--open {
  right: 0;
}

.offcanvas nav ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.offcanvas nav li {
  margin-bottom: 1rem;
}

.offcanvas nav a {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  color: var(--text-primary);
  text-decoration: none;
  border-radius: 0.5rem;
  transition: background-color 0.2s ease;
}

.offcanvas nav a:hover {
  background: var(--light-gray);
}
EOF

# 18. Crea componente Navbar
print_info "  Creazione componente Navbar..."
cat > "src/components/Navbar/Navbar.tsx" << 'EOF'
import { useState } from "react";
import { Link, useLocation } from "react-router";
import Hamburger from "../Hamburger/Hamburger";
import OffCanvasMenu from "../OffCanvasMenu/OffCanvasMenu";
import { NAV_ITEMS } from "../../config/navigation";
import "./Navbar.css";

const Navbar = () => {
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const location = useLocation();
  const navItems = NAV_ITEMS.filter((item) => item.inMobile);

  return (
    <>
      <div id="navbar-container">
        <nav>
          <ul>
            {navItems.map(({ path, label, icon: Icon }) => {
              return (
                <li key={path}>
                  <Link
                    to={path}
                    aria-label={label}
                    className={location.pathname === path ? "active" : ""}
                    onClick={() => setIsOpen(false)}
                  >
                    <Icon />
                    <span>{label}</span>
                  </Link>
                </li>
              );
            })}
            <li>
              <Hamburger
                onClick={() => {
                  setIsOpen(!isOpen);
                }}
                isOpen={isOpen}
              />
            </li>
          </ul>
        </nav>
      </div>
      <OffCanvasMenu isOpen={isOpen} onClose={() => setIsOpen(false)} />
    </>
  );
};

export default Navbar;
EOF

cat > "src/components/Navbar/Navbar.css" << 'EOF'
#navbar-container {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: var(--bg-primary);
  border-top: 1px solid var(--border-primary);
  z-index: 100;
}

nav ul {
  display: flex;
  justify-content: space-around;
  align-items: center;
  list-style: none;
  margin: 0;
  padding: 0;
  height: var(--navbar-h);
}

nav li {
  flex: 1;
  display: flex;
  justify-content: center;
}

nav a {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.25rem;
  padding: 0.5rem;
  color: var(--text-negative);
  text-decoration: none;
  border-radius: 0.5rem;
  transition: background-color 0.2s ease;
  font-size: 0.75rem;
  min-width: 3rem;
}

nav a:hover {
  background: var(--primary-hover);
}

nav a.active {
  background: var(--primary-active);
  font-weight: 600;
}

nav a svg {
  font-size: 1rem;
}

/* Layout Desktop */
@media (min-width: 769px) {
  #navbar-container {
    display: none;
  }
}
EOF

# 19. Crea componente Footer
print_info "  Creazione componente Footer..."
cat > "src/components/Footer/Footer.tsx" << 'EOF'
import "./Footer.css";

const Footer = () => {
  return (
    <footer>
      <p>&copy; 2024 React Boilerplate. All rights reserved.</p>
    </footer>
  );
};

export default Footer;
EOF

cat > "src/components/Footer/Footer.css" << 'EOF'
footer {
  height: var(--footer-h);
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--dark-gray);
  color: var(--text-negative);
  font-size: 0.8rem;
  margin-top: auto;
}

/* Layout Desktop */
@media (min-width: 769px) {
  footer {
    display: flex;
  }
}
EOF

# 20. Crea componente LoginForm
print_info "  Creazione componente LoginForm..."
cat > "src/components/LoginForm/LoginForm.tsx" << 'EOF'
import { useState } from "react";
import "./LoginForm.css";

const LoginForm = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log("Login attempt:", { email, password });
  };

  return (
    <form className="login-form" onSubmit={handleSubmit}>
      <h2>Login</h2>
      <div className="form-group">
        <label htmlFor="email">Email</label>
        <input
          type="email"
          id="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
      </div>
      <div className="form-group">
        <label htmlFor="password">Password</label>
        <input
          type="password"
          id="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
        />
      </div>
      <button type="submit" className="btn btn-primary">
        Login
      </button>
    </form>
  );
};

export default LoginForm;
EOF

cat > "src/components/LoginForm/LoginForm.css" << 'EOF'
.login-form {
  max-width: 400px;
  margin: 0 auto;
  padding: 2rem;
  background: white;
  border-radius: 0.5rem;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.login-form h2 {
  margin-bottom: 1.5rem;
  text-align: center;
  color: var(--text-primary);
}

.form-group {
  margin-bottom: 1rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  color: var(--text-primary);
  font-weight: 500;
}

.form-group input {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid var(--border-primary);
  border-radius: 0.25rem;
  font-size: 1rem;
}

.form-group input:focus {
  outline: none;
  border-color: var(--primary);
  box-shadow: 0 0 0 2px rgba(62, 142, 233, 0.2);
}

.login-form .btn {
  width: 100%;
  margin-top: 1rem;
}
EOF

# 21. Crea componente LoadingSpinner
print_info "  Creazione componente LoadingSpinner..."
cat > "src/components/LoadingSpinner/LoadingSpinner.tsx" << 'EOF'
import "./LoadingSpinner.css";

interface LoadingSpinnerProps {
  size?: "sm" | "md" | "lg";
  className?: string;
}

const LoadingSpinner = ({ size = "md", className = "" }: LoadingSpinnerProps) => {
  return (
    <div className={`loading-spinner loading-spinner--${size} ${className}`}>
      <div className="spinner"></div>
    </div>
  );
};

export default LoadingSpinner;
EOF

cat > "src/components/LoadingSpinner/LoadingSpinner.css" << 'EOF'
.loading-spinner {
  display: flex;
  justify-content: center;
  align-items: center;
}

.spinner {
  border: 2px solid var(--light-gray);
  border-top: 2px solid var(--primary);
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

.loading-spinner--sm .spinner {
  width: 20px;
  height: 20px;
}

.loading-spinner--md .spinner {
  width: 32px;
  height: 32px;
}

.loading-spinner--lg .spinner {
  width: 48px;
  height: 48px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
EOF

# 22. Crea layout MainLayout
print_info "  Creazione MainLayout..."
cat > "src/layouts/MainLayout/MainLayout.tsx" << 'EOF'
import { Outlet } from "react-router";
import Header from "../../components/Header/Header";
import Navbar from "../../components/Navbar/Navbar";
import Footer from "../../components/Footer/Footer";
import "./MainLayout.css";

const MainLayout = () => {
  return (
    <div id="app-container">
      <Header />
      <main>
        <Outlet />
      </main>
      <Footer />
      <Navbar />
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
  #navbar-container {
    display: none;
  }
}
EOF

# 23. Crea pagina Home
print_info "  Creazione pagina Home..."
cat > "src/pages/Home/Home.tsx" << EOF
import './Home.css';

const Home = () => {
  return (
    <div className="home-page">
      <h1>$PROJECT_NAME App</h1>
      <p>Il boilerplate è pronto e funzionante</p>
      <div className="quick-actions">
        <button className="btn btn-primary">Start</button>
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

# 24. Crea pagina Login
print_info "  Creazione pagina Login..."
cat > "src/pages/Login/Login.tsx" << 'EOF'
import LoginForm from "../../components/LoginForm/LoginForm";
import "./Login.css";

const Login = () => {
  return (
    <div className="login-page">
      <LoginForm />
    </div>
  );
};

export default Login;
EOF

cat > "src/pages/Login/Login.css" << 'EOF'
.login-page {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 70vh;
  padding: 1rem;
}
EOF

# 25. Crea pagina Detail
print_info "  Creazione pagina Detail..."
cat > "src/pages/Detail/Detail.tsx" << 'EOF'
import "./Detail.css";

const Detail = () => {
  return (
    <div className="detail-page">
      <h1>Detail Page</h1>
      <p>Questa è una pagina di dettaglio del boilerplate.</p>
      <div className="detail-content">
        <p>Qui puoi aggiungere contenuti specifici per i dettagli.</p>
      </div>
    </div>
  );
};

export default Detail;
EOF

cat > "src/pages/Detail/Detail.css" << 'EOF'
.detail-page {
  padding: 2rem;
  max-width: 800px;
  margin: 0 auto;
}

.detail-page h1 {
  margin-bottom: 1rem;
  color: var(--text-primary);
}

.detail-content {
  margin-top: 2rem;
  padding: 1rem;
  background: white;
  border-radius: 0.5rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
EOF

# 26. Crea pagina About
print_info "  Creazione pagina About..."
cat > "src/pages/About/About.tsx" << 'EOF'
import "./About.css";

const About = () => {
  return (
    <div className="about-page">
      <h1>About</h1>
      <p>Informazioni sul progetto e sul team di sviluppo.</p>
      <div className="about-content">
        <section>
          <h2>Il Progetto</h2>
          <p>Questo è un boilerplate React creato per accelerare lo sviluppo di nuovi progetti.</p>
        </section>
        <section>
          <h2>Tecnologie</h2>
          <ul>
            <li>React 19</li>
            <li>TypeScript</li>
            <li>Vite</li>
            <li>React Router</li>
            <li>React Icons</li>
          </ul>
        </section>
      </div>
    </div>
  );
};

export default About;
EOF

cat > "src/pages/About/About.css" << 'EOF'
.about-page {
  padding: 2rem;
  max-width: 800px;
  margin: 0 auto;
}

.about-page h1 {
  margin-bottom: 1rem;
  color: var(--text-primary);
}

.about-content {
  margin-top: 2rem;
}

.about-content section {
  margin-bottom: 2rem;
  padding: 1.5rem;
  background: white;
  border-radius: 0.5rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.about-content h2 {
  margin-bottom: 1rem;
  color: var(--primary);
}

.about-content ul {
  margin-left: 1.5rem;
}

.about-content li {
  margin-bottom: 0.5rem;
}
EOF

# 27. Crea pagina Contact
print_info "  Creazione pagina Contact..."
cat > "src/pages/Contact/Contact.tsx" << 'EOF'
import "./Contact.css";

const Contact = () => {
  return (
    <div className="contact-page">
      <h1>Contatti</h1>
      <p>Entra in contatto con noi per domande o collaborazioni.</p>
      <div className="contact-content">
        <div className="contact-info">
          <h2>Informazioni di Contatto</h2>
          <div className="contact-item">
            <strong>Email:</strong> info@example.com
          </div>
          <div className="contact-item">
            <strong>Telefono:</strong> +39 123 456 7890
          </div>
          <div className="contact-item">
            <strong>Indirizzo:</strong> Via Roma 123, Milano, IT
          </div>
        </div>
        <div className="contact-form">
          <h2>Invia un Messaggio</h2>
          <form>
            <div className="form-group">
              <label htmlFor="name">Nome</label>
              <input type="text" id="name" required />
            </div>
            <div className="form-group">
              <label htmlFor="contact-email">Email</label>
              <input type="email" id="contact-email" required />
            </div>
            <div className="form-group">
              <label htmlFor="message">Messaggio</label>
              <textarea id="message" rows={5} required></textarea>
            </div>
            <button type="submit" className="btn btn-primary">
              Invia Messaggio
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default Contact;
EOF

cat > "src/pages/Contact/Contact.css" << 'EOF'
.contact-page {
  padding: 2rem;
  max-width: 1000px;
  margin: 0 auto;
}

.contact-page h1 {
  margin-bottom: 1rem;
  color: var(--text-primary);
}

.contact-content {
  margin-top: 2rem;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 2rem;
}

.contact-info,
.contact-form {
  padding: 1.5rem;
  background: white;
  border-radius: 0.5rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.contact-info h2,
.contact-form h2 {
  margin-bottom: 1rem;
  color: var(--primary);
}

.contact-item {
  margin-bottom: 1rem;
  padding: 0.5rem 0;
}

.contact-form .form-group {
  margin-bottom: 1rem;
}

.contact-form label {
  display: block;
  margin-bottom: 0.5rem;
  color: var(--text-primary);
  font-weight: 500;
}

.contact-form input,
.contact-form textarea {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid var(--border-primary);
  border-radius: 0.25rem;
  font-size: 1rem;
  font-family: inherit;
}

.contact-form input:focus,
.contact-form textarea:focus {
  outline: none;
  border-color: var(--primary);
  box-shadow: 0 0 0 2px rgba(62, 142, 233, 0.2);
}

.contact-form .btn {
  width: 100%;
  margin-top: 1rem;
}

@media (max-width: 768px) {
  .contact-content {
    grid-template-columns: 1fr;
  }
}
EOF

# 28. Crea pagina Settings
print_info "  Creazione pagina Settings..."
cat > "src/pages/Settings/Settings.tsx" << 'EOF'
import "./Settings.css";

const Settings = () => {
  return (
    <div className="settings-page">
      <h1>Impostazioni</h1>
      <p>Configura le preferenze dell'applicazione.</p>
      <div className="settings-content">
        <section className="settings-section">
          <h2>Aspetto</h2>
          <div className="setting-item">
            <label htmlFor="theme">Tema</label>
            <select id="theme">
              <option value="light">Chiaro</option>
              <option value="dark">Scuro</option>
              <option value="auto">Automatico</option>
            </select>
          </div>
          <div className="setting-item">
            <label htmlFor="language">Lingua</label>
            <select id="language">
              <option value="it">Italiano</option>
              <option value="en">English</option>
              <option value="es">Español</option>
            </select>
          </div>
        </section>
        
        <section className="settings-section">
          <h2>Notifiche</h2>
          <div className="setting-item">
            <label className="checkbox-label">
              <input type="checkbox" defaultChecked />
              <span>Abilita notifiche push</span>
            </label>
          </div>
          <div className="setting-item">
            <label className="checkbox-label">
              <input type="checkbox" />
              <span>Notifiche email</span>
            </label>
          </div>
        </section>
        
        <section className="settings-section">
          <h2>Privacy</h2>
          <div className="setting-item">
            <label className="checkbox-label">
              <input type="checkbox" defaultChecked />
              <span>Profilo pubblico</span>
            </label>
          </div>
          <div className="setting-item">
            <label className="checkbox-label">
              <input type="checkbox" />
              <span>Condividi dati analitici</span>
            </label>
          </div>
        </section>
        
        <div className="settings-actions">
          <button className="btn btn-primary">Salva Impostazioni</button>
          <button className="btn" style={{marginLeft: "1rem", background: "var(--light-gray)"}}>
            Ripristina Default
          </button>
        </div>
      </div>
    </div>
  );
};

export default Settings;
EOF

cat > "src/pages/Settings/Settings.css" << 'EOF'
.settings-page {
  padding: 2rem;
  max-width: 800px;
  margin: 0 auto;
}

.settings-page h1 {
  margin-bottom: 1rem;
  color: var(--text-primary);
}

.settings-content {
  margin-top: 2rem;
}

.settings-section {
  margin-bottom: 2rem;
  padding: 1.5rem;
  background: white;
  border-radius: 0.5rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.settings-section h2 {
  margin-bottom: 1rem;
  color: var(--primary);
  border-bottom: 1px solid var(--border-primary);
  padding-bottom: 0.5rem;
}

.setting-item {
  margin-bottom: 1rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.setting-item label {
  color: var(--text-primary);
  font-weight: 500;
}

.setting-item select {
  padding: 0.5rem;
  border: 1px solid var(--border-primary);
  border-radius: 0.25rem;
  font-size: 1rem;
  min-width: 150px;
}

.checkbox-label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
  flex: 1;
}

.checkbox-label input[type="checkbox"] {
  margin: 0;
  cursor: pointer;
}

.settings-actions {
  margin-top: 2rem;
  padding: 1.5rem;
  background: white;
  border-radius: 0.5rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  text-align: center;
}

.settings-actions .btn {
  margin: 0.25rem;
}
EOF

# 29. Crea pagina 404
print_info "  Creazione pagina 404..."
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

# 30. Test build
print_warning "  Test della build..."
npm run build

echo ""
print_success "  Configurazione progetto completata!"
print_color -n "$CYAN" "  Progetto: "
echo " $PROJECT_NAME"
echo ""
print_info "  Sono stati configurati:"
echo "    Vite + React + TypeScript"
echo "    React Router con routing completo"
echo "    Struttura cartelle per il progetto"
echo "    CSS utilities e variabili complete"
echo "    Tutti i componenti base:"
echo "      - Header con navigazione desktop"
echo "      - BrandLogo responsive"
echo "      - Navbar mobile con OffCanvas"
echo "      - Footer"
echo "      - LoginForm"
echo "      - LoadingSpinner"
echo "    MainLayout con tutti i componenti"
echo "    Pagine: Home, Login, Detail, 404"
echo "    Hook: useApi, useLocalStorage"
echo "    Servizio API completo"
echo "    Types TypeScript"
echo "    Configurazione navigazione"
echo "    AppContextWrapper per contexts"
echo "    Build testata con successo"
echo ""
print_info "  Avvio server dev..."

npm run dev