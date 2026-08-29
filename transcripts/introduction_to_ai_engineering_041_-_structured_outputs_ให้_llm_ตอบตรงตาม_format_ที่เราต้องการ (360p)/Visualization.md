# Structured Outputs for Reliable LLM Responses

**Visual goal:** Understand how a Pydantic schema turns an unpredictable LLM text response into a typed contract that application code can consume safely.

[Read the detailed summary](./Summary.md)

## Big picture: from text request to typed data

```mermaid
flowchart LR
    A["Application prompt"] --> B["Gemini request"]
    C["Pydantic response schema"] --> B
    B --> D["Schema constrained generation"]
    D --> E["Validated structured object"]
    E --> F["Direct field access"]
    E --> G["Iteration over typed lists"]
    E --> H["Downstream workflow"]
```

A prompt can request JSON, but a schema defines the actual contract. The contract specifies field names, Python types, allowed values, and nested structures.

## Why prompt-only JSON is fragile

```mermaid
flowchart TD
    A["Ask model to return JSON"] --> B{"Output matches expectations"}
    B -->|No| C["Malformed syntax"]
    B -->|No| D["Missing or extra fields"]
    B -->|No| E["Wrong value types"]
    B -->|No| F["Extra prose"]
    B -->|Yes| G["Parse response"]
    C --> H["Custom cleanup and error handling"]
    D --> H
    E --> H
    F --> H
    H --> G
```

Structured output moves much of this defensive work into a declared schema and provider-supported response mechanism.

| Approach | Output guarantee | Application work |
|---|---|---|
| Free-form response | Natural language only | Interpret text manually |
| "Return JSON" prompt | Desired shape is suggested | Parse and handle malformed results |
| Structured output with Pydantic | Response must follow declared fields and types | Access validated values directly |
| Constrained category | Value must come from an allowed set | Route workflow using known labels |

## Pydantic is the contract layer

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant Schema as Pydantic BaseModel
    participant Gemini as Gemini
    participant App as Application code
    Dev->>Schema: Declare fields and Python types
    Dev->>Gemini: Send prompt plus response schema
    Gemini->>Schema: Produce schema shaped result
    Schema-->>App: Return validated object
    App->>App: Read fields and process lists
```

Python inheritance matters here. A custom model inherits validation behavior from `BaseModel`. For example, declaring `x: int` establishes that an acceptable instance must contain an integer-compatible value.

## Schema patterns shown in the lecture

```mermaid
flowchart TD
    A["Structured output patterns"] --> B["Flat extraction"]
    A --> C["Typed list"]
    A --> D["Constrained classification"]
    A --> E["Nested records"]
    B --> B1["who what where when why"]
    C --> C1["location plus food list"]
    D --> D1["one label from allowed choices"]
    E --> E1["cookie recipe plus grade"]
```

| Pattern | Example fields | What it enables |
|---|---|---|
| Flat extraction | `who`, `what`, `where`, `when`, `why` | Direct access such as `.who` |
| Typed collection | `location`, `food: list[str]` | Immediate Python iteration |
| Fixed choice | News, intent, sentiment, or topic label | Predictable routing value |
| Nested collection | Recipe name and constrained grade | Production-oriented multi-record data |

The grade example restricts values to choices such as `A+`, `A`, `B`, `C`, `D`, and `F`. The schema guarantees the form and allowed value, although it does not guarantee that the model's judgment is semantically correct.

## Production data path

```mermaid
stateDiagram-v2
    [*] --> DefineSchema
    DefineSchema --> SendRequest
    SendRequest --> ValidateResult
    ValidateResult --> ConsumeFields: Valid structure
    ValidateResult --> HandleError: Validation fails
    HandleError --> SendRequest: Revise request or retry
    ConsumeFields --> [*]
```

> **Mental model:** A prompt describes the task, while the schema defines the interface boundary. The LLM supplies values, Pydantic defines their shape, and ordinary Python code consumes the result.

## Visual learning path

1. Identify why free-form text is risky for downstream code.
2. Define the smallest Pydantic model that represents the needed answer.
3. Pass that model as the Gemini response schema.
4. Read fields directly instead of extracting them with regular expressions.
5. Add lists, allowed categories, or nested models as the application contract grows.
6. Practice with a news article schema containing `date`, `summary`, and `title`.

## Check your understanding

1. Why is asking for JSON not equivalent to enforcing a schema?
2. What behavior does a class inherit from Pydantic `BaseModel`?
3. Which schema pattern is appropriate for intent detection?
4. What can a constrained grade guarantee, and what can it not guarantee?
5. How does structured output reduce custom parsing code?
