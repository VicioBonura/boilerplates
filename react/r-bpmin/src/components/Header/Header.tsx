import { useState, useEffect } from "react";
import MainNav from "../MainNav/MainNav";
import "./Header.css";

const Header = ({ isMobile }: { isMobile: boolean }) => {
  const [isScrolled, setIsScrolled] = useState<boolean>(false);
  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 50);
    };
    window.addEventListener("scroll", handleScroll);
    handleScroll();
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <header className={isScrolled ? "scrolled" : ""}>
      <div className="BrandLogo">
        <img src="/react.svg" alt="Brand Logo" />
      </div>
      {!isMobile && <MainNav position="header" />}
    </header>
  );
};

export default Header;
