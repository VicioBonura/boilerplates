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
