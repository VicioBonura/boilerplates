import "./Hamburger.css";

type HamburgerProps = {
  onClick: () => void;
  isOpen: boolean;
};

const Hamburger = ({ onClick, isOpen }: HamburgerProps) => {
  return (
    <div
      role="button"
      id="hamburger"
      aria-label="menu-toggle"
      onClick={onClick}
      data-toggle={isOpen}
    />
  );
};

export default Hamburger;
