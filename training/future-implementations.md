# Future Implementazioni e Piani di Apprendimento - r-bpmin App

## ROADMAP GENERALE

### Stato Attuale: GET Operations Complete ✅

- ✅ Architettura base API (Service + Hooks + Components)
- ✅ Lista prodotti con gestione stati
- ✅ Dettaglio prodotto con routing dinamico
- ✅ Gestione immagini avanzata
- ✅ Error handling robusto

### Prossimo Obiettivo: POST/PUT/DELETE Operations

**Target**: Completare CRUD operations per apprendimento API REST completo

## IMPLEMENTAZIONE 1: GESTIONE PRODOTTI ADMIN (PRIORITÀ ALTA)

### Obiettivo Didattico

Apprendere operazioni **mutative** (POST/PUT/DELETE) attraverso sistema CRUD completo per prodotti, simulando pannello amministrativo senza autenticazione.

### Roadmap Implementazione

#### Step 1: CREATE - Aggiunta Nuovo Prodotto

**Rotta**: `/products/new`
**Obiettivo**: Apprendere form handling e POST operations

**Implementazioni Necessarie**:

##### 1.1 Service Layer Extension

```typescript
// src/services/productService.ts
export const createProduct = (
  productData: Omit<Product, "id">
): Promise<Product> => {
  return apiPost<Product>("/products", productData);
};
```

##### 1.2 API Utility Extension

```typescript
// src/services/api.ts
export const apiPost = async <T>(endpoint: string, data: any): Promise<T> => {
  const response = await fetch(`${BASE_URL}${endpoint}`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  });
  // Error handling...
};
```

##### 1.3 Custom Hook per Creation

```typescript
// src/hooks/useCreateProduct.ts
export const useCreateProduct = () => {
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<boolean>(false);

  const createProduct = async (productData: CreateProductData) => {
    // Implementation with state management
  };

  return { createProduct, loading, error, success };
};
```

##### 1.4 Form Component

```typescript
// src/components/ProductForm/ProductForm.tsx
interface ProductFormProps {
  onSubmit: (data: CreateProductData) => Promise<void>;
  loading?: boolean;
  error?: string | null;
}
```

##### 1.5 Page Component

```typescript
// src/pages/CreateProduct/CreateProduct.tsx
const CreateProduct = () => {
  const { createProduct, loading, error, success } = useCreateProduct();
  const navigate = useNavigate();

  // Form submission logic
  // Success navigation
  // Error display
};
```

**Concetti di Apprendimento**:

- **Form handling**: controlled components, validation
- **POST operations**: request body, headers, method
- **Success handling**: navigation post-creation
- **Optimistic updates**: immediate UI feedback
- **Loading states**: disabling form during submission
- **Error boundaries**: form-specific error handling

#### Step 2: UPDATE - Modifica Prodotto Esistente

**Rotta**: `/products/:id/edit`
**Obiettivo**: Apprendere PUT operations e pre-popolazione form

**Implementazioni Necessarie**:

##### 2.1 Service Extension

```typescript
export const updateProduct = (
  id: number,
  productData: Partial<Product>
): Promise<Product> => {
  return apiPut<Product>(`/products/${id}`, productData);
};
```

##### 2.2 Hook per Update

```typescript
export const useUpdateProduct = (id: string) => {
  // Stato per update operation
  // Pre-fetch del prodotto esistente
  // Update function con ottimistic updates
};
```

##### 2.3 Form Riusabile

- **Estendere ProductForm**: supportare edit mode
- **Pre-popolazione**: caricare dati esistenti
- **Validazione**: differenziata create vs update

**Concetti di Apprendimento**:

- **PUT vs PATCH**: quando usare quale metodo
- **Partial types**: TypeScript per update parziali
- **Pre-popolazione form**: useEffect per loading dati
- **Form reusability**: stesso componente create/edit
- **Optimistic updates**: aggiornare UI prima di conferma server

#### Step 3: DELETE - Eliminazione Prodotto

**Implementazione**: Pulsante elimina in ProductCard e ProductDetail
**Obiettivo**: Apprendere DELETE operations e conferme

**Implementazioni Necessarie**:

##### 3.1 Service Extension

```typescript
export const deleteProduct = (id: number): Promise<void> => {
  return apiDelete(`/products/${id}`);
};
```

##### 3.2 Hook per Deletion

