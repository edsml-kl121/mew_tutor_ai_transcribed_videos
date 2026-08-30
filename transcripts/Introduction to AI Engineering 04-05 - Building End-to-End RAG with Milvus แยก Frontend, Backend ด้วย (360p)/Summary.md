# Introduction to AI Engineering - Building an End-to-End RAG Application with Milvus

**Format:** Thai-language lecture with English technical terminology  
**Source:** `introduction_to_ai_engineering_045_-_building_end_to_end_rag_with_milvus_แยก_frontend,_backend_ด้วย (360p).mp4`

## Overview

This hands-on session builds a complete retrieval-augmented generation, or RAG, application with separate frontend and backend services. The system uses:

- Streamlit for the frontend
- FastAPI for the backend
- Gemini for text embeddings and answer generation
- Milvus as the vector database
- Zilliz Cloud to host Milvus
- A five-page Thai HR leave-policy PDF as the source document

Most components run locally for the exercise, while the vector database is hosted in the cloud. As follow-up practice, the instructor recommends deploying the frontend and backend to public cloud URLs.

## 1. End-to-End Architecture

The application has two main journeys.

### Document ingestion journey

1. Load the source PDF.
2. Extract text page by page.
3. Split the text into smaller overlapping chunks.
4. Send each chunk to a Gemini text-embedding model.
5. Store the chunk text, embedding vector, and metadata in Milvus.
6. Build an index to support efficient vector search.

### User query journey

1. A user submits a question through the Streamlit frontend.
2. The frontend sends the question to the FastAPI backend.
3. The backend embeds the question with the Gemini embedding model.
4. Milvus searches for the closest document vectors.
5. The backend sends the retrieved document context and question to a Gemini language model.
6. The generated answer is returned to the frontend.

This separates the user interface, application logic, retrieval system, and hosted data layer.

## 2. Extracting and Chunking the PDF

The first folder used in the exercise is the extraction and chunking component. Its script processes the Thai HR policy PDF and generates two CSV files:

- One CSV containing content separated by PDF page
- One CSV containing smaller chunks derived from those pages

The transcript describes a chunk size of 1,000 characters with an overlap of 200 characters. Overlap preserves some neighboring context between chunks and reduces the risk of losing meaning at chunk boundaries.

The supporting Python functions perform two main jobs:

1. Load the PDF and save page-level text to CSV.
2. Split the page text into smaller chunks and save the chunk-level CSV.

Representative setup and execution:

```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python extraction_chunking.py
```

The resulting chunked Thai leave-policy data becomes the input to the ingestion stage.

## 3. Creating a Hosted Milvus Database

To avoid operating Milvus locally, the exercise uses Zilliz Cloud:

1. Create or sign in to a Zilliz Cloud account.
2. Create a free cluster.
3. Save the generated connection details.
4. Copy the public endpoint.
5. Add the required connection values to a `.env` file.

The environment contains values for the Zilliz URL and authentication token or credentials. These are loaded by the ingestion and backend code when connecting to the hosted Milvus instance.

Secrets should remain in `.env` and should not be hardcoded into application source.

## 4. Collection Schema

The ingestion code creates a collection named `milvus_collection`. The demonstrated schema contains four fields:

- `id`: Unique identifier
- `title`: Document or page title
- `chunk_content`: Text contained in the chunk
- `embedding`: Vector representation of the chunk

The embedding field uses 768 dimensions because that is the output size of the selected embedding model. The schema also declares maximum text lengths, including limits for the title and chunk content.

After collection creation, the script lists collections so the user can confirm that `milvus_collection` exists.

## 5. Embedding and Ingesting the Chunks

The ingestion script:

1. Loads the chunked CSV.
2. Iterates over the `chunk_content` values.
3. Calls an embedding function for each text chunk.
4. Receives a numeric vector from the Gemini embedding model.
5. Inserts the ID, title, chunk content, and embedding into Milvus.
6. Creates an index for later search.

Run the ingestion component from its folder after creating and activating its environment:

```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python ingestion.py
```

The Zilliz Cloud interface can then be used to inspect the collection, confirm its schema, and view the stored Thai policy chunks and vectors.

## 6. Vector Distance and Indexing Concepts

Vector databases use distance or similarity metrics to compare embeddings. The session mentions:

- `L2`, or Euclidean distance
- Cosine similarity
- `IP`, or inner product

For L2 distance, a lower value means the vectors are closer. In a semantic-search application, closer vectors are expected to represent more closely related meanings.

The instructor also contrasts search approaches:

- **FLAT:** Compare the query against all stored vectors.
- **IVF_FLAT:** Group vectors into clusters, search relevant clusters, and then search within those clusters.

Indexing is important because it reduces search time as the number of vectors grows. Rather than comparing a query with every vector, a clustered index narrows the search space. The lecture highlights indexing as both a practical system-design topic and a common technical-interview concept.

## 7. Testing Retrieval

The query script connects to Milvus, loads `milvus_collection`, embeds a search term, and returns documents with similarity scores.

A generic greeting such as `hello` produces unrelated results because it does not match the HR policy content. A more relevant Thai question, such as asking how many days of maternity leave a female employee receives, retrieves more related leave-policy chunks.

The instructor notes that retrieval quality depends strongly on the embedding model. The free Google `text-embedding-004` model is used for the exercise, but it is not presented as the strongest option for Thai text.

For production systems, compare embedding models using resources such as the Massive Text Embedding Benchmark, or MTEB, including Thai-specific leaderboards and models created for Thai-language retrieval.

## 8. Starting the FastAPI Backend

The backend service receives user questions, searches Milvus, supplies retrieved context to Gemini, and returns a generated answer.

From the backend folder:

```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
venv/bin/uvicorn app:app --host 0.0.0.0 --port 8000 --reload
```

The transcript uses the virtual environment's `uvicorn` executable directly when command resolution does not find the correct installation.

The backend exposes a chat endpoint on local port `8000`. Testing the endpoint confirms that the server can accept a question, perform retrieval, and return a response.

## 9. Starting the Streamlit Frontend

The frontend provides a simple interface for entering a question. It sends the question to the backend's local chat endpoint and displays the returned LLM answer.

From the frontend folder:

```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
streamlit run app.py
```

The backend and frontend run in separate terminals because both services must remain active.

The demonstration asks questions about employee leave, including Thai queries. The backend retrieves relevant policy chunks and Gemini summarizes the information into a more readable answer.

## 10. Limitations and Improvement Areas

The exercise prioritizes a working end-to-end architecture rather than maximum retrieval accuracy. Important limitations include:

- The selected embedding model is free but not optimized for Thai.
- Retrieval can return irrelevant content for vague or unrelated queries.
- Chunk size and overlap may require tuning.
- The frontend and backend remain local during the session.
- Better embedding models should be evaluated for Thai documents.

The architecture makes these parts replaceable. The embedding model, chunking strategy, vector index, prompt, frontend, and deployment target can each be improved independently.

## Takeaways / Action Items

- Reproduce the full ingestion path: PDF to pages, chunks, embeddings, and Milvus records.
- Use chunk overlap to retain context across boundaries.
- Keep the Milvus or Zilliz endpoint and credentials in `.env`.
- Verify collection fields and embedding dimensions before ingesting data.
- Understand the selected distance metric and index type.
- Test retrieval with realistic Thai policy questions, not only generic inputs.
- Evaluate Thai-capable embedding models with MTEB or comparable benchmarks.
- Run FastAPI on port `8000` and Streamlit in a separate terminal.
- Confirm that the frontend sends questions to the backend and displays grounded answers.
- As follow-up practice, deploy both services so the application is available through public URLs.
