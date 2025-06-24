const BASE_URL = "/api";

export const apiGet = async <T>(endpoint: string): Promise<T> => {
  const url = `${BASE_URL}${endpoint}`;
  const response = await fetch(url);

  if (!response.ok) {
    throw new Error(`HTTP Error: ${response.status}`);
  }

  return await response.json();
};
