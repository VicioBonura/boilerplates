import { useState, useEffect, useRef } from "react";

export const useImageLoader = (imageUrl: string) => {
  const [loading, setLoading] = useState<boolean>(true);
  const [loaded, setLoaded] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const imageRef = useRef<HTMLImageElement>(null);

  //RESET
  useEffect(() => {
    setLoading(true);
    setLoaded(false);
    setError(null);
  }, [imageUrl]);

  //SETUP LISTENERS
  useEffect(() => {
    const imageElement = imageRef.current;
    if (!imageElement || !imageUrl) return;

    const handleLoad = () => {
      setLoading(false);
      setLoaded(true);
      setError(null);
    };

    const handleError = () => {
      setLoading(false);
      setLoaded(false);
      setError("Failed to load image");
    };

    imageElement.addEventListener("load", handleLoad);
    imageElement.addEventListener("error", handleError);

    return () => {
      imageElement.removeEventListener("load", handleLoad);
      imageElement.removeEventListener("error", handleError);
    };
  }, [imageUrl]);

  return { loading, loaded, error, imageRef };
};
