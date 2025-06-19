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
