import { apiGet, apiPost } from "./api";
import type { Product } from "../types/Product";

export const getAllProducts = (): Promise<Product[]> => {
  return apiGet<Product[]>("/products");
};

export const getProductById = (id: string): Promise<Product> => {
  return apiGet<Product>(`/products/${id}`);
};

export const createProduct = (
  productData: Omit<Product, "id">
): Promise<Product> => {
  return apiPost<Omit<Product, "id">, Product>("/products", productData);
};
