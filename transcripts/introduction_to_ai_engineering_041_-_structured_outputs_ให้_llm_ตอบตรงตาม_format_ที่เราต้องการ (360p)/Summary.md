# Introduction to AI Engineering - Structured Outputs for Reliable LLM Responses

**Format:** Thai-language lecture with English technical terminology  
**Source:** `introduction_to_ai_engineering_041_-_structured_outputs_ให้_llm_ตอบตรงตาม_format_ที่เราต้องการ (360p).mp4`

## Overview

This session introduces structured outputs as an important production feature for generative AI applications. A normal large language model can be prompted to return JSON or a particular category, but it may still produce invalid syntax or an unexpected shape. Structured output constrains the response to a declared schema, making the result predictable and easier to use in application code.

The examples use Google Gemini together with Pydantic `BaseModel` classes to define and validate response schemas.

## 1. Why Structured Output Matters

Prompting an LLM to "respond in JSON" does not by itself guarantee valid JSON. Possible failures include:

- Missing or unexpected fields
- Incorrect JSON syntax
- Values with the wrong type
- Additional prose surrounding the requested data
- A response that does not belong to one of the allowed categories

Even a relatively small failure rate is a serious problem in production because downstream code expects a stable contract. Structured outputs make model responses more deterministic by requiring them to conform to a specified schema.

This also reduces the amount of custom parsing code. Without structured output, developers may have to clean model text, convert strings into JSON, handle malformed responses, and extract each field manually.

## 2. Pydantic as the Schema Foundation

Pydantic is presented as the prerequisite for understanding the examples. A class inheriting from `BaseModel` describes the expected fields and Python types.

A simple validation model can require an integer:

```python
from pydantic import BaseModel

class Model(BaseModel):
    x: int
```

Creating the model with a valid integer succeeds. Passing an incompatible value causes a validation error. This ability to declare and enforce a data contract is what model-provider structured-output features build upon.

The session also revisits Python inheritance: a custom class inherits the validation behavior implemented by Pydantic's `BaseModel`.

## 3. Environment and Notebook Setup

The exercise uses the course repository section for RAG and AI agents. The setup includes:

1. Open the repository in VS Code.
2. Create a Conda environment using Python 3.11.
3. Activate the environment.
4. Install dependencies from `requirements.txt`.
5. Open the structured-output Jupyter notebook.
6. Select the newly created environment as the notebook kernel.
7. Load the Gemini API key from a `.env` file.

Representative commands:

```bash
conda create --name structured-output-tutorial python=3.11
conda activate structured-output-tutorial
pip install -r requirements.txt
```

The transcript assumes the Gemini API key setup was introduced in an earlier session.

## 4. Example: Extracting Who, What, Where, When, and Why

The first LLM example takes a news article and asks Gemini to summarize it into:

- `who`
- `what`
- `where`
- `when`
- `why`

A Pydantic response schema defines these fields. Gemini then returns a structured object rather than an unstructured text block.

The application can access fields directly, such as `.who` or `.what`, instead of using regular expressions or writing custom logic to locate each answer in free-form text. This makes the output ready for downstream application processing.

## 5. Example: Thai Food Grouped by Location

Another schema represents Thai food information with:

- `location` as a string
- `food` as a list of strings

The model is asked to list popular foods in Thailand based on location. The structured response can contain multiple location records, each with its own food list.

A related Bangkok example demonstrates why typed lists are useful. Because the `food` value is already a list, normal Python code can iterate over it immediately:

```python
for item in response.food:
    print(item)
```

Without structured output, the application would first need to parse a text response and convert it into a usable list or JSON object.

## 6. Constraining Classification Results

Structured output can also restrict a response to a fixed set of categories. The lecture describes a classification example where the model must choose one label from an allowed set.

This pattern is useful for tasks such as:

- News-category classification
- Intent detection
- Sentiment or topic labels
- Any workflow where downstream logic depends on a known set of values

The important point is not whether a model's classification is always semantically correct. The schema guarantees that its answer has the expected form and belongs to the declared choices.

## 7. Nested and More Complex Schemas

The final coding example combines schemas:

- A `Grade` type defines allowed grades such as `A+`, `A`, `B`, `C`, `D`, and `F`.
- A recipe model contains a recipe name and one of those grades.
- The model is asked to list ten cookies and grade each one based on taste.

The response therefore contains multiple structured recipe records, with each record holding a name and a constrained grade. This demonstrates that structured output can go beyond flat JSON and represent nested, production-oriented data models.

## Practical Exercise / Homework

Choose a newspaper article in Thai or another language. Use structured output to extract:

- Date
- Summary
- Title

The expected result should be a JSON-compatible structured object rather than free-form prose.

Suggested workflow:

1. Define a Pydantic `BaseModel` with `date`, `summary`, and `title`.
2. Provide the article text to Gemini.
3. Pass the Pydantic model as the response schema.
4. Run the request and inspect the typed fields.
5. Confirm that the result can be consumed directly by Python code.

## Takeaways / Action Items

- Do not rely only on prompt wording when production code requires valid JSON or fixed categories.
- Define the expected response contract with Pydantic types.
- Use structured output to reduce parsing, validation, and error-handling code.
- Access returned fields directly and iterate over typed lists using normal Python.
- Use constrained values for classification workflows.
- Combine models to represent nested and more complex application data.
- Complete the news exercise by extracting `date`, `summary`, and `title` into a structured response.
