import { useState } from "react";
import MainNav from "../MainNav/MainNav";
import "./MobileNavbar.css";

const MobileNavbar = () => {
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const onClick = () => setIsOpen(false);
  return (
    <>
      <div id="mobile-navbar">
        <MainNav position="mobile" onClick={onClick} />
        <button
          id="hamburger-menu"
          aria-label="Toggle Mobile menu"
          data-toggle={isOpen}
          onClick={() => setIsOpen(!isOpen)}
        >
          <span>Menu</span>
        </button>
      </div>
      <div id="offcanvas-menu" data-toggle={isOpen}>
        <MainNav position="offCanvas" onClick={onClick} />
      </div>
    </>
  );
};

export default MobileNavbar;
