import "./About.css";

const About = () => {
  return (
    <div className="about-page">
      <h1>About</h1>
      <p>Informazioni sul progetto e sul team di sviluppo.</p>
      <div className="about-content">
        <section>
          <h2>Il Progetto</h2>
          <p>Questo è un boilerplate React creato per accelerare lo sviluppo di nuovi progetti.</p>
        </section>
        <section>
          <h2>Tecnologie</h2>
          <ul>
            <li>React 19</li>
            <li>TypeScript</li>
            <li>Vite</li>
            <li>React Router</li>
            <li>React Icons</li>
          </ul>
        </section>
      </div>
    </div>
  );
};

export default About;
