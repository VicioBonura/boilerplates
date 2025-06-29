import { useEffect } from "react";
import { Link, useNavigate } from "react-router";
import { useCreateProduct } from "../../hooks/useCreateProduct";
import type { Product } from "../../types/Product";
import ProductForm from "../../components/ProductForm/ProductForm";
import "./NewProduct.css";

const NewProduct = () => {
  const navigate = useNavigate();
  const { createProduct, loading, error, success, createdProduct } =
    useCreateProduct();

  useEffect(() => {
    if (success && createdProduct) {
      navigate(`/products/${createdProduct.id}`);
    }
  }, [success, createdProduct, navigate]);

  const handleFormSubmit = async (formData: Omit<Product, "id">) =>
    await createProduct(formData);

  return (
    <div className="new-product-container">
      <div className="product-header">
        <h2>Nuovo Prodotto</h2>
        <Link to="/products" className="btn btn-primary">
          Indietro
        </Link>
      </div>
      {error && <div className="error-message">{error}</div>}
      <ProductForm
        onSubmit={handleFormSubmit}
        loading={loading}
        error={error}
      />
    </div>
  );
};

export default NewProduct;
