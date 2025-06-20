import { Link } from "react-router";
import { NAV_ITEMS } from "../../config/navigation";
import "./OffCanvasMenu.css";

interface OffCanvasMenuProps {
  isOpen: boolean;
  onClose: () => void;
}

const OffCanvasMenu = ({ isOpen, onClose }: OffCanvasMenuProps) => {
  const allNavItems = NAV_ITEMS.filter((item) => !item.inMobile);

  return (
    <>
      {isOpen && <div className="overlay" onClick={onClose} />}
      <div className={`offcanvas ${isOpen ? "offcanvas--open" : ""}`}>
        <nav>
          <ul>
            {allNavItems.map(({ path, label, icon: Icon }) => (
              <li key={path}>
                <Link to={path} onClick={onClose}>
                  <Icon />
                  <span>{label}</span>
                </Link>
              </li>
            ))}
          </ul>
        </nav>
      </div>
    </>
  );
};

export default OffCanvasMenu;
