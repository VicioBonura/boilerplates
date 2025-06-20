import { useState, useEffect } from "react";

interface UseApiState<T> {
  data: T | null;
  loading: boolean;
  error: string | null;
}

export const useApi = <T>(
  apiCall: () => Promise<T>,
  dependencies: unknown[] = []
) => {
  const [state, setState] = useState<UseApiState<T>>({
    data: null,
    loading: true,
    error: null,
  });

  useEffect(() => {
    let isCancelled = false;

    const fetchData = async () => {
      setState((prev) => ({ ...prev, loading: true, error: null }));

      try {
        const result = await apiCall();
        if (!isCancelled) {
          setState({ data: result, loading: false, error: null });
        }
      } catch (error) {
        if (!isCancelled) {
          setState({
            data: null,
            loading: false,
            error: error instanceof Error ? error.message : "Unknown error",
          });
        }
      }
    };

    fetchData();

    return () => {
      isCancelled = true;
    };
  }, dependencies);

  const refetch = () => {
    setState((prev) => ({ ...prev, loading: true, error: null }));
    // Trigger useEffect re-run
  };

  return { ...state, refetch };
};