```typescript
export const useDeleteProduct = () => {
  // Stato per delete operation
  // Confirmation handling
  // Success callback per navigation
};
```

##### 3.3 Confirmation Modal

```typescript
// src/components/ConfirmationModal/ConfirmationModal.tsx
interface ConfirmationModalProps {
  isOpen: boolean;
  onConfirm: () => void;
  onCancel: () => void;
  title: string;
  message: string;
  confirmText?: string;
  cancelText?: string;
}
```

**Concetti di Apprendimento**:

- **DELETE operations**: metodo HTTP appropriato
- **Confirmation UX**: prevenire eliminazioni accidentali
- **Modal management**: stato apertura/chiusura
- **Cascade operations**: aggiornare lista dopo eliminazione
- **Error recovery**: gestire fallimenti eliminazione

### Integrazione Completa CRUD

#### Navigation Updates

```typescript
// src/components/AdminActions/AdminActions.tsx
const AdminActions = ({ product }: { product?: Product }) => {
  return (
    <div className="admin-actions">
      <Link to="/products/new" className="btn btn-primary">
        Add New Product
      </Link>
      {product && (
        <>
          <Link
            to={`/products/${product.id}/edit`}
            className="btn btn-secondary"
          >
            Edit Product
          </Link>
          <DeleteProductButton productId={product.id} />
        </>
      )}
    </div>
  );
};
```

#### Route Updates

```typescript
// src/routes/routes.tsx
{
  path: "/products/new",
  element: <CreateProduct />,
},
{
  path: "/products/:id/edit",
  element: <EditProduct />,
}
```

**Apprendimenti Integrati**:

- **RESTful routing**: convenzioni URL per CRUD
- **State synchronization**: mantenere lista aggiornata
- **Navigation patterns**: flussi utente ottimali
- **Error boundaries**: gestione errori globale vs locale

## IMPLEMENTAZIONE 2: SISTEMA RECENSIONI (PRIORITÀ MEDIA)

### Obiettivo Didattico

Apprendere **relazioni tra entità** e **operazioni nested** attraverso sistema recensioni prodotti.

### Architettura Data

```typescript
// src/types/Review.ts
interface Review {
  id: number;
  productId: number;
  userId: number;
  rating: number; // 1-5
  title: string;
  comment: string;
  createdAt: string;
  updatedAt: string;
}

// src/types/ReviewWithUser.ts
interface ReviewWithUser extends Review {
  user: {
    id: number;
    name: string;
  };
}
```

### Implementazioni Principali

#### 2.1 Service Layer per Reviews

```typescript
// src/services/reviewService.ts
export const getProductReviews = (
  productId: number
): Promise<ReviewWithUser[]> => {
  return apiGet<ReviewWithUser[]>(`/products/${productId}/reviews`);
};

export const createReview = (
  productId: number,
  reviewData: CreateReviewData
): Promise<Review> => {
  return apiPost<Review>(`/products/${productId}/reviews`, reviewData);
};

export const updateReview = (
  reviewId: number,
  reviewData: Partial<Review>
): Promise<Review> => {
  return apiPut<Review>(`/reviews/${reviewId}`, reviewData);
};

export const deleteReview = (reviewId: number): Promise<void> => {
  return apiDelete(`/reviews/${reviewId}`);
};
```

#### 2.2 Custom Hooks per Reviews

```typescript
// src/hooks/useProductReviews.ts
export const useProductReviews = (productId: number) => {
  // Lista recensioni per prodotto
  // Paginazione
  // Ordinamento (più recenti, rating)
};

// src/hooks/useCreateReview.ts
export const useCreateReview = (productId: number) => {
  // Creazione recensione
  // Validazione rating/commento
  // Update ottimistico lista
};
```

#### 2.3 Components per Reviews

```typescript
// src/components/ReviewsList/ReviewsList.tsx
interface ReviewsListProps {
  productId: number;
  showAddForm?: boolean;
}

// src/components/ReviewForm/ReviewForm.tsx
interface ReviewFormProps {
  productId: number;
  onSuccess: () => void;
  existingReview?: Review; // Per edit mode
}

// src/components/ReviewCard/ReviewCard.tsx
interface ReviewCardProps {
  review: ReviewWithUser;
  canEdit?: boolean;
  onEdit?: () => void;
  onDelete?: () => void;
}
```

**Concetti di Apprendimento**:

