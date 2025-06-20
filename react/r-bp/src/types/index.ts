// API Types
export interface ApiResponse<T> {
  data: T;
  message?: string;
  status: number;
}

export interface ApiError {
  message: string;
  status: number;
}

// Auth Types
export interface User {
  id: string;
  email: string;
  name: string;
  role?: string;
}

export interface LoginCredentials {
  email: string;
  password: string;
}

export interface AuthState {
  user: User | null;
  token: string | null;
  isAuthenticated: boolean;
}

// Form Types
export interface FormField {
  value: string;
  error?: string;
  touched?: boolean;
}

export interface FormState {
  [key: string]: FormField;
}
