# Introduction to AI Engineering - Few-Shot Prompting

**Format:** Thai-language lecture with English technical terminology  
**Source:** `introduction_to_ai_engineering_042_-_few_shot_prompting (360p).mp4`

## Overview

This session revisits few-shot prompting, previously introduced conceptually in an earlier module, and shows how it appears in code. Few-shot prompting means giving an LLM example input-output pairs so it can infer the preferred task behavior, answer style, or format before responding to a new input.

The coding examples extend the structured-output setup from the previous session and use the Google Gen AI library.

## 1. Zero-Shot, One-Shot, and Few-Shot Prompting

The lecture distinguishes prompting approaches by the number of examples supplied:

- **Zero-shot prompting:** Give the instruction and new input without any examples.
- **One-shot prompting:** Give one example input and its desired output before the new request.
- **Few-shot prompting:** Give several examples, commonly two to five, before the new request.

For example, a zero-shot sentiment task might ask whether a customer review is positive or negative without showing any labeled reviews. A one-shot version supplies one labeled review. A few-shot version can include positive, neutral, and negative examples before asking the model to classify a new review.

## 2. How Examples Guide the Model

Few-shot prompts are represented as a sequence of conversation turns:

1. A `user` message contains an example input.
2. An `assistant` or model message contains the desired example output.
3. Additional user-assistant example pairs may follow.
4. The final `user` message contains the new input to process.

The model uses the earlier examples as context when predicting the final answer. In a three-example sentiment prompt, for instance, the examples demonstrate how the application expects positive, neutral, and negative reviews to be labeled.

The goal is not to train or permanently modify the model. The examples guide its behavior for the current request.

## 3. Benefits and Tradeoffs

### Benefits

- Responses are more likely to match the user's preferred format.
- Examples can clarify ambiguous instructions.
- The model can imitate a desired summary style or labeling convention.
- Developers can improve task behavior without training a new model.
- The technique applies to summarization, classification, extraction, and other tasks.

### Tradeoffs

- Every example consumes input tokens.
- More examples can increase per-request cost when pricing is based on tokens.
- Longer prompts use more of the model's context window.
- Examples must be representative and correctly labeled, or they may guide the model in the wrong direction.

## 4. One-Shot Summarization Example

The first coding example focuses on concise news summarization:

1. Supply a news article as an example user input.
2. Supply a manually prepared preferred summary as the example model output.
3. Send a different news article as the final user input.
4. Ask the model to summarize the new article.

With one example, the model tends to produce a response whose structure and style resemble the demonstrated summary.

The equivalent zero-shot version removes the example user-assistant pair and sends only the new article with the summarization instruction.

## 5. Two-Shot Summarization Example

The two-shot version follows the same pattern but includes two example article-summary pairs:

1. First example article and preferred summary
2. Second example article and preferred summary
3. New article to summarize

The model learns from both examples before generating the final summary. Additional examples can make the intended style more explicit and improve alignment with the required result.

## Practical Exercise

Create a small comparison using the same news article:

1. Run a zero-shot summarization prompt.
2. Add one high-quality article-summary example and run it as one-shot prompting.
3. Add a second example and run it as two-shot prompting.
4. Compare format, conciseness, consistency, and token usage across the three outputs.

A conceptual message layout is:

```python
messages = [
    {"role": "user", "content": example_article_1},
    {"role": "assistant", "content": preferred_summary_1},
    {"role": "user", "content": example_article_2},
    {"role": "assistant", "content": preferred_summary_2},
    {"role": "user", "content": new_article},
]
```

Use the role and message syntax required by the selected Google Gen AI API version.

## Takeaways / Action Items

- Use zero-shot prompting when the instruction alone is clear and sufficient.
- Add one example when the model needs a concrete target for style or format.
- Use a small set of representative examples when the task is ambiguous or output consistency matters.
- Structure examples as user input followed by the exact model output you want imitated.
- Compare quality gains against the additional token cost.
- Prefer clear, correct, and diverse examples rather than adding examples only for quantity.
- Consider few-shot prompting before investing in model retraining for a task that can be demonstrated effectively in context.