- **Nested routes**: `/products/:id/reviews`
- **Relazioni API**: JOIN operations con users
- **Rating components**: UI per stelle selezionabili
- **Form validation**: rating obbligatorio, commento lunghezza
- **Pagination**: gestione grandi quantità recensioni
- **Permissions**: chi può modificare/cancellare
- **Aggregation**: calcolo rating medio prodotto

## IMPLEMENTAZIONE 3: WISHLIST UTENTI (PRIORITÀ MEDIA)

### Obiettivo Didattico

Apprendere **toggle operations** e **stato persistente utente** attraverso sistema wishlist.

### Architettura Data

```typescript
// src/types/Wishlist.ts
interface WishlistItem {
  id: number;
  userId: number;
  productId: number;
  addedAt: string;
}

interface WishlistWithProduct extends WishlistItem {
  product: Product;
}
```

### Implementazioni Principali

#### 3.1 Service Layer

```typescript
// src/services/wishlistService.ts
export const getUserWishlist = (
  userId: number
): Promise<WishlistWithProduct[]> => {
  return apiGet<WishlistWithProduct[]>(`/users/${userId}/wishlist`);
};

export const addToWishlist = (
  userId: number,
  productId: number
): Promise<WishlistItem> => {
  return apiPost<WishlistItem>(`/users/${userId}/wishlist`, { productId });
};

export const removeFromWishlist = (
  userId: number,
  productId: number
): Promise<void> => {
  return apiDelete(`/users/${userId}/wishlist/${productId}`);
};

export const isInWishlist = (
  userId: number,
  productId: number
): Promise<boolean> => {
  return apiGet<boolean>(`/users/${userId}/wishlist/check/${productId}`);
};
```

#### 3.2 Custom Hooks

```typescript
// src/hooks/useWishlist.ts
export const useWishlist = (userId: number) => {
  // Lista completa wishlist utente
  // Add/remove operations
  // Check if product in wishlist
};

// src/hooks/useWishlistToggle.ts
export const useWishlistToggle = (userId: number, productId: number) => {
  const [isInWishlist, setIsInWishlist] = useState<boolean>(false);
  const [loading, setLoading] = useState<boolean>(false);

  const toggle = async () => {
    // Optimistic update
    // API call
    // Revert on error
  };

  return { isInWishlist, loading, toggle };
};
```

#### 3.3 Components

```typescript
// src/components/WishlistButton/WishlistButton.tsx
interface WishlistButtonProps {
  productId: number;
  userId: number;
  size?: "small" | "medium" | "large";
  showText?: boolean;
}

// src/pages/Wishlist/Wishlist.tsx
const Wishlist = () => {
  // Lista prodotti in wishlist
  // Remove operations
  // Empty state
};
```

**Concetti di Apprendimento**:

- **Toggle operations**: add/remove con stesso pulsante
- **Optimistic updates**: immediate UI feedback
- **State synchronization**: aggiornare tra pagine
- **Local storage**: cache stato wishlist
- **Debouncing**: evitare chiamate multiple rapide
- **Heart icon animation**: feedback visivo toggle

## IMPLEMENTAZIONE 4: AUTENTICAZIONE SEMPLIFICATA (PRIORITÀ BASSA)

### Obiettivo Didattico

Apprendere **Context API**, **protected routes** e **persistenza stato globale**.

### Architettura Autenticazione

#### 4.1 Context Setup

```typescript
// src/contexts/AuthContext.ts
interface AuthContextType {
  user: User | null;
  login: (email: string, password: string) => Promise<void>;
  register: (userData: RegisterData) => Promise<void>;
  logout: () => void;
  loading: boolean;
  error: string | null;
}

// src/providers/AuthProvider.tsx
export const AuthProvider = ({ children }: { children: ReactNode }) => {
  // useState per user, loading, error
  // useEffect per check localStorage al mount
  // Login/logout/register functions
};
```

#### 4.2 Services

```typescript
// src/services/authService.ts
export const login = (
  email: string,
  password: string
): Promise<LoginResponse> => {
  return apiPost<LoginResponse>("/auth/login", { email, password });
};

export const register = (userData: RegisterData): Promise<User> => {
  return apiPost<User>("/auth/register", userData);
};
```

#### 4.3 Protected Routes

```typescript
// src/components/ProtectedRoute/ProtectedRoute.tsx
interface ProtectedRouteProps {
  children: ReactNode;
  fallback?: ReactNode;
}

const ProtectedRoute = ({ children, fallback }: ProtectedRouteProps) => {
  const { user, loading } = useAuth();

  if (loading) return <LoadingSpinner />;
  if (!user) return fallback || <Navigate to="/login" />;

  return <>{children}</>;
};
```

