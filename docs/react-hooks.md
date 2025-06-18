# React Hooks

## Hook Fondamentali

### useState - Gestione Stato Locale

#### Sintassi Base
```typescript
import { useState } from 'react';

const [state, setState] = useState<Type>(initialValue);
```

#### Esempi Pratici
```typescript
// Stato semplice
const [count, setCount] = useState<number>(0);
const [name, setName] = useState<string>('');
const [isLoading, setIsLoading] = useState<boolean>(false);

// Stato complesso
interface User {
  id: number;
  name: string;
  email: string;
}

const [user, setUser] = useState<User | null>(null);
const [users, setUsers] = useState<User[]>([]);
```

#### Aggiornamento Stato
```typescript
// ❌ Modifica diretta (non fare)
count = count + 1;

// ✅ Aggiornamento corretto
setCount(count + 1);

// ✅ Aggiornamento funzionale (preferito per calcoli)
setCount(prev => prev + 1);

// ✅ Aggiornamento oggetti/array
setUser({ ...user, name: 'Nuovo Nome' });
setUsers(prev => [...prev, newUser]);
```

### useEffect - Gestione Effetti Collaterali

#### Sintassi e Array di Dipendenze
```typescript
import { useEffect } from 'react';

// Esegue ad ogni render
useEffect(() => {
  console.log('Ad ogni render');
});

// Esegue solo al mount
useEffect(() => {
  console.log('Solo al mount');
}, []);

// Esegue quando cambiano le dipendenze
useEffect(() => {
  console.log('Quando cambia count');
}, [count]);

// Con cleanup function
useEffect(() => {
  const timer = setInterval(() => {
    console.log('Timer tick');
  }, 1000);

  return () => clearInterval(timer); // Cleanup
}, []);
```

#### Pattern Comuni con useEffect
```typescript
// Fetch dati al mount
useEffect(() => {
  const fetchData = async () => {
    setIsLoading(true);
    try {
      const response = await fetch('/api/data');
      const data = await response.json();
      setData(data);
    } catch (error) {
      setError(error);
    } finally {
      setIsLoading(false);
    }
  };

  fetchData();
}, []);

// Sincronizzazione con localStorage
useEffect(() => {
  localStorage.setItem('user', JSON.stringify(user));
}, [user]);

// Event listeners
useEffect(() => {
  const handleResize = () => {
    setWindowWidth(window.innerWidth);
  };

  window.addEventListener('resize', handleResize);
  return () => window.removeEventListener('resize', handleResize);
}, []);
```

## Custom Hooks

### Perché Creare Custom Hooks?
- Riutilizzo della logica
- Separazione delle responsabilità
- Codice più pulito e leggibile

### Pattern: useApi Hook
```typescript
// hooks/useApi.ts
import { useState, useEffect } from 'react';

interface ApiState<T> {
  data: T | null;
  loading: boolean;
  error: Error | null;
}

function useApi<T>(url: string): ApiState<T> {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      setError(null);
      
      try {
        const response = await fetch(url);
        if (!response.ok) throw new Error('API Error');
        const result = await response.json();
        setData(result);
      } catch (err) {
        setError(err as Error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [url]);

  return { data, loading, error };
}

// Utilizzo
const { data, loading, error } = useApi<User[]>('/api/users');
```

### Pattern: useLocalStorage Hook
```typescript
// hooks/useLocalStorage.ts
import { useState } from 'react';

function useLocalStorage<T>(key: string, initialValue: T) {
  const [value, setValue] = useState<T>(() => {
    try {
      const item = localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch {
      return initialValue;
    }
  });

  const setStoredValue = (value: T | ((val: T) => T)) => {
    try {
      const valueToStore = value instanceof Function ? value(value) : value;
      setValue(valueToStore);
      localStorage.setItem(key, JSON.stringify(valueToStore));
    } catch (error) {
      console.error('Error saving to localStorage:', error);
    }
  };

  return [value, setStoredValue] as const;
}

// Utilizzo
const [token, setToken] = useLocalStorage<string | null>('authToken', null);
```

