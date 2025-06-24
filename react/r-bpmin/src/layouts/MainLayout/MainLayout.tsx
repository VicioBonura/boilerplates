import { useState, useEffect } from "react";
import { Outlet } from "react-router";
import Header from "../../components/Header/Header";
import MobileNavbar from "../../components/MobileNavbar/MobileNavbar";
import "./MainLayout.css";

const MainLayout = () => {
  const [isMobile, setIsMobile] = useState<boolean>(false);
  useEffect(() => {
    const handleResize = () => {
      setIsMobile(window.innerWidth < 768);
    };
    window.addEventListener("resize", handleResize);
    handleResize();
    return () => window.removeEventListener("resize", handleResize);
  }, []);

  return (
    <div id="app-container">
      <Header isMobile={isMobile} />
      <main>
        <Outlet />
      </main>
      {isMobile && <MobileNavbar />}
    </div>
  );
};

export default MainLayout;
