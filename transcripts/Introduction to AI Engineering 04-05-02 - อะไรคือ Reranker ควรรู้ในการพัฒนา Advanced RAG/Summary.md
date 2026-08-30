# Introduction to AI Engineering: What Is a Reranker in Advanced RAG?

**Format:** Thai-language conceptual lecture with code examples and English retrieval terminology  
**Authoritative source:** `transcript.txt` in this lesson directory  
**Lesson focus:** Reranker models, Cross-Encoders, search accuracy, and production tradeoffs

## Overview

This lesson explains how a **Reranker**, also called a **Cross-Encoder**, can improve a RAG search system after the initial vector retrieval stage.

A traditional RAG pipeline embeds a query, retrieves the nearest document vectors, and sends the resulting Top K chunks to an LLM. A RAG pipeline with a Reranker adds another stage: it scores the original query together with each retrieved document, reorders the candidates by relevance, and passes the improved ordering to the LLM.

The benefit is higher search accuracy. The cost is additional model inference, latency, compute resources, code, and potentially GPU requirements.

## 1. Traditional RAG Retrieval

In the traditional flow:

1. A user asks a question.
2. A **Bi-Encoder embedding model** converts the question into a vector.
3. The vector database compares it with document vectors that were precomputed and stored earlier.
4. The database returns the nearest Top K vectors and their associated chunks or metadata.
5. The selected chunks are sent to a Large Language Model.
6. The LLM answers using the retrieved context.

Embedding models mentioned include:

- BGE-M3
- Multilingual E5
- OpenAI text embedding models

The vector dimension depends on the selected model. The transcript uses 768 dimensions as an example.

This first-stage retrieval is efficient because document vectors are computed in advance and the query needs to be embedded only once.

## 2. What a Reranker Adds

A Reranker receives **two text inputs together**:

- The original query
- One candidate document

It returns a relevance score rather than an embedding vector.

If initial retrieval returns 10 candidate documents, the system forms 10 query-document pairs:

```text
(query, document 1)
(query, document 2)
...
(query, document 10)
```

The Cross-Encoder scores each pair. The application then sorts the documents by the new scores and sends the reordered or reduced result set to the LLM.

The Reranker does not replace initial vector retrieval. It refines a smaller candidate set produced by the embedding model.

## 3. Bi-Encoder Versus Cross-Encoder

### Bi-Encoder embedding model

- Accepts one text item at a time.
- Converts the text into a vector.
- Allows document vectors to be precomputed.
- Supports fast comparison across many stored vectors.
- Is used for broad first-stage retrieval.

### Cross-Encoder Reranker

- Accepts a query and a document together.
- Examines their relationship jointly.
- Returns a relevance score.
- Must run separately for each query-document pair.
- Is used for precise second-stage ordering.

This difference explains the common two-stage architecture: the Bi-Encoder retrieves candidates efficiently, then the Cross-Encoder evaluates those candidates more carefully.

## 4. RAG With a Reranker

The demonstrated advanced flow is:

1. Embed the user's question.
2. Search the vector database.
3. Retrieve an initial Top K candidate set, such as Top 10.
4. Pair the original query with each candidate.
5. Run every pair through the Reranker.
6. Receive one relevance score per pair.
7. Sort candidates by the Reranker scores.
8. Pass the newly ordered Top K documents to the LLM.
9. Generate the final answer.

The instructor's key claim is not that search becomes perfect, but that relevance ranking can improve.

## 5. Search Accuracy Example

The lesson presents an example metric comparison:

- Without a Reranker: MRR around `0.65`
- With a Reranker: MRR around `0.82`

This is used to illustrate the possible accuracy improvement from reranking. The exact gain depends on the models, data, queries, and evaluation setup.

**MRR**, or Mean Reciprocal Rank, rewards systems that place the first relevant result nearer the top of the result list.

## 6. Code-Level Model Behavior

### Embedding example

The BGE-M3 example accepts a sentence or an array of sentences and returns vectors. Developers can later calculate similarities among those vectors.

Conceptually:

```python
query_vector = embedding_model.encode(query)
```

### Reranker example

The Reranker accepts pairs:

```python
pairs = [
    ("What is panda?", "Hi"),
    ("What is panda?", "The giant panda, sometimes called...")
]

scores = reranker.compute_score(pairs)
```

The transcript reports example raw scores of approximately:

- Unrelated `Hi` document: `-8.1875`
- Relevant giant panda document: `5.26`

The second document should therefore rank above the first. The instructor also notes that raw scores can be scaled into a `0` to `1` range.

The important pattern is:

```text
query + candidate document -> Cross-Encoder -> relevance score
```

## 7. Why Two Stages Are Necessary

Using a Reranker against every document in a large collection would be expensive. If a database contains thousands of chunks, the system should not run the Cross-Encoder across all of them for every query.

Instead:

1. The embedding model quickly filters the full collection.
2. The Reranker carefully evaluates only the smaller candidate set.

This is a coarse-to-fine search strategy. Fast approximate relevance comes first, then slower precise relevance.

## 8. Compute and Latency Tradeoffs

For one user query:

- The embedding model computes the query vector once.
- The Reranker computes once per candidate document.

If `K` candidates are reranked, the Reranker performs `K` pair evaluations. Increasing K therefore increases:

- Computation
- Latency
- Resource usage
- Potential GPU demand

The transcript suggests that production systems may rerank 10 or 20 candidates rather than 100. These numbers are examples, not universal rules.

The design decision is a tradeoff:

| Choice | Likely effect |
|---|---|
| Smaller rerank candidate set | Lower latency and cost, but fewer candidates inspected closely |
| Larger rerank candidate set | More opportunities to recover relevant documents, but higher latency and compute |
| No Reranker | Simpler and faster pipeline, but initial vector ordering is unchanged |
| Add a Reranker | Better potential relevance ordering, with extra complexity and resources |

## 9. Production Decision Questions

Whether a Reranker is worthwhile depends on the use case. The lecture recommends considering:

- Is current retrieval accuracy insufficient?
- Does better ordering measurably improve final answers?
- How many candidates need reranking?
- What latency can users tolerate?
- Does the selected model require a GPU?
- Are the added infrastructure and code justified?

No single answer applies to every system. A Reranker is useful, but its value must be tested against production requirements.

## Practical Exercise

To explore the concept:

1. Select an embedding model and retrieve a small Top K candidate set.
2. Record the original vector-search order.
3. Form query-document pairs for every candidate.
4. Score the pairs with a suitable Cross-Encoder, including Thai support when needed.
5. Sort by the new scores.
6. Compare the original and reranked result order.
7. Measure retrieval quality with a metric such as MRR.
8. Measure latency for different values of K.
9. Decide whether the quality gain justifies the resource cost.

## Takeaways / Action Items

- Use a Bi-Encoder embedding model for fast first-stage retrieval.
- Use a Cross-Encoder Reranker to score the original query jointly with each candidate document.
- Rerank only a filtered Top K set rather than the entire knowledge base.
- Sort candidates by Reranker relevance before giving context to the LLM.
- Evaluate search quality with a retrieval metric instead of relying only on visual inspection.
- Measure latency and compute while changing K.
- Check Thai-language support when the query and document collection are Thai.
- Treat reranking as a production tradeoff between accuracy, speed, resources, and implementation complexity.

