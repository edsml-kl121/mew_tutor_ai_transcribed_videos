# Introduction to AI Engineering 04.06.02: Vanilla RAG vs Agentic RAG

**Format:** Thai-language conceptual explanation with English RAG terminology  
**Source:** `transcript.txt` in this lesson directory  
**Thai lesson title:** `Vanilla RAG และ Agentic RAG ต่างกันยังไง`

## Overview

This lesson compares **Vanilla RAG** with **Agentic RAG** using a simple question about bananas and apples.

Vanilla RAG follows a fixed retrieval pipeline for every question. Agentic RAG first asks a Large Language Model to decide what to search for, then allows the model to call the search tool repeatedly until it believes it has enough information to answer.

The agentic approach can improve retrieval for multi-part questions and provides a foundation for adding more tools later. Its costs are additional latency, token usage, model dependency, unpredictability, and testing difficulty.

## 1. Vanilla RAG

The example question is:

```text
Is there bananas and apples?
```

Assume the system has documents about bananas and apples. A typical Vanilla RAG pipeline is:

1. Receive the complete user query.
2. Convert the query into a vector with an **Embedding Model**.
3. Search a **Vector Database**.
4. Return the **Top K** matching resources.
5. Give the retrieved resources to a Large Language Model.
6. Generate the answer.

In compact form:

```text
Query -> Embedding Model -> Vector Search -> Top K Resources -> LLM -> Answer
```

The defining property is that the flow is **programmatic** and fixed. Regardless of the question, the query passes through the same retrieval sequence.

### Strengths

- Predictable execution path
- Easier testing
- Fewer LLM reasoning steps
- Lower latency and token cost
- Easier estimation of system behavior

### Limitation

The complete question is embedded and searched as one query. For a compound request such as bananas plus apples, one retrieval may not return enough balanced information about both subjects.

## 2. Turning Retrieval into a Search Tool

Agentic RAG wraps the familiar retrieval pipeline in a callable **search tool**.

The tool still performs the core RAG operations:

```text
Search query -> Embedding -> Vector Database -> Top K Resources
```

What changes is the caller. Instead of always passing the user's original query directly into retrieval, an LLM decides:

- What search query to send
- Whether the returned information is sufficient
- Whether another search is needed
- What the next query should be

The retrieval mechanism can remain similar while the control flow becomes agentic.

## 3. Agentic RAG

For the same bananas-and-apples question, the LLM might:

1. Inspect the user's request.
2. Search for information about bananas.
3. Review the Top K results.
4. Decide that apple information is still missing.
5. Search again for apples.
6. Combine the available information.
7. Return the answer.

The model can call the tool once, twice, or several times. The number and content of searches are not fixed in advance.

```text
User Query -> LLM -> Search Tool -> Results -> LLM
                                      ^        |
                                      |________|
                                  repeat if needed
```

This makes retrieval more deliberate because the model can decompose a compound question and refine its searches.

## 4. Advantages of Agentic RAG

### Potentially Better Retrieval

The system can search multiple times and use different queries. This may return more relevant or complete resources than embedding the entire original question once.

### Query Planning

The LLM reasons about what terms should be sent to the search tool. In the example, it can separate the banana and apple information needs.

### Foundation for More Actions

Once the system is designed around tools, it can later receive capabilities beyond search. The agentic pattern can become a foundation for systems that retrieve information and take other actions.

## 5. Costs and Risks of Agentic RAG

### More Latency

The LLM adds planning steps before and between searches. Multiple retrieval rounds also take longer than one fixed pass.

### Greater Token Cost

Each reasoning and tool-use cycle consumes tokens, making the LLM portion more expensive.

### Dependence on the Base Model

Accuracy relies on the base model's ability to plan, select useful queries, judge information sufficiency, and stop appropriately. A smaller model with fewer parameters may perform Agentic RAG less effectively.

### Less Predictability

Vanilla RAG always follows the same path. Agentic RAG may choose different searches or numbers of tool calls for similar requests.

### Harder Testing

Variable tool calls and model decisions increase the number of behaviors that tests must cover.

## 6. Side-by-Side Comparison

| Dimension | Vanilla RAG | Agentic RAG |
|---|---|---|
| Control flow | Fixed and programmatic | Chosen by an LLM |
| Initial retrieval query | Usually the user query | Model-generated search query |
| Search count | Typically one configured pass | One or many calls |
| Multi-part questions | May retrieve unevenly | Can decompose and search separately |
| Latency | Lower | Higher |
| Token use | Lower | Higher |
| Model dependency | Mainly answer generation | Planning, retrieval, stopping, and answering |
| Predictability | High | Lower |
| Testing | Easier | Harder |
| Extension to actions | Requires explicit workflow changes | Tool pattern supports additional actions |

## Practical Exercise

Use a knowledge base containing separate banana and apple documents:

1. Ask `Is there bananas and apples?` through a fixed Vanilla RAG pipeline.
2. Record the Top K results.
3. Wrap the same retriever as a `search_tool(query)` function.
4. Let an LLM choose search queries and call the tool again when information is missing.
5. Compare answer completeness, search count, latency, and token use.
6. Test whether the agent stops after enough evidence is available.
7. Repeat with a smaller base model and compare tool selection quality.

## Takeaways / Action Items

- Understand Vanilla RAG as a fixed query, embedding, vector search, Top K, and answer pipeline.
- Understand Agentic RAG as an LLM-controlled loop around a search tool.
- Use multiple searches when a question contains separable information needs.
- Measure whether better retrieval actually justifies extra model calls.
- Select the base model carefully because Agentic RAG depends on its reasoning accuracy.
- Add tests for query choice, repeat calls, stopping behavior, and final answer grounding.
- Expect higher latency, token use, expense, and operational uncertainty.
- Do not adopt Agentic RAG only because it is more flexible. Compare it with a simpler Vanilla RAG baseline.
