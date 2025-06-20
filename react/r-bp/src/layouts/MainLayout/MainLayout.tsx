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
