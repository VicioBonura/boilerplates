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
