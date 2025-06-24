import { NavLink } from "react-router";
import { NAV_ITEMS } from "../../config/navigation";
import "./MainNav.css";

type Position = "header" | "mobile" | "offCanvas";
type Props = {
  position: Position;
  onClick?: () => void;
};

const MainNav = ({ position, onClick }: Props) => {
  return (
    <nav>
      <ul>
        {NAV_ITEMS.map((item) => {
          if (position === "mobile" && !item.inMobile) return null;
          if (position === "offCanvas" && item.inMobile) return null;

          return (
            <li key={item.path}>
              <NavLink to={item.path} onClick={onClick}>
                <item.icon />
                <span>{item.label}</span>
              </NavLink>
            </li>
          );
        })}
      </ul>
    </nav>
  );
};

export default MainNav;
