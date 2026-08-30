# Few-Shot Prompting

**Visual goal:** See how example input-output pairs placed before a new request guide an LLM toward a desired behavior, label set, style, or format without retraining it.

[Read the detailed summary](./Summary.md)

## Big picture: examples become temporary guidance

```mermaid
flowchart LR
    A["Task instruction"] --> E["Prompt context"]
    B["Example input 1"] --> C["Preferred output 1"]
    C --> E
    D["Additional example pairs"] --> E
    F["New input"] --> E
    E --> G["LLM prediction"]
    G --> H["Output shaped by examples"]
```

Few-shot prompting changes the context for the current request. It does not train, fine-tune, or permanently modify the model.

## Zero-shot to few-shot spectrum

```mermaid
flowchart TD
    A{"Is the instruction alone clear"}
    A -->|Yes| B["Use zero-shot"]
    A -->|Mostly but style needs demonstration| C["Use one-shot"]
    A -->|Ambiguous or consistency matters| D["Use few-shot"]
    D --> E["Choose a small representative set"]
    E --> F["Compare quality with token cost"]
```

| Method | Examples before new input | Best fit |
|---|---:|---|
| Zero-shot | 0 | Clear task with sufficient instructions |
| One-shot | 1 | Concrete target for style or format |
| Few-shot | Commonly 2 to 5 | Ambiguous task, label coverage, or stronger consistency |

For sentiment classification, a useful few-shot set might demonstrate positive, neutral, and negative labels. For summarization, examples demonstrate the preferred length, organization, and tone.

## Message ordering is the mechanism

```mermaid
sequenceDiagram
    participant App as Application
    participant Model as LLM
    App->>Model: User example article 1
    App->>Model: Assistant preferred summary 1
    App->>Model: User example article 2
    App->>Model: Assistant preferred summary 2
    App->>Model: User new article
    Model-->>App: New summary following demonstrated pattern
```

Each demonstration is paired: a `user` example input is followed by the exact `assistant` output that should be imitated. The final `user` message contains the real input to process.

```mermaid
flowchart LR
    A["Correct representative examples"] --> B["Clear inferred pattern"]
    B --> C["More consistent response"]
    D["Incorrect or biased examples"] --> E["Wrong inferred pattern"]
    E --> F["Misleading response"]
    G["More examples"] --> H["More input tokens"]
    H --> I["Higher cost and context use"]
```

Example quality matters more than adding examples only for quantity. Examples should be correct, relevant, and diverse enough to clarify the expected behavior.

## One-shot and two-shot summarization

```mermaid
stateDiagram-v2
    [*] --> ZeroShot
    ZeroShot --> EvaluateZero: Summarize new article
    EvaluateZero --> OneShot: Add one article summary pair
    OneShot --> EvaluateOne: Summarize same new article
    EvaluateOne --> TwoShot: Add second pair
    TwoShot --> EvaluateTwo: Summarize same new article
    EvaluateTwo --> Compare
    Compare --> [*]
```

Compare the outputs on:

| Dimension | Question to ask |
|---|---|
| Format | Does the answer follow the demonstrated structure? |
| Conciseness | Is the summary close to the target length? |
| Consistency | Would repeated inputs produce similarly shaped answers? |
| Coverage | Do examples represent the task's important cases? |
| Token usage | Is the quality improvement worth the larger prompt? |

> **Mental model:** Examples are temporary demonstrations placed inside the model's working context. They act like showing, not training: "When the input looks like this, respond like that."

## Visual learning path

1. Start with a clear zero-shot instruction and record the result.
2. Add one high-quality input-output pair to make the target concrete.
3. Add a second representative pair only if it clarifies another important pattern.
4. Keep role ordering exact: user example, assistant answer, then new user input.
5. Compare quality, consistency, and token usage using the same test article.
6. Stop adding examples when extra prompt cost no longer produces meaningful improvement.

## Check your understanding

1. What distinguishes zero-shot, one-shot, and few-shot prompting?
2. Why must each example include both an input and its preferred output?
3. Does few-shot prompting permanently update model weights?
4. How can poorly labeled examples affect the final answer?
5. Why should token usage be included in the zero-shot versus few-shot comparison?
