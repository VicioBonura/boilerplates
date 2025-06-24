import { Link } from "react-router";
import type { Product } from "../../types/Product";
import { useImageLoader } from "../../hooks/useImageLoader";
import "./ProductCard.css";

interface ProductCardProps {
  product: Product;
}

const ProductCard = ({ product }: ProductCardProps) => {
  const { loading, loaded, error, imageRef } = useImageLoader(product.image);
  return (
    <div className="product-card">
      <div className="product-image-container">
        {loading && <div className="image-loading-skeleton" />}
        {error && (
          <div className="image-error-message">
            <span>X</span>
          </div>
        )}
        <img
          ref={imageRef}
          src={product.image}
          alt={product.name}
          className={`${loaded ? "loaded" : "hidden"}`}
        />
      </div>
      <div className="product-details">
        <h3>{product.name}</h3>
        <p className="price">
          {product.price.toLocaleString("it-IT", {
            style: "currency",
            currency: "EUR",
          })}
        </p>
        <Link
          to={`/products/${product.id}`}
          className="btn btn-primary details"
        >
          View Details
        </Link>
      </div>
    </div>
  );
};

export default ProductCard;
