import { useState, useEffect } from "react";
import { getAllProducts } from "../services/productService";
import type { Product } from "../types/Product";

export const useAllProducts = () => {
  const [data, setData] = useState<Product[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        setLoading(true);
        setError(null);
        const products = await getAllProducts();
        setData(products);
      } catch (error) {
        setError(error instanceof Error ? error.message : "Errore sconosciuto");
        setData(null);
      } finally {
        setLoading(false);
      }
    };
    fetchProducts();
  }, []);

  return { data, loading, error };
};
