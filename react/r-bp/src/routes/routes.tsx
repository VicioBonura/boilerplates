import { createBrowserRouter } from "react-router";
import MainLayout from "../layouts/MainLayout/MainLayout";
import Home from "../pages/Home/Home";
import Login from "../pages/Login/Login";
import Detail from "../pages/Detail/Detail";
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
        path: "/login",
        element: <Login />,
      },
    ],
  },
  {
    path: "*",
    element: <NotFound />,
  },
]);

export default router;
