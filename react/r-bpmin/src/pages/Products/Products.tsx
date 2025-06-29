import { Link } from "react-router";
import { useAllProducts } from "../../hooks/useAllProducts";
import ProductCard from "../../components/ProductCard/ProductCard";
import "./Products.css";

const Products = () => {
  const { data, loading, error } = useAllProducts();
  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  if (!data) return <div>No products found</div>;

  return (
    <div className="products-page">
      <div className="products-header">
        <h1>Products</h1>
        <Link to="/products/new" className="btn btn-primary">
          Nuovo
        </Link>
      </div>
      <ul>
        {data.map((product) => (
          <li key={product.id}>
            <ProductCard product={product} />
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Products;