**Concetti di Apprendimento**:

- **Context API**: stato globale React nativo
- **useContext hook**: consumo context nei componenti
- **localStorage**: persistenza sessioni
- **Protected routes**: controllo accesso
- **JWT tokens**: gestione autenticazione stateless
- **Route guards**: redirection automatico

## IMPLEMENTAZIONE 5: CACHING E OTTIMIZZAZIONI (PRIORITÀ AVANZATA)

### Obiettivo Didattico

Apprendere **performance optimization** e **caching strategies** per API.

### Tecnologie da Integrare

#### 5.1 React Query Integration

```typescript
// src/hooks/queries/useProductsQuery.ts
export const useProductsQuery = () => {
  return useQuery({
    queryKey: ["products"],
    queryFn: getAllProducts,
    staleTime: 5 * 60 * 1000, // 5 minuti
    cacheTime: 10 * 60 * 1000, // 10 minuti
  });
};

export const useProductQuery = (id: string) => {
  return useQuery({
    queryKey: ["product", id],
    queryFn: () => getProductById(parseInt(id)),
    enabled: !!id && !isNaN(parseInt(id)),
  });
};
```

#### 5.2 Mutations con React Query

```typescript
// src/hooks/mutations/useCreateProductMutation.ts
export const useCreateProductMutation = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: createProduct,
    onSuccess: () => {
      // Invalidate products list
      queryClient.invalidateQueries(["products"]);
    },
    onError: (error) => {
      // Error handling
    },
  });
};
```

**Concetti di Apprendimento**:

- **Query invalidation**: aggiornamento cache automatico
- **Optimistic updates**: UI immediate con rollback
- **Background refetching**: dati sempre aggiornati
- **Cache strategies**: stale-while-revalidate
- **Error boundaries**: gestione errori globale
- **Loading states**: skeleton da cache

### 5.3 Memoization Strategies

```typescript
// src/components/ProductList/ProductList.tsx
const ProductList = memo(({ products, loading }: ProductListProps) => {
  const memoizedProducts = useMemo(() => {
    return products?.map((product) => (
      <ProductCard key={product.id} product={product} />
    ));
  }, [products]);

  return <div className="product-list">{memoizedProducts}</div>;
});
```

**Concetti di Apprendimento**:

- **React.memo**: prevenire re-render inutili
- **useMemo**: cache computazioni costose
- **useCallback**: stabilizzare references funzioni
- **Virtual scrolling**: performance con liste grandi

## ROADMAP TEMPORALE SUGGERITA

### Sprint 1 (1-2 settimane): CRUD Prodotti

- ✅ **Week 1**: POST operations (Create Product)
- ✅ **Week 2**: PUT operations (Update Product) + DELETE

### Sprint 2 (1 settimana): Sistema Recensioni

- ✅ **Week 3**: Reviews base + form handling

### Sprint 3 (1 settimana): Wishlist

- ✅ **Week 4**: Toggle operations + persistence

### Sprint 4 (1 settimana): Autenticazione

- ✅ **Week 5**: Context API + protected routes

### Sprint 5 (Avanzato): Performance

- ✅ **Week 6+**: React Query + optimization

## CRITERI DI SUCCESSO PER OGNI IMPLEMENTAZIONE

### CRUD Prodotti

- [ ] Form creation funzionante con validazione
- [ ] Update operations con pre-popolazione
- [ ] Delete con confirmation modal
- [ ] Error handling completo
- [ ] Navigation appropriata post-operations

### Sistema Recensioni

- [ ] Lista recensioni con paginazione
- [ ] Form recensione con rating
- [ ] Edit/delete proprie recensioni
- [ ] Calcolo rating medio prodotto

### Wishlist

- [ ] Toggle add/remove funzionante
- [ ] Lista wishlist persistente
- [ ] Stato sincronizzato tra pagine
- [ ] Performance ottimizzate (debouncing)

### Autenticazione

- [ ] Login/register forms
- [ ] Context API per stato globale
- [ ] Protected routes funzionanti
- [ ] Persistenza localStorage

Ogni implementazione costruisce sulla precedente, creando un sistema progressivamente più complesso e realistico per massimizzare l'apprendimento dei concetti API REST in React.
