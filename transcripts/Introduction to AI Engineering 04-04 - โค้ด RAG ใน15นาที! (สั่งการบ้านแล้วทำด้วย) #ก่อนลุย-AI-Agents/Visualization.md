# Coding a Simple Restaurant RAG Application

**Visual goal:** Follow the same RAG logic from document embeddings in Jupyter to a cached, interactive Streamlit application.

[Read the detailed summary](./Summary.md)

## End-to-end view

```mermaid
flowchart LR
    A["10 restaurant documents"] --> B["Gemini embedding model"]
    B --> C["10 vectors with 768 dimensions"]
    C --> D["In-memory vector collection"]
    E["User asks about Indian food"] --> F["Embed query"]
    F --> G["Similarity search"]
    D --> G
    G --> H["Top restaurant context"]
    H --> I["Augmented prompt"]
    E --> I
    I --> J["Gemini Flash"]
    J --> K["Restaurant answer"]
```

The demo prepares searchable knowledge first, then uses that knowledge for every question.

## Notebook execution sequence

```mermaid
sequenceDiagram
    participant Dev as Learner
    participant NB as Jupyter Notebook
    participant Embed as Gemini embeddings
    participant Search as Similarity search
    participant LLM as Gemini Flash
    Dev->>NB: Load prepared restaurant documents
    NB->>Embed: Embed 10 documents
    Embed-->>NB: Return 10 by 768 vectors
    Dev->>NB: Enter Indian Food query
    NB->>Embed: Embed query
    Embed-->>NB: Return query vector
    NB->>Search: Compare against restaurant vectors
    Search-->>NB: Return strongest matching context
    NB->>LLM: Send query plus restaurant context
    LLM-->>NB: Return direct recommendation
```

> **Mental model:** The notebook is a transparent assembly line. Each cell exposes one RAG operation, so you can verify document preparation, query retrieval, prompt construction, and generation before hiding them behind an app.

## Semantic search mechanics

```mermaid
flowchart TD
    A["Text query"] --> B["Embedding model"]
    B --> C["Query vector"]
    C --> D["Compare with restaurant vector 1"]
    C --> E["Compare with restaurant vector 2"]
    C --> F["Compare with remaining vectors"]
    D --> G["Similarity scores"]
    E --> G
    F --> G
    G --> H["Sort by relevance"]
    H --> I["Return top matching restaurant"]
```

| Item | Demo implementation | Production direction mentioned |
|---|---|---|
| Documents | 10 cleaned restaurant descriptions | Larger, continuously managed collection |
| Vector size | 768 dimensions | Depends on selected embedding model |
| Storage | Jupyter or app memory | ChromaDB, Milvus, FAISS, or Elasticsearch |
| Search | Basic similarity comparison | More advanced retrieval techniques |
| Interface | Minimal Streamlit app | Application-specific user experience |
| Reuse | Cache restaurant embeddings | Persistent indexed storage |

## From notebook functions to Streamlit

```mermaid
flowchart TD
    A["Start Streamlit app"] --> B{"Embeddings cached?"}
    B -->|No| C["Embed restaurant documents"]
    C --> D["Store cached vectors"]
    B -->|Yes| D
    D --> E["Wait for user query"]
    E --> F["Embed and search query"]
    F --> G["Retrieve restaurant context"]
    G --> H["Generate response"]
    H --> I["Display result"]
    I --> E
```

Start the interface with:

```bash
streamlit run app.py
```

Caching avoids repeating stable document-embedding work whenever the page refreshes.

## Why retrieve instead of sending everything

```mermaid
flowchart LR
    A["Large document collection"] --> B{"Prompt strategy"}
    B --> C["Send every document"]
    B --> D["Retrieve relevant documents"]
    C --> E["More context usage"]
    C --> F["Risk of exceeding context window"]
    D --> G["Focused evidence"]
    D --> H["More efficient prompt"]
    G --> I["Generated answer"]
    H --> I
```

| RAG stage | Input | Output |
|---|---|---|
| Prepare | Restaurant descriptions | Document vectors |
| Retrieve | Query vector plus document vectors | Relevant restaurant context |
| Augment | Query plus retrieved context | Completed prompt |
| Generate | Completed prompt | Natural-language answer |

## Visual learning path

1. Inspect the 10 prepared restaurant documents.
2. Create and examine the 10 by 768 embedding shape.
3. Embed `Indian Food` and compare it with all document vectors.
4. Inspect the highest-scoring restaurant context.
5. Add that context and the original query to the prompt.
6. Generate the response with Gemini Flash.
7. Reuse the functions in Streamlit and verify caching.
8. Replace the documents and questions as the assigned exercise.

## Check your understanding

1. Why must the query use the same embedding approach as the restaurant documents?
2. What is stored in memory during this demonstration?
3. Why does retrieval help even if an LLM could accept several documents directly?
4. What work does Streamlit caching avoid?
5. Which parts of the notebook pipeline are reused in the web application?

