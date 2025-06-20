import "./Contact.css";

const Contact = () => {
  return (
    <div className="contact-page">
      <h1>Contatti</h1>
      <p>Entra in contatto con noi per domande o collaborazioni.</p>
      <div className="contact-content">
        <div className="contact-info">
          <h2>Informazioni di Contatto</h2>
          <div className="contact-item">
            <strong>Email:</strong> info@example.com
          </div>
          <div className="contact-item">
            <strong>Telefono:</strong> +39 123 456 7890
          </div>
          <div className="contact-item">
            <strong>Indirizzo:</strong> Via Roma 123, Milano, IT
          </div>
        </div>
        <div className="contact-form">
          <h2>Invia un Messaggio</h2>
          <form>
            <div className="form-group">
              <label htmlFor="name">Nome</label>
              <input type="text" id="name" required />
            </div>
            <div className="form-group">
              <label htmlFor="contact-email">Email</label>
              <input type="email" id="contact-email" required />
            </div>
            <div className="form-group">
              <label htmlFor="message">Messaggio</label>
              <textarea id="message" rows={5} required></textarea>
            </div>
            <button type="submit" className="btn btn-primary">
              Invia Messaggio
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default Contact;
