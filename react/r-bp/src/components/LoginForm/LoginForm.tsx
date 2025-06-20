import { useState } from "react";
import "./LoginForm.css";

const LoginForm = () => {
  const [isLoading, setIsLoading] = useState(false);

  const onSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    const form = e.currentTarget as HTMLFormElement;
    const credentials = {
      username: form.username.value,
      password: form.password.value,
    };

    // XXX Debug
    console.log("Login credentials:", credentials);

    // XXX placeholder
    setTimeout(() => {
      setIsLoading(false);
      alert("Login placeholder - implement authentication logic");
    }, 1000);
  };

  return (
    <div className="login-form">
      <div className="login-form__header">
        <h2>Login</h2>
      </div>
      <div className="login-form__body">
        <form onSubmit={onSubmit}>
          <div className="form-group">
            <input
              type="text"
              id="username"
              name="username"
              placeholder="Username"
              required
            />
            <label htmlFor="username">Username</label>
          </div>
          <div className="form-group">
            <input
              type="password"
              id="password"
              name="password"
              placeholder="Password"
              required
            />
            <label htmlFor="password">Password</label>
          </div>
          <div className="form-group form-group--buttons">
            <button type="reset">Reset</button>
            <button type="submit" disabled={isLoading}>
              {isLoading ? "Loading..." : "Accedi"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default LoginForm;
