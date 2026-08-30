# Rerankers in Advanced RAG

**Visual goal:** See why advanced RAG uses fast vector retrieval first and a Cross-Encoder second to produce a more relevant document order.

[Read the detailed summary](./Summary.md)

## Traditional RAG and reranked RAG

```mermaid
flowchart LR
    A["User query"] --> B["Bi-Encoder embedding model"]
    B --> C["Query vector"]
    C --> D["Vector database search"]
    D --> E["Initial Top K documents"]
    E --> F{"Use a Reranker?"}
    F -->|No| G["Send initial order to LLM"]
    F -->|Yes| H["Cross-Encoder scores query-document pairs"]
    H --> I["Sort by new relevance scores"]
    I --> J["Send reranked context to LLM"]
    G --> K["Generated answer"]
    J --> K
```

The initial search efficiently narrows the full collection. The Reranker then spends more computation only on that smaller set.

## Bi-Encoder and Cross-Encoder mapping

```mermaid
flowchart TD
    subgraph Bi["Bi-Encoder stage"]
        A["Query text"] --> B["Embedding model"]
        B --> C["Query vector"]
        D["Document text"] --> E["Embedding model"]
        E --> F["Precomputed document vector"]
        C --> G["Vector similarity"]
        F --> G
        G --> H["Broad candidate retrieval"]
    end
    subgraph Cross["Cross-Encoder stage"]
        I["Original query"] --> K["Cross-Encoder"]
        J["One candidate document"] --> K
        K --> L["Joint relevance score"]
        L --> M["Precise candidate ordering"]
    end
    H --> I
    H --> J
```

| Property | Bi-Encoder embedding model | Cross-Encoder Reranker |
|---|---|---|
| Input | One text item at a time | Query and document together |
| Output | Vector | Relevance score |
| Document work | Can be precomputed | Recomputed for each query-document pair |
| Main job | Fast candidate retrieval | Precise candidate ordering |
| Scale | Suitable for searching many stored vectors | Best applied to a filtered candidate set |

> **Mental model:** The embedding model is a fast scout that finds a promising shortlist. The Reranker is a careful judge that reads the query beside every shortlisted document and rearranges the finalists.

## Reranking sequence for Top K

```mermaid
sequenceDiagram
    participant User as User
    participant Embed as Bi-Encoder
    participant DB as Vector database
    participant Rank as Cross-Encoder
    participant LLM as Language model
    User->>Embed: Submit query
    Embed->>DB: Search with query vector
    DB-->>Embed: Return initial Top K documents
    loop Each candidate document
        Embed->>Rank: Send original query plus candidate
        Rank-->>Embed: Return relevance score
    end
    Embed->>Embed: Sort candidates by reranker score
    Embed->>LLM: Send reranked context and question
    LLM-->>User: Return generated answer
```

For K candidates, the Cross-Encoder must score K query-document pairs.

## Example score reordering

```mermaid
flowchart LR
    A["Query: What is panda?"] --> B["Pair with document: Hi"]
    A --> C["Pair with giant panda document"]
    B --> D["Raw score about -8.1875"]
    C --> E["Raw score about 5.26"]
    D --> F["Rank lower"]
    E --> G["Rank higher"]
```

The score scale depends on the model. The useful operation is comparing scores and ordering candidates, not interpreting one score in isolation.

| Evaluation view | Without Reranker | With Reranker |
|---|---:|---:|
| Example MRR reported in lesson | About 0.65 | About 0.82 |
| Candidate order | Vector-search order | Cross-Encoder score order |
| Extra pair inference | None | One per candidate |
| Pipeline complexity | Lower | Higher |

## Accuracy versus resource decision

```mermaid
flowchart TD
    A["Initial retrieval is not accurate enough"] --> B{"Can the system afford extra inference?"}
    B -->|No| C["Improve embeddings chunking or search first"]
    B -->|Yes| D["Choose candidate count K"]
    D --> E["Rerank 10 or 20 as examples"]
    E --> F["Measure retrieval quality"]
    E --> G["Measure latency and compute"]
    F --> H{"Quality gain justifies cost?"}
    G --> H
    H -->|Yes| I["Use Reranker in production"]
    H -->|No| J["Reduce K change model or omit Reranker"]
```

| Increasing K may provide | Increasing K also causes |
|---|---|
| More candidates for precise review | More Cross-Encoder computations |
| Better chance to recover a relevant result | Higher latency |
| Potentially stronger final ordering | Higher CPU or GPU resource usage |

## Visual learning path

1. Understand how a Bi-Encoder converts the query into one vector.
2. Observe the initial Top K returned from precomputed document vectors.
3. Pair the original query with each candidate document.
4. Inspect how the Cross-Encoder returns one relevance score per pair.
5. Sort the candidates and compare the order before and after reranking.
6. Measure both MRR and latency while changing K.
7. Decide whether the search improvement is worth the production cost.

## Check your understanding

1. Why is a Reranker normally applied after vector retrieval rather than to the whole database?
2. What does a Bi-Encoder return, and what does a Cross-Encoder return?
3. If Top K is 20, how many query-document pair evaluations are required?
4. Why can reranking improve the LLM's final answer even though it does not generate the answer itself?
5. Which measurements should be compared before enabling a Reranker in production?

