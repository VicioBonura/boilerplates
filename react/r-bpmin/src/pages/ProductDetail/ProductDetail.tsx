import { useParams, Link } from "react-router";
import { useProductById } from "../../hooks/useProductById";
import { useImageLoader } from "../../hooks/useImageLoader";
import type { Product } from "../../types/Product";
import "./ProductDetail.css";

interface ProductDetailContentProps {
  product: Product;
}

const ProductDetailContent = ({ product }: ProductDetailContentProps) => {
  const {
    loading: imageLoading,
    loaded: imageLoaded,
    error: imageError,
    imageRef,
  } = useImageLoader(product.image);

  console.log(imageLoading, imageLoaded, imageError);

  return (
    <div className="product-detail-content">
      <div className="product-detail-nav">
        <Link to="/products" className="btn btn-primary">
          Torna ai prodotti
        </Link>
      </div>
      <div className="product-detail-image-container">
        {imageLoading && <div className="image-loading-skeleton" />}
        {imageError && (
          <div className="image-error">Immagine non disponibile</div>
        )}
        <img
          src={product.image}
          alt={product.name}
          ref={imageRef}
          className={`${imageLoaded ? "loaded" : "hidden"}`}
        />
      </div>
      <div className="product-detail-info">
        <h1>{product.name}</h1>
        <p className="product-detail-price">
          {product.price.toLocaleString("it-IT", {
            style: "currency",
            currency: "EUR",
          })}
        </p>
        <p className="product-detail-description">{product.description}</p>
      </div>
    </div>
  );
};

const ProductDetail = () => {
  const { id } = useParams<{ id: string }>();
  const { data, loading, error } = useProductById(id);

  if (loading) {
    return (
      <div className="product-detail-page">
        <div className="product-detail-loading">Loading...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="product-detail-page">
        <div className="product-detail-error">Error: {error}</div>
        <Link to="/products" className="btn btn-primary">
          Torna ai prodotti
        </Link>
      </div>
    );
  }

  if (!data) {
    return (
      <div className="product-detail-page">
        <div className="product-detail-error">Prodotto non trovato</div>
        <Link to="/products" className="btn btn-primary">
          Torna ai prodotti
        </Link>
      </div>
    );
  }

  return (
    <div className="product-detail-page">
      <ProductDetailContent product={data} />
    </div>
  );
};

export default ProductDetail;