### Pattern: Custom Hook per Form
```typescript
// hooks/useForm.ts
import { useState } from 'react';

interface UseFormProps<T> {
  initialValues: T;
  onSubmit: (values: T) => void;
}

function useForm<T>({ initialValues, onSubmit }: UseFormProps<T>) {
  const [values, setValues] = useState<T>(initialValues);
  const [errors, setErrors] = useState<Partial<T>>({});

  const handleChange = (name: keyof T, value: any) => {
    setValues(prev => ({ ...prev, [name]: value }));
    // Rimuovi errore quando l'utente modifica il campo
    if (errors[name]) {
      setErrors(prev => ({ ...prev, [name]: undefined }));
    }
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSubmit(values);
  };

  const reset = () => {
    setValues(initialValues);
    setErrors({});
  };

  return {
    values,
    errors,
    handleChange,
    handleSubmit,
    setErrors,
    reset
  };
}

// Utilizzo
interface LoginForm {
  username: string;
  password: string;
}

const {
  values,
  errors,
  handleChange,
  handleSubmit,
  setErrors
} = useForm<LoginForm>({
  initialValues: { username: '', password: '' },
  onSubmit: (values) => console.log(values)
});
```

## Hooks Avanzati

### useReducer - Per Stati Complessi
```typescript
import { useReducer } from 'react';

interface State {
  count: number;
  loading: boolean;
}

type Action = 
  | { type: 'increment' }
  | { type: 'decrement' }
  | { type: 'setLoading'; payload: boolean };

const reducer = (state: State, action: Action): State => {
  switch (action.type) {
    case 'increment':
      return { ...state, count: state.count + 1 };
    case 'decrement':
      return { ...state, count: state.count - 1 };
    case 'setLoading':
      return { ...state, loading: action.payload };
    default:
      return state;
  }
};

const [state, dispatch] = useReducer(reducer, { count: 0, loading: false });
```

### useMemo - Ottimizzazione Calcoli
```typescript
import { useMemo } from 'react';

const expensiveValue = useMemo(() => {
  return heavyCalculation(data);
}, [data]); // Solo quando 'data' cambia
```

### useCallback - Ottimizzazione Funzioni
```typescript
import { useCallback } from 'react';

const handleClick = useCallback((id: number) => {
  onItemClick(id);
}, [onItemClick]);
```

## Pattern Comuni

### 1. Loading States Pattern
```typescript
const useAsyncOperation = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const execute = async (operation: () => Promise<any>) => {
    setLoading(true);
    setError(null);
    try {
      const result = await operation();
      return result;
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unknown error');
      throw err;
    } finally {
      setLoading(false);
    }
  };

  return { loading, error, execute };
};
```

### 2. Data Fetching Pattern
```typescript
const useDataFetching = <T>(fetcher: () => Promise<T>) => {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const refetch = useCallback(async () => {
    setLoading(true);
    try {
      const result = await fetcher();
      setData(result);
      setError(null);
    } catch (err) {
      setError(err as Error);
    } finally {
      setLoading(false);
    }
  }, [fetcher]);

  useEffect(() => {
    refetch();
  }, [refetch]);

  return { data, loading, error, refetch };
};
```

## Errori Comuni da Evitare

### 1. Dipendenze Mancanti in useEffect
```typescript
// ❌ Sbagliato
useEffect(() => {
  fetchData(userId);
}, []); // userId mancante

// ✅ Corretto
useEffect(() => {
  fetchData(userId);
}, [userId]);
```

### 2. Aggiornamenti di Stato Multipli
```typescript
// ❌ Può causare render multipli
setCount(count + 1);
setName('New name');
setLoading(false);

// ✅ Meglio raggruppare o usare useReducer
setState(prev => ({
  ...prev,
  count: prev.count + 1,
  name: 'New name',
  loading: false
}));
```

### 3. Infinite Loops in useEffect
```typescript
// ❌ Loop infinito
useEffect(() => {
  setData(processData(data));
}, [data]);

// ✅ Condizione corretta
useEffect(() => {
  if (shouldProcess) {
    setData(processData(data));
  }
}, [data, shouldProcess]);
```

## Checklist Hooks

- [ ] useState per stato locale semplice
- [ ] useEffect con array dipendenze corretto
- [ ] Custom hooks per logica riutilizzabile
- [ ] Gestione loading/error states
- [ ] Cleanup functions dove necessario
- [ ] Tipizzazione TypeScript corretta
- [ ] Evitare infinite loops

## Prossimo: [Gestione API](./react-api.md) 