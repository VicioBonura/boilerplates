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
