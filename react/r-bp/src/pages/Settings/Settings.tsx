import "./Settings.css";

const Settings = () => {
  return (
    <div className="settings-page">
      <h1>Impostazioni</h1>
      <p>Configura le preferenze dell'applicazione.</p>
      <div className="settings-content">
        <section className="settings-section">
          <h2>Aspetto</h2>
          <div className="setting-item">
            <label htmlFor="theme">Tema</label>
            <select id="theme">
              <option value="light">Chiaro</option>
              <option value="dark">Scuro</option>
              <option value="auto">Automatico</option>
            </select>
          </div>
          <div className="setting-item">
            <label htmlFor="language">Lingua</label>
            <select id="language">
              <option value="it">Italiano</option>
              <option value="en">English</option>
              <option value="es">Español</option>
            </select>
          </div>
        </section>
        
        <section className="settings-section">
          <h2>Notifiche</h2>
          <div className="setting-item">
            <label className="checkbox-label">
              <input type="checkbox" defaultChecked />
              <span>Abilita notifiche push</span>
            </label>
          </div>
          <div className="setting-item">
            <label className="checkbox-label">
              <input type="checkbox" />
              <span>Notifiche email</span>
            </label>
          </div>
        </section>
        
        <section className="settings-section">
          <h2>Privacy</h2>
          <div className="setting-item">
            <label className="checkbox-label">
              <input type="checkbox" defaultChecked />
              <span>Profilo pubblico</span>
            </label>
          </div>
          <div className="setting-item">
            <label className="checkbox-label">
              <input type="checkbox" />
              <span>Condividi dati analitici</span>
            </label>
          </div>
        </section>
        
        <div className="settings-actions">
          <button className="btn btn-primary">Salva Impostazioni</button>
          <button className="btn" style={{marginLeft: "1rem", background: "var(--light-gray)"}}>
            Ripristina Default
          </button>
        </div>
      </div>
    </div>
  );
};

export default Settings;
