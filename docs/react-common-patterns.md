# React Pattern Comuni - Soluzioni Rapide

## Pattern di Rendering Condizionale

### Early Return Pattern
```typescript
const UserProfile = ({ user }: { user: User | null }) => {
  // Early return per casi edge
  if (!user) return <div>User not found</div>;
  if (!user.isActive) return <div>User is inactive</div>;
  
  // Logica principale solo se tutto ok
  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.email}</p>
    </div>
  );
};
```

### Loading/Error/Success Pattern
```typescript
const DataComponent = () => {
  const { data, loading, error } = useApi(fetchData);
  
  if (loading) return <LoadingSpinner />;
  if (error) return <ErrorMessage error={error} />;
  if (!data?.length) return <EmptyState />;
  
  return (
    <div>
      {data.map(item => (
        <ItemCard key={item.id} item={item} />
      ))}
    </div>
  );
};
```

### Conditional Rendering Variants
```typescript
// Ternary operator
{isLoggedIn ? <Dashboard /> : <LoginForm />}

// Logical AND
{hasItems && <ItemsList items={items} />}
{error && <ErrorAlert message={error.message} />}

// Nullish coalescing per fallback
{user?.name ?? 'Anonymous User'}
{items?.length ?? 0} items found
```

## Pattern per Form

### Controlled Components
```typescript
interface FormData {
  email: string;
  password: string;
}

const LoginForm = () => {
  const [formData, setFormData] = useState<FormData>({
    email: '',
    password: ''
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log('Form data:', formData);
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        name="email"
        type="email"
        value={formData.email}
        onChange={handleChange}
        placeholder="Email"
        required
      />
      <input
        name="password"
        type="password"
        value={formData.password}
        onChange={handleChange}
        placeholder="Password"
        required
      />
      <button type="submit">Login</button>
    </form>
  );
};
```

### Form Validation Pattern
```typescript
const useFormValidation = <T>(initialValues: T, validationRules: any) => {
  const [values, setValues] = useState<T>(initialValues);
  const [errors, setErrors] = useState<Partial<T>>({});

  const validate = (name: keyof T, value: any) => {
    const rule = validationRules[name];
    if (!rule) return '';

    if (rule.required && !value) {
      return `${String(name)} is required`;
    }
    
    if (rule.minLength && value.length < rule.minLength) {
      return `${String(name)} must be at least ${rule.minLength} characters`;
    }

    return '';
  };

  const handleChange = (name: keyof T, value: any) => {
    setValues(prev => ({ ...prev, [name]: value }));
    
    const error = validate(name, value);
    setErrors(prev => ({ ...prev, [name]: error }));
  };

  return { values, errors, handleChange };
};
```

## Pattern per Liste

### Lista con Ricerca/Filtro
```typescript
const ItemsList = ({ items }: { items: Item[] }) => {
  const [searchTerm, setSearchTerm] = useState('');
  const [sortBy, setSortBy] = useState<'name' | 'date'>('name');

  const filteredItems = useMemo(() => {
    return items
      .filter(item => 
        item.name.toLowerCase().includes(searchTerm.toLowerCase())
      )
      .sort((a, b) => {
        if (sortBy === 'name') return a.name.localeCompare(b.name);
        return new Date(b.date).getTime() - new Date(a.date).getTime();
      });
  }, [items, searchTerm, sortBy]);

  return (
    <div>
      <div className="controls">
        <input
          type="text"
          placeholder="Search..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
        />
        <select 
          value={sortBy} 
          onChange={(e) => setSortBy(e.target.value as 'name' | 'date')}
        >
          <option value="name">Sort by Name</option>
          <option value="date">Sort by Date</option>
        </select>
      </div>
      
      <div className="items">
        {filteredItems.map(item => (
          <ItemCard key={item.id} item={item} />
        ))}
      </div>
    </div>
  );
};
```

