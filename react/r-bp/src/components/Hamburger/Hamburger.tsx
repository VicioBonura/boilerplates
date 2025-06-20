import "./Hamburger.css";

interface HamburgerProps {
  isOpen: boolean;
  onClick: () => void;
}

const Hamburger = ({ isOpen, onClick }: HamburgerProps) => {
  return (
    <button
      className={`hamburger ${isOpen ? "hamburger--active" : ""}`}
      onClick={onClick}
      aria-label="Toggle menu"
    >
      <span></span>
      <span></span>
      <span></span>
    </button>
  );
};

export default Hamburger;
