# React API

## Fetch API e Gestione Errori

### Setup Base per API
```typescript
// services/api.ts
const API_BASE_URL = 'https://api.example.com';

// Configurazione base fetch
const fetchWithConfig = async (url: string, options: RequestInit = {}) => {
  const token = localStorage.getItem('authToken');
  
  const config: RequestInit = {
    headers: {
      'Content-Type': 'application/json',
      ...(token && { Authorization: `Bearer ${token}` }),
      ...options.headers,
    },
    ...options,
  };

  const response = await fetch(`${API_BASE_URL}${url}`, config);
  
  if (!response.ok) {
    const error = await response.text();
    throw new Error(error || `HTTP Error: ${response.status}`);
  }

  return response.json();
};
```

### Metodi HTTP Standard
```typescript
// GET - Lettura dati
export const getData = async <T>(endpoint: string): Promise<T> => {
  return fetchWithConfig(endpoint);
};

// POST - Creazione
export const postData = async <T, K>(endpoint: string, data: K): Promise<T> => {
  return fetchWithConfig(endpoint, {
    method: 'POST',
    body: JSON.stringify(data),
  });
};

// PUT - Aggiornamento completo
export const putData = async <T, K>(endpoint: string, data: K): Promise<T> => {
  return fetchWithConfig(endpoint, {
    method: 'PUT',
    body: JSON.stringify(data),
  });
};

// DELETE - Eliminazione
export const deleteData = async (endpoint: string): Promise<void> => {
  return fetchWithConfig(endpoint, {
    method: 'DELETE',
  });
};
```

## Custom Hooks per API

### useApi Hook Generico
```typescript
// hooks/useApi.ts
import { useState, useEffect } from 'react';

interface UseApiResult<T> {
  data: T | null;
  loading: boolean;
  error: string | null;
  refetch: () => Promise<void>;
}

export const useApi = <T>(
  fetcher: () => Promise<T>,
  dependencies: any[] = []
): UseApiResult<T> => {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const fetchData = async () => {
    setLoading(true);
    setError(null);
    
    try {
      const result = await fetcher();
      setData(result);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unknown error');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, dependencies);

  return { data, loading, error, refetch: fetchData };
};

// Utilizzo
const { data: users, loading, error } = useApi(() => getData<User[]>('/users'));
```

### Pattern Equiprent
```typescript
// types/equipment.d.ts
export interface Equipment {
  id: number;
  name: string;
  claim: string;
  image: string;
  icon: string;
  pricePerMinute: number;
}

// services/equipmentApi.ts
const EQUIPMENT_API_BASE = 'https://d3660g9kardf5b.cloudfront.net';

export const getEquipmentList = async (): Promise<Equipment[]> => {
  const response = await fetch(`${EQUIPMENT_API_BASE}/api/equipment`);
  if (!response.ok) throw new Error('Failed to fetch equipment');
  return response.json();
};

export const bookEquipment = async (
  id: number, 
  duration: number,
  token?: string
): Promise<any> => {
  const headers: HeadersInit = {
    'Content-Type': 'application/json',
  };
  
  if (token) {
    headers.Authorization = `Bearer ${token}`;
  }

  const response = await fetch(`${EQUIPMENT_API_BASE}/api/equipment/${id}/book`, {
    method: 'POST',
    headers,
    body: JSON.stringify({ duration }),
  });

  if (!response.ok) throw new Error('Booking failed');
  return response.json();
};

// hooks/useEquipmentApi.ts
export const useEquipmentList = () => {
  return useApi(getEquipmentList);
};
```

## Gestione Loading e Errori

### Pattern Loading States
```typescript
const DataComponent = () => {
  const { data, loading, error, refetch } = useApi(fetchData);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error} <button onClick={refetch}>Retry</button></div>;
  if (!data) return <div>No data available</div>;

  return (
    <div>
      {data.map(item => (
        <div key={item.id}>{item.name}</div>
      ))}
    </div>
  );
};
```

## Ottimizzazioni Avanzate

### Debouncing per Ricerche
```typescript
// hooks/useDebounce.ts
import { useState, useEffect } from 'react';

export const useDebounce = <T>(value: T, delay: number): T => {
  const [debouncedValue, setDebouncedValue] = useState<T>(value);

  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value);
    }, delay);

    return () => {
      clearTimeout(handler);
    };
  }, [value, delay]);

  return debouncedValue;
};
```

## Checklist API

- [ ] Services layer separato per chiamate API
- [ ] Gestione errori HTTP appropriata
- [ ] Custom hooks per operazioni CRUD
- [ ] Loading states su tutte le chiamate
- [ ] TypeScript interfaces per response API
- [ ] Headers Authorization per auth

## Prossimo: [Context e Autenticazione](./react-auth.md) 