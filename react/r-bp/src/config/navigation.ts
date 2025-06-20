import {
  FaHome,
  FaCopy,
  FaUser,
  FaInfo,
  FaEnvelope,
  FaCog,
} from "react-icons/fa";
import { type IconType } from "react-icons";

export type NavItem = {
  path: string;
  label: string;
  icon: IconType;
  inMobile?: boolean;
  order?: number;
};

export const NAV_ITEMS: NavItem[] = [
  {
    path: "/",
    label: "Home",
    icon: FaHome,
    inMobile: true,
    order: 1,
  },
  { path: "/detail", label: "Detail", icon: FaCopy, inMobile: true, order: 2 },
  {
    path: "/about",
    label: "About",
    icon: FaInfo,
    inMobile: false,
    order: 3,
  },
  {
    path: "/contact",
    label: "Contact",
    icon: FaEnvelope,
    inMobile: false,
    order: 4,
  },
  {
    path: "/settings",
    label: "Settings",
    icon: FaCog,
    inMobile: false,
    order: 5,
  },
  {
    path: "/login",
    label: "Login",
    icon: FaUser,
    inMobile: true,
    order: 6,
  },
];
