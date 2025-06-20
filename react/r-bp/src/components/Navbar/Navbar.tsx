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