### Infinite Scroll Pattern
```typescript
const useInfiniteScroll = (fetchMore: () => void) => {
  useEffect(() => {
    const handleScroll = () => {
      if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 1000) {
        fetchMore();
      }
    };

    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, [fetchMore]);
};

const InfiniteList = () => {
  const [items, setItems] = useState<Item[]>([]);
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(false);

  const fetchMore = useCallback(() => {
    if (loading) return;
    
    setLoading(true);
    fetchItems(page)
      .then(newItems => {
        setItems(prev => [...prev, ...newItems]);
        setPage(prev => prev + 1);
      })
      .finally(() => setLoading(false));
  }, [page, loading]);

  useInfiniteScroll(fetchMore);

  return (
    <div>
      {items.map(item => <ItemCard key={item.id} item={item} />)}
      {loading && <div>Loading more...</div>}
    </div>
  );
};
```

## Pattern per Modal/Popup

### Modal Pattern Semplice
```typescript
const Modal = ({ 
  isOpen, 
  onClose, 
  title, 
  children 
}: {
  isOpen: boolean;
  onClose: () => void;
  title: string;
  children: React.ReactNode;
}) => {
  useEffect(() => {
    if (isOpen) {
      document.body.style.overflow = 'hidden';
    } else {
      document.body.style.overflow = 'unset';
    }
    
    return () => {
      document.body.style.overflow = 'unset';
    };
  }, [isOpen]);

  if (!isOpen) return null;

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-content" onClick={(e) => e.stopPropagation()}>
        <div className="modal-header">
          <h2>{title}</h2>
          <button onClick={onClose}>&times;</button>
        </div>
        <div className="modal-body">
          {children}
        </div>
      </div>
    </div>
  );
};

// CSS per Modal
/*
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  border-radius: 8px;
  max-width: 500px;
  width: 90%;
  max-height: 90vh;
  overflow: auto;
}
*/
```

### Confirmation Dialog Pattern
```typescript
const useConfirmation = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [config, setConfig] = useState<{
    title: string;
    message: string;
    onConfirm: () => void;
  } | null>(null);

  const confirm = (title: string, message: string, onConfirm: () => void) => {
    setConfig({ title, message, onConfirm });
    setIsOpen(true);
  };

  const handleConfirm = () => {
    config?.onConfirm();
    setIsOpen(false);
    setConfig(null);
  };

  const handleCancel = () => {
    setIsOpen(false);
    setConfig(null);
  };

  const ConfirmationDialog = () => (
    <Modal isOpen={isOpen} onClose={handleCancel} title={config?.title || ''}>
      <p>{config?.message}</p>
      <div className="confirmation-actions">
        <button onClick={handleCancel}>Cancel</button>
        <button onClick={handleConfirm} className="btn-danger">
          Confirm
        </button>
      </div>
    </Modal>
  );

  return { confirm, ConfirmationDialog };
};

// Utilizzo
const DeleteButton = ({ onDelete }: { onDelete: () => void }) => {
  const { confirm, ConfirmationDialog } = useConfirmation();

  const handleClick = () => {
    confirm(
      'Delete Item',
      'Are you sure you want to delete this item?',
      onDelete
    );
  };

  return (
    <>
      <button onClick={handleClick}>Delete</button>
      <ConfirmationDialog />
    </>
  );
};
```

## Pattern per Aggiornamenti Ottimistici

### Optimistic Updates
```typescript
const useOptimisticUpdate = <T>(
  items: T[],
  updateFn: (id: string, updates: Partial<T>) => Promise<T>
) => {
  const [optimisticItems, setOptimisticItems] = useState(items);

  useEffect(() => {
    setOptimisticItems(items);
  }, [items]);

  const updateOptimistically = async (id: string, updates: Partial<T>) => {
    // Update UI immediately
    setOptimisticItems(prev =>
      prev.map(item => 
        (item as any).id === id ? { ...item, ...updates } : item
      )
    );

    try {
      // Send API request
      await updateFn(id, updates);
    } catch (error) {
      // Revert on error
      setOptimisticItems(items);
      throw error;
    }
  };

  return { optimisticItems, updateOptimistically };
};
```

