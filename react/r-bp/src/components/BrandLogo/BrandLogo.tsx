import { Link } from "react-router";
import "./BrandLogo.css";

interface BrandLogoProps {
  size?: "sm" | "md" | "lg";
  className?: string;
  onClick?: () => void;
}

const BrandLogo = ({
  size = "md",
  className = "",
  onClick,
}: BrandLogoProps) => {
  return (
    <Link
      to="/"
      className={`brand-logo brand-logo--${size} ${className}`}
      onClick={onClick}
    >
      BP
    </Link>
  );
};

export default BrandLogo;
