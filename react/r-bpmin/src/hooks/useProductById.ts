import { useState, useEffect } from "react";
import { getProductById } from "../services/productService";
import type { Product } from "../types/Product";

export const useProductById = (id: string | undefined) => {
  const [data, setData] = useState<Product | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchProduct = async () => {
      try {
        //RESET
        setLoading(true);
        setError(null);
        setData(null);

        //VALIDAZIONE ID
        if (!id) {
          setError("ID mancante");
          setLoading(false);
          return;
        }

        //CHIAMATA API
        const product = await getProductById(id);
        setData(product);
      } catch (error) {
        setError(error instanceof Error ? error.message : "Errore sconosciuto");
        setData(null);
      } finally {
        setLoading(false);
      }
    };

    fetchProduct();
  }, [id]);

  return { data, loading, error };
};
