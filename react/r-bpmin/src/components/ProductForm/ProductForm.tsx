import { useState, type FormEvent } from "react";
import type { Product } from "../../types/Product";
import "./ProductForm.css";

interface ProductFormProps {
  onSubmit: (data: Omit<Product, "id">) => void;
  loading?: boolean;
  error?: string | null;
}

const ProductForm = ({ onSubmit, loading, error }: ProductFormProps) => {
  const [formData, setFormData] = useState<Omit<Product, "id">>({
    name: "",
    description: "",
    price: 0,
    image: "",
  });

  const handleInputChange = (
    field: keyof Omit<Product, "id">,
    value: string | number
  ) => {
    setFormData((prev) => ({
      ...prev,
      [field]: value,
    }));
  };

  const handleSubmit = (e: FormEvent): void => {
    e.preventDefault();
    onSubmit(formData);
  };

  return (
    <div>
      <form onSubmit={handleSubmit} className="product-form">
        {error && <div className="error">{error}</div>}
        <div className="form-group">
          <label htmlFor="name">Nome prodotto</label>
          <input
            type="text"
            id="name"
            value={formData.name}
            onChange={(e) => handleInputChange("name", e.target.value)}
          />
        </div>
        <div className="form-group">
          <label htmlFor="description">Descrizione</label>
          <textarea
            id="description"
            value={formData.description}
            onChange={(e) => handleInputChange("description", e.target.value)}
          />
        </div>
        <div className="form-group">
          <label htmlFor="prica">Prezzo</label>
          <input
            type="number"
            step="0.01"
            id="price"
            value={formData.price}
            onChange={(e) =>
              handleInputChange("price", parseFloat(e.target.value) || 0)
            }
          />
        </div>
        <div className="form-group">
          <label htmlFor="image">URL immagine</label>
          <input
            type="url"
            id="image"
            value={formData.image}
            onChange={(e) => handleInputChange("image", e.target.value)}
          />
        </div>
        <button type="submit" disabled={loading} className="btn btn-primary">
          {loading ? "attendi..." : "Crea prodotto"}
        </button>
      </form>
    </div>
  );
};

export default ProductForm;
