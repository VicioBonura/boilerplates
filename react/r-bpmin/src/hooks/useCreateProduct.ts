import { useState } from "react";
import { createProduct as createProductService } from "../services/productService";
import type { Product } from "../types/Product";

export const useCreateProduct = () => {
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<boolean>(false);
  const [createdProduct, setCreatedProduct] = useState<Product | null>(null);

  const resetState = () => {
    setLoading(false);
    setError(null);
    setSuccess(false);
    setCreatedProduct(null);
  };

  const createProduct = async (
    productData: Omit<Product, "id">
  ): Promise<void> => {
    resetState();

    try {
      setLoading(true);
      const newProduct = await createProductService(productData);
      setSuccess(true);
      setCreatedProduct(newProduct);
    } catch (error) {
      let errorMessage = "Errore durante la creazione del prodotto";

      if (error instanceof Error) {
        if (error.message.includes("400")) {
          errorMessage = "Dati prodotto non validi";
        } else if (error.message.includes("401")) {
          errorMessage = "Non autorizzato a creare prodotti";
        } else if (error.message.includes("409")) {
          errorMessage = "Prodotto già esistente";
        } else if (error.message.includes("500")) {
          errorMessage = "Errore interno del server";
        } else {
          errorMessage = error.message;
        }
      }

      setError(errorMessage);
    } finally {
      setLoading(false);
    }
  };

  return {
    createProduct,
    resetState,
    loading,
    error,
    success,
    createdProduct,
  };
};