## Pattern per Styling Dinamico

### CSS Classes Dinamiche
```typescript
const Button = ({ 
  variant = 'primary', 
  size = 'medium', 
  disabled = false,
  children,
  ...props 
}: ButtonProps) => {
  const baseClasses = 'btn';
  const variantClass = `btn-${variant}`;
  const sizeClass = `btn-${size}`;
  const disabledClass = disabled ? 'btn-disabled' : '';
  
  const className = [baseClasses, variantClass, sizeClass, disabledClass]
    .filter(Boolean)
    .join(' ');

  return (
    <button className={className} disabled={disabled} {...props}>
      {children}
    </button>
  );
};

// Helper function per classi condizionali
const classNames = (...classes: (string | undefined | false)[]): string => {
  return classes.filter(Boolean).join(' ');
};

// Utilizzo
const className = classNames(
  'base-class',
  isActive && 'active',
  hasError && 'error',
  size === 'large' && 'large'
);
```

## Pattern per Responsive Design

### Hook per Media Queries
```typescript
const useMediaQuery = (query: string): boolean => {
  const [matches, setMatches] = useState(false);

  useEffect(() => {
    const media = window.matchMedia(query);
    if (media.matches !== matches) {
      setMatches(media.matches);
    }
    
    const listener = () => setMatches(media.matches);
    media.addEventListener('change', listener);
    
    return () => media.removeEventListener('change', listener);
  }, [matches, query]);

  return matches;
};

// Utilizzo
const ResponsiveComponent = () => {
  const isMobile = useMediaQuery('(max-width: 768px)');
  const isTablet = useMediaQuery('(max-width: 1024px)');

  return (
    <div>
      {isMobile ? (
        <MobileLayout />
      ) : isTablet ? (
        <TabletLayout />
      ) : (
        <DesktopLayout />
      )}
    </div>
  );
};
```

## Pattern per Performance

### Memoizzazione Components
```typescript
// React.memo per component puri
const ItemCard = React.memo(({ item }: { item: Item }) => {
  return (
    <div className="item-card">
      <h3>{item.name}</h3>
      <p>{item.description}</p>
    </div>
  );
});

// useMemo per calcoli costosi
const ExpensiveComponent = ({ items }: { items: Item[] }) => {
  const expensiveValue = useMemo(() => {
    return items.reduce((sum, item) => sum + item.price, 0);
  }, [items]);

  return <div>Total: ${expensiveValue}</div>;
};

// useCallback per funzioni che dipendono da props
const SearchableList = ({ items, onItemClick }: ListProps) => {
  const [search, setSearch] = useState('');

  const handleItemClick = useCallback((item: Item) => {
    onItemClick(item);
  }, [onItemClick]);

  const filteredItems = useMemo(() => {
    return items.filter(item => 
      item.name.toLowerCase().includes(search.toLowerCase())
    );
  }, [items, search]);

  return (
    <div>
      <input 
        value={search} 
        onChange={(e) => setSearch(e.target.value)} 
      />
      {filteredItems.map(item => (
        <ItemCard 
          key={item.id} 
          item={item} 
          onClick={handleItemClick}
        />
      ))}
    </div>
  );
};
```

## Quick Reference

### Pattern Più Utilizzati:
1. **Early Return** - Per gestione condizioni
2. **Loading/Error States** - Per chiamate API
3. **Controlled Forms** - Per input utente
4. **Modal Pattern** - Per popup/dialog
5. **Lista con Search** - Per visualizzazione dati
6. **Optimistic Updates** - Per UX fluida

### Pattern di Emergenza (quando il tempo stringe):
- Inline styles invece di CSS classes
- Any types invece di TypeScript strict
- Console.log invece di proper error handling
- Mock data invece di API fixing