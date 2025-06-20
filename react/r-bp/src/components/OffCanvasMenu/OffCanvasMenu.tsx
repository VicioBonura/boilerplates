import { Link } from "react-router";
import BrandLogo from "../BrandLogo/BrandLogo";
import { NAV_ITEMS } from "../../config/navigation";
import "./OffCanvasMenu.css";

type OffCanvasMenuProps = {
  isOpen: boolean;
  onClose: () => void;
};

const OffCanvasMenu = ({ isOpen, onClose }: OffCanvasMenuProps) => {
  const navItems = NAV_ITEMS.filter((item) => !item.inMobile);

  return (
    <div id="offcanvas-menu" data-open={isOpen}>
      <div className="offcanvas-header flex items-center">
        <BrandLogo size="md" onClick={onClose} />
      </div>
      <div className="offcanvas-body flex flex-center">
        <ul className="flex items-center">
          {navItems.map(({ path, label, icon: Icon }) => {
            return (
              <li key={path}>
                <Link
                  to={path}
                  aria-label={label}
                  className="flex flex-center"
                  onClick={onClose}
                >
                  <Icon />
                  <span>{label}</span>
                </Link>
              </li>
            );
          })}
        </ul>
      </div>
    </div>
  );
};

export default OffCanvasMenu;
