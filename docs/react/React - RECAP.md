---
Title: React - RECAP
Author: Vincenzo Bonura
date: 2025-06-17
version: 1.0.0
tags: 
external links: 
---
# React - RECAP

## Info su prova d'esame
**Quiz**: ci sono domande a risposta multipla su tutte le materie del corso, con numero proporzionale alla durata dell'insegnamento, da un minimo di 1 a un massimo di 3. La prova durerà 2 ore.
*Per React*: gli argomenti delle domande saranno tratti dal [[REACT JS - GLOSSARIO.pdf|glossario]]:
- ciclo di vita componente
- montaggio/smontaggio componente
- sintassi JSX
- tipizzazione
- funzionamento array dipendenze useEffect (se vuoto, solo al mount, se pieno )
- class VS className
- differenza useState / useEffect
- sintassi onChange
  - referenziazione: `onChange`
  - funzione anonima: `() => onChange()`


>[!note]- *Dall'esame precedente*
>- Class & Funcional componets
>- Dumb & Smart Components
>- Hooks (useStaet & useEffect)
>- Custom Hooks
>- State & Props
>- Events (es. button onClick)
>- JSX / TSX (sintassi)
>- DOM
>- Lifecycle (mount, update, unmount)
>- MPX & SPA
>- Promises (async/await & then/catch)
>- ECMAScript (es. destrutturazione)
>- JSON
>- Librerie & Frameworks (differenze e usi)
>- HTTP endpoint & Fetch

Argomenti *generali*:
- protocollo HTTP
- comunicazione client/server
	- protocollo REST
- libreria VS framework
- DOM

**Prova pratica**: sono state preparate 4 tracce, una di queste sarà utilizzata per la prova dell'esame, un'altra sarà quella ufficiale da utilizzare durante l'esame finale. La macchina virtuale sarà resettata e configurata con l'installazione di base minima per garantire l'esecuzione della prova. La prova durerà 6 ore.

>[!abstract]- Aspetti da rivedere
> - API (fetch, json)
> - REST (CRUD)
> - Preprocessori e Grunt (se PHP)
> - UI (minima, opzionale)
> - Auth (Firebase)

## Approccio alla prova pratica
- **Analisi**: verificare bene **tutti** i requisiti prima di iniziare lo sviluppo, per evitare di perdere qualche funzionalità obbligatoria che costerebbe punti.
	- **Analisi approfondita**: conoscendo i requisiti espressi, valutare i requisiti impliciti dipendenti (p.e.: se tra i requisiti c'è un modale, considerare i comportamenti necessari a ottenere una buona UX)
	- **Documentazione**: se è richiesta documentazione, farla asciutta e chiara
- **Task & Check**: preparare una task list per le implementazioni da eseguire, in modo da avere una roadmap chiara da controllare durante la prova
- **Scaffolding**: Preparare lo scaffold iniziale e ripulire il boilerplate preconfigurato
- **Compilazione**: Verificare la compilazione del progetto al termine della prova, prima di consegnare il pacchetto di codice
	- **Consegna**: sarà in ZIP sulla piattaforma FAD; cancellare i *node_modules*

### Per React
Aspetti da riprendere

#### Vite React

```bash
> npm create vite
```

#### React Router

```bash
> npm i react-router
```

#### Pages - Routes

```jsx
<Route path="/:id" element={<Detail />}
```

```jsx
const Detail = () => {
	const { id } = useParams();
}
```

#### Fetch API

- Documentazione > Formato risposta
- Tipizzare i valori essenziali della risposta dell'endpoint
  
```typescript
const type ListType = {
	/*...*/
}
```

- Definire le costanti
  
```typescript
const BASEURL = "https://..."
```

- Definire la fetch
  
```typescript
export const getList = async () => {
	const res = await fetch(`${BASEURL}/...`);
	const data:ListType[] = await res.json();
	//OPPURE const data = await res.text();
	
	if(!res.ok) throw new Error("error text")
	return data;
}

export const sendData = async(payload:ListType) => {
		const res = await fetch(`${BASEURL}/...`,
			{ body: json.stringify(payload)	}
		)
	}
}

```

#### Custom Hook useApiList

```typescript
const useListApi = () => {
	const [results, setResults] = useState<ListType[]>([]);
	const [loading, setLoading] = useState<Boolean>(false);
	useEffect(() => {
		setLoading(true);
		getList()
			.then(data => {setResults(data)})
			.finally(() => {setLoading(false)})
	}, []);
	return { results, loading }
}

export default useListApi;
```

```typescript
const useListUpdateApi = () => {
	const [loading, setLoading] = useState<Boolean>(false);
	const sendData = async (payload:ListType) => {
		const res = await fetch(
			`...`,
			{
				body: json.stringify(payload)
			}
		)
	}
	//OPPURE importare sendData da file helper

	return { loading, sendData }
}

export default useListUpdateApi;
```

::LiArrowRight:: sul frontend: 

```typescript
const { results, loading } = useListApi();
const { sendData } = useListUpdateApi(); //se API POST, necessita payload

/*...*/

sendData(payload);
```

#### Navigate

```jsx
<Link to={`/${id}`} />

//OPPURE

const navigate = useNavigate();
navifate("/path");
```

#### useParams

```jsx
//App.tsx
<Route path="/:id" element={<Detail/>}

//Detail.tsx
const { id } = useParams();
```

#### Components - State - Props

I **componenti** possono essere *smart* (contengono la logica) o *dumb* (che rappresentano solo il presentation layer). In fase di progettazione è fondamentale definire in modo accurato le responsabilità dei componenti per realizzare in modo ottimizzato la logica complessiva dell'applicazione.

>[!abstract]- **Caso d'uso: input con validazione**
>Un componente che deve gestire la validazione dell'input, potrebbe essere *smart* per gestirla a livello interno e non demandarla al parent. In questo caso, per UX, è bene tenere conto della gestione del valore invalido, per evitare che il componente stesso ripulisca il campo input se il valore non è valido, creando difficoltà all'utente
>```jsx
><ValidInput value={invalidValue || value} onChange={updateValue} />
>```

Lo **State** è un parametro interno al componente, che necessita di una *callback function* per essere trasmesso all'esterno. Le **Props** (di cui la callback function è un esempio), sono invece esterne al componente, passate dal componente parent e ne influenzano il comportamento.

#### API Post