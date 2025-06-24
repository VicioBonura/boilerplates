import { apiGet } from "./api";
import type { Product } from "../types/Product";

export const getAllProducts = (): Promise<Product[]> => {
  return apiGet<Product[]>("/products");
};

export const getProductById = (id: number): Promise<Product> => {
  return apiGet<Product>(`/products/${id}`);
};
