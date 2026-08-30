# Introduction to AI Engineering: Essential RAG Foundations Before Building AI Agents

**Format:** Thai-language conceptual lecture with English AI engineering terminology  
**Authoritative source:** `transcript.txt` in this lesson directory  
**Lesson focus:** Retrieval-Augmented Generation, search, embeddings, chunking, prompt augmentation, and generation

## Overview

This lesson introduces Retrieval-Augmented Generation, or RAG, as a practical foundation for production Generative AI systems and later AI Agent work. The instructor notes that many current production solutions still rely primarily on RAG, while organizations continue researching how to introduce AI Agents safely and effectively.

RAG is explained through three connected operations:

1. **Retrieval:** Search for relevant information.
2. **Augmented:** Add the retrieved information to the model input.
3. **Generation:** Ask a Large Language Model, or LLM, to generate an answer from that input.

The central example is an internal HR chatbot that answers employee questions from company policy documents.

## 1. Why RAG Is Needed

A general-purpose model such as ChatGPT or Gemini does not automatically know private company information. If an employee asks, "What types of leave are available?" the model needs access to the organization's actual HR policies.

RAG addresses this by searching the organization's knowledge base, retrieving policy passages about leave, and supplying those passages to an LLM before it answers.

### Main benefits

- **Access to private or domain-specific knowledge:** The model can answer from internal documents that were not part of its training data.
- **Lower risk of unsupported answers:** Relevant evidence gives the model a better basis than relying only on pretrained knowledge.
- **Better explainability:** The system can show which document passages contributed to an answer.
- **Reusable backend capability:** RAG commonly supports chatbots, including customer-service and internal organizational assistants, but is not limited to chatbot interfaces.

RAG reduces the opportunity for incorrect answers, but the transcript does not claim that it guarantees perfect accuracy.

## 2. The Three Parts of RAG

### Retrieval

Retrieval means searching for useful information. In the HR example, the system searches HR policy files for passages related to employee leave.

### Augmented

The retrieved search results are added to a prompt. This step connects the search system to the LLM and gives the model evidence relevant to the user's question.

### Generation

The LLM receives the question, instructions, and retrieved documents, then generates the final response. The lesson simplifies generation as text output, while acknowledging that generative models can produce other media.

## 3. The Knowledge Database

Retrieval requires a searchable information store, called a **knowledge database** in the lesson. It may contain many HR policy documents or other organizational records.

Without a knowledge database, the system has nothing authoritative to retrieve. Preparing and maintaining this source is therefore a core part of a RAG solution.

The source format can vary:

- PDF and Word documents can be extracted and divided into passages.
- Excel or other tabular data can be represented row by row, such as embedding a product name together with its description.
- Each searchable unit must remain small enough for the selected embedding model.

## 4. Semantic Search and Lexical Search

The lesson distinguishes two complementary search families.

### Semantic search

Semantic search finds text with similar meaning even when it does not contain the exact query words. A query about a Ferrari, for example, may match a document discussing high-speed cars because their meanings are related.

Semantic search typically relies on:

- An **embedding model**
- Numeric **vectors**
- A **vector database**

Vector-capable technologies mentioned include ChromaDB, Milvus, and Elasticsearch.

### Lexical search

Lexical search looks for words or textual patterns. A simple example is using `Ctrl+F` to locate an exact keyword.

The lesson also mentions **fuzzy search**, an approximate lexical technique that can still find a term when the user makes a small spelling mistake.

### Using both

Semantic and lexical retrieval can work together. Lexical methods preserve exact keyword matching, while semantic methods recover passages with related meaning.

## 5. Embeddings and Vector Similarity

An embedding model converts text into a multidimensional vector. Texts with similar meanings should be represented by vectors that are closer together.

The lecture compares:

- A user query such as "What types of leave are there?"
- A relevant document such as "There are seven types of leave..."
- An unrelated document about football

The query vector should be closer to the leave-policy vector than to the football vector. A vector database can use this relationship to return semantically relevant passages.

Example embedding model names mentioned include:

- `text-embedding-ada`
- `BGE-M3`

The instructor recommends consulting the **Massive Text Embedding Benchmark**, or **MTEB**, when selecting an embedding model. Model selection should consider the target language and retrieval task, not only general popularity.

## 6. Why Documents Must Be Chunked

Embedding models accept a limited number of tokens. A long PDF cannot always be embedded as one input, so it must be divided into smaller pieces called **chunks**.

Chunking serves two purposes:

1. Each chunk fits within the embedding model's token limit.
2. Retrieval can return a focused passage instead of an entire document.

For PDFs or Word files, text can be split across multiple chunks. For spreadsheets, each row or a combination of relevant columns can become a searchable unit, provided it fits within the model limit.

Chunk design affects retrieval quality. A chunk must be small enough for the model but large enough to preserve useful meaning.

## 7. Augmenting the Prompt

After retrieval, the application places the relevant passages into a prompt template together with the user's question.

A representative instruction from the lesson is:

```text
Please answer the question based on the provided documents.
Only use the information from the provided documents.
```

The developer then inserts the retrieved documents into the template and sends the completed prompt to an LLM.

Improving these instructions is part of **Prompt Engineering**. Developers adjust wording and structure so the model follows the desired behavior and produces more useful results.

Frameworks such as LangChain and LlamaIndex can help assemble RAG solutions, but the instructor emphasizes that they are not mandatory. Building the retrieval, prompting, and generation steps manually is recommended as a learning exercise before relying on abstractions.

## 8. Generation and Model Selection

The final stage selects an LLM to generate the answer. Models mentioned include:

- Mistral Large
- GPT-4o
- Claude 3.5
- Llama

The best model depends on the use case. For a Thai-language system, Thai capability should be evaluated directly through relevant benchmarks rather than assumed.

### Generation parameters

The lecture introduces several controls:

- **Minimum output tokens:** Lower bound for generated length.
- **Maximum output tokens:** Upper bound for generated length.
- **Temperature:** Controls how creative or variable generation is.
- **Top P and Top K:** Restrict the set of likely next tokens considered during generation.

The simplified mental picture is next-token prediction: the model evaluates possible following tokens and selects among them according to its probabilities and configured sampling parameters.

## 9. Practical Design Checklist

When beginning a RAG system:

1. Identify the authoritative knowledge sources.
2. Decide how PDFs, Word files, spreadsheets, or other records become searchable units.
3. Select an embedding model that supports the language and task.
4. Chunk content to fit the embedding model's token limit.
5. Store vectors and source content in a vector-capable database.
6. Combine semantic retrieval with lexical or fuzzy search when useful.
7. Add retrieved evidence to a clear prompt template.
8. Select an LLM suited to the output language and use case.
9. Tune prompt wording and generation parameters.
10. Preserve source references so answers can be explained.

## Takeaways / Action Items

- Treat RAG as a search-plus-generation system, not as a single model call.
- Build a trustworthy knowledge database before optimizing the chatbot interface.
- Learn the difference between semantic, lexical, and fuzzy search.
- Use embeddings to compare meaning, and evaluate candidate models through MTEB or language-specific benchmarks.
- Chunk long documents because embedding models have token limits.
- Ground the LLM with retrieved documents and explicit instructions.
- Try implementing the core pipeline manually before adopting LangChain, LlamaIndex, or similar frameworks.
- Evaluate the generation model for Thai-language quality when Thai is the production language.
- Keep retrieval evidence available for better explainability.

