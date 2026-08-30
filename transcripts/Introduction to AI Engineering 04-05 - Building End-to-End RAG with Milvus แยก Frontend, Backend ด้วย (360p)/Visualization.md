# End-to-End RAG with Milvus, FastAPI, and Streamlit

**Visual goal:** Connect the offline document-ingestion pipeline with the online question-answering path, and see where chunking, embeddings, Milvus, retrieval, and Gemini each contribute.

[Read the detailed summary](./Summary.md)

## Big picture: two journeys, one knowledge base

```mermaid
flowchart LR
    subgraph Ingest["Document ingestion"]
        A["Thai HR policy PDF"] --> B["Extract page text"]
        B --> C["Split into overlapping chunks"]
        C --> D["Gemini embedding model"]
        D --> E["Milvus collection on Zilliz Cloud"]
    end
    subgraph Query["User query"]
        F["Streamlit question"] --> G["FastAPI backend"]
        G --> H["Embed question"]
        H --> E
        E --> I["Retrieve nearby chunks"]
        I --> J["Gemini answer generation"]
        J --> F
    end
```

The ingestion journey prepares searchable knowledge before users ask questions. The query journey reuses the same embedding space to find policy chunks whose meanings are close to the question.

## Ingestion pipeline

```mermaid
sequenceDiagram
    participant PDF as Policy PDF
    participant Prep as Extraction and chunking
    participant Embed as Gemini embeddings
    participant DB as Milvus
    PDF->>Prep: Extract text page by page
    Prep->>Prep: Create chunks of 1000 characters
    Prep->>Prep: Preserve 200 character overlap
    Prep->>Embed: Send each chunk
    Embed-->>Prep: Return 768 dimension vector
    Prep->>DB: Insert id title content embedding
    Prep->>DB: Create search index
```

Overlap keeps neighboring context around chunk boundaries. The chunk CSV is the bridge between document preparation and vector ingestion.

| Collection field | Meaning |
|---|---|
| `id` | Unique record identifier |
| `title` | Document or page label |
| `chunk_content` | Searchable policy text |
| `embedding` | 768-dimensional semantic vector |

Connection details for hosted Milvus belong in `.env`, not in source code.

## Retrieval and grounded answer generation

```mermaid
sequenceDiagram
    participant User as User
    participant UI as Streamlit
    participant API as FastAPI port 8000
    participant Embed as Gemini embeddings
    participant DB as Milvus
    participant LLM as Gemini language model
    User->>UI: Ask Thai leave policy question
    UI->>API: Send question to chat endpoint
    API->>Embed: Embed question
    Embed-->>API: Query vector
    API->>DB: Search nearest chunk vectors
    DB-->>API: Relevant chunks and scores
    API->>LLM: Send question plus retrieved context
    LLM-->>API: Generate grounded answer
    API-->>UI: Return answer
    UI-->>User: Display result
```

Streamlit owns interaction and display. FastAPI owns retrieval and answer orchestration. Milvus stores searchable knowledge. Gemini performs both embedding and answer generation, using different model capabilities.

## How vector search narrows meaning

```mermaid
flowchart TD
    A["Question embedding"] --> B{"Search method"}
    B --> C["FLAT"]
    B --> D["IVF FLAT"]
    C --> E["Compare with every stored vector"]
    D --> F["Select relevant vector clusters"]
    F --> G["Search inside selected clusters"]
    E --> H["Rank by distance or similarity"]
    G --> H
    H --> I["Return closest policy chunks"]
```

| Concept | Interpretation |
|---|---|
| L2 distance | Lower distance means vectors are closer |
| Cosine similarity | Compares vector direction |
| Inner product | Another vector matching metric |
| FLAT | Exhaustive comparison across all vectors |
| IVF_FLAT | Cluster first, then search a narrower region |

Indexing improves search efficiency as the collection grows. It does not automatically fix weak embeddings or poorly chosen chunks.

## Quality depends on the whole retrieval chain

```mermaid
flowchart LR
    A["Relevant user question"] --> B["Suitable Thai embedding model"]
    B --> C["Effective chunk size and overlap"]
    C --> D["Correct vector metric and index"]
    D --> E["Relevant retrieved context"]
    E --> F["Grounded answer"]
    G["Generic greeting"] --> H["Weak semantic match"]
    H --> I["Irrelevant retrieved chunks"]
```

The lecture uses Google's free `text-embedding-004` model, but notes that it is not necessarily the strongest model for Thai retrieval. Thai-capable models should be compared using MTEB or similar benchmarks.

> **Mental model:** RAG is a two-stage answer system. Retrieval first selects evidence from the document collection, then generation turns that evidence into a readable answer. If retrieval supplies poor evidence, the generation stage has little reliable material to use.

## Visual learning path

1. Extract the five-page Thai policy PDF and inspect page-level text.
2. Chunk it with size `1000` and overlap `200`.
3. Embed each chunk and store its text, metadata, and vector in `milvus_collection`.
4. Create an index and test retrieval with realistic Thai policy questions.
5. Start FastAPI on port `8000`, then run Streamlit separately.
6. Trace one question through embedding, vector search, context assembly, and answer generation.
7. Improve components independently, especially Thai embeddings, chunking, and deployment.

## Check your understanding

1. Why are document chunks and user questions embedded with the same embedding approach?
2. What problem does chunk overlap reduce?
3. Which service separates the Streamlit frontend from Milvus and Gemini logic?
4. Why can `hello` retrieve irrelevant HR policy chunks?
5. What does IVF_FLAT change compared with FLAT search?
