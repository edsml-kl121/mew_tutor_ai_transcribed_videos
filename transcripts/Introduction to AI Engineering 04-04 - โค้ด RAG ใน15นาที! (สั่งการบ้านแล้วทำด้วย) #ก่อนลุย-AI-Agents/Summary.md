# Introduction to AI Engineering: Coding a Simple RAG Application in 15 Minutes

**Format:** Thai-language coding demonstration with English AI engineering terminology  
**Authoritative source:** `transcript.txt` in this lesson directory  
**Tools demonstrated:** Jupyter Notebook, Gemini models, Python, and Streamlit  
**Demo domain:** Restaurant recommendation from a small prepared document collection

## Overview

This lesson turns the previous RAG concepts into a small working application. The demonstration uses a collection of restaurant descriptions as the knowledge base and answers questions such as:

```text
Do you have Indian food?
```

The instructor first walks through the full flow in a Jupyter Notebook, then reuses the same logic inside a simple Streamlit web application. The goal is clarity rather than production-grade design or visual styling.

## 1. RAG Flow Used in the Demo

The application follows the three-part RAG pattern:

1. **Retrieval:** Search the restaurant documents for entries related to the user query.
2. **Augmented:** Place the query and retrieved restaurant context into a prompt.
3. **Generation:** Ask Gemini to generate the final recommendation or answer.

Before any user query can be served, the application also performs an ingestion-like preparation step: it embeds every restaurant document and stores the resulting vectors.

## 2. Demo Knowledge Base

The source data is a small, already-cleaned collection of restaurant information. It includes multiple cuisines, such as:

- Italian food
- Thai food
- Northeastern Thai food
- Indian food

The notebook uses **10 restaurant documents**. Because the data is deliberately small and prepared in advance, the lesson does not cover document extraction or chunking.

In a real application, the collection would likely be much larger and would require a persistent vector database.

## 3. Gemini Setup

The demo uses Google Gemini because the instructor describes the required API access as free for this exercise. A Gemini API key is required before running the model calls.

Two model capabilities are used:

- An embedding model converts restaurant text and user queries into vectors.
- Gemini Flash generates the final natural-language response from the augmented prompt.

The lesson focuses on the pipeline rather than key-management implementation details.

## 4. Creating Restaurant Embeddings

The notebook calls a function that creates embeddings for the restaurant documents.

The observed result has:

- 10 document embeddings
- 768 dimensions per embedding

Conceptually:

```python
restaurant_embeddings = create_restaurant_embeddings(restaurants)
```

Each restaurant description becomes an array of numeric values. Those vectors are kept **in memory** inside the Jupyter Notebook for this learning exercise.

The instructor contrasts this with production systems, where embeddings would normally be stored in a vector database such as:

- ChromaDB
- Milvus
- FAISS
- Elasticsearch

## 5. Embedding and Searching a User Query

When a user enters a query such as `Indian Food`, the code:

1. Converts the query into a 768-dimensional vector using the same embedding approach.
2. Compares the query vector with all 10 restaurant vectors.
3. Calculates a similarity score for each restaurant.
4. Sorts or selects the strongest matches.
5. Returns the top matching restaurant descriptions.

This is **semantic search**. The system is comparing vector meaning rather than requiring an exact text match.

The restaurant whose description includes relevant Indian cuisine receives a higher similarity score than unrelated restaurants.

## 6. Why Retrieval Happens Before Generation

It would be possible to place every restaurant document directly into the LLM prompt, especially in a tiny demo. The lesson explains why retrieval remains useful:

- Real collections contain far more documents.
- LLMs have a limited context window.
- Sending only relevant documents is more efficient.
- Focused context gives the generation model a clearer evidence set.

RAG therefore searches first and sends only selected context to the generative model.

## 7. Prompt Augmentation

The generation function receives:

- The original user query
- The restaurant document or documents returned by semantic search
- A system instruction describing the model as a helpful restaurant recommender

The transcript includes an instruction similar to:

```text
Please provide a helpful response that directly answers the user query.
```

The query and retrieved restaurant information are inserted into the prompt. Gemini Flash then generates the final result.

Conceptually:

```python
query = "Do you have Indian food?"
restaurants = search_restaurants(query, restaurant_embeddings)
answer = generate_response(query, restaurants)
```

The demonstrated answer identifies the restaurant associated with Indian food and provides a direct recommendation.

## 8. Reusing the Pipeline in Streamlit

After validating each stage in Jupyter, the same functions are reused in a Streamlit application.

The app has a simple flow:

1. Load the application.
2. Embed the restaurant collection.
3. Accept a user query.
4. Search for related restaurant documents.
5. Show the retrieved result.
6. Generate and display the final response.

The application is started with:

```bash
streamlit run app.py
```

The lesson notes that the restaurant embeddings are cached. Refreshing the page can therefore reuse the prepared vectors instead of recomputing them every time.

## 9. Notebook-to-App Mapping

The Streamlit version does not introduce a different RAG architecture. It packages the notebook steps behind a user interface.

| Notebook step | Streamlit behavior |
|---|---|
| Define restaurant documents | Load the application knowledge |
| Create embeddings | Prepare or reuse cached vectors |
| Enter a query in a cell | Enter a query in the web interface |
| Run semantic search | Retrieve relevant restaurant context |
| Call the response function | Generate and display the answer |

This progression is useful for learning: first inspect each operation directly, then wrap the proven functions in an application.

## 10. Scope and Production Limitations

The demonstration intentionally simplifies several areas:

- Embeddings are kept in memory rather than a persistent vector database.
- The collection contains only 10 prepared documents.
- The lesson does not cover extraction or chunking.
- Search uses a basic similarity workflow.
- The Streamlit UI is intentionally minimal.
- Production retrieval may use more advanced search techniques.

The application is a teaching implementation, not a complete production architecture.

## Practical Exercise

The instructor assigns follow-up experimentation:

1. Reproduce the notebook pipeline.
2. Replace the restaurant documents with a different small document collection.
3. Ask several different questions.
4. Observe which documents receive the strongest similarity matches.
5. Confirm that the retrieved context appears in the generated response.
6. Move the tested functions into the Streamlit app.
7. Check that cached embeddings are reused after refreshing the app.

The central exercise is to learn by modifying the documents and queries, not only by running the provided example unchanged.

## Takeaways / Action Items

- Validate RAG stages separately in a notebook before building the user interface.
- Embed documents once, then embed each user query with the same embedding approach.
- Compare query and document vectors to perform semantic retrieval.
- Retrieve only useful context to conserve the LLM context window.
- Put the original query and search results together in the generation prompt.
- Reuse working notebook functions inside Streamlit rather than rewriting the logic.
- Cache stable document embeddings so the app does not recompute them on every refresh.
- Replace in-memory storage with a production-grade vector database when the dataset and deployment require persistence or scale.
- Complete the exercise by changing both the source documents and the questions.

