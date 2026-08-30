# Introduction to AI Engineering: Applications of Python

**Format:** Thai-language lecture with English technical terminology  
**Source:** `introduction_to_ai_engineering_022_-_applications_of_python (360p).mp4`

## Overview

This session moves from basic Python syntax to practical use of third-party libraries. It covers project setup with a virtual environment, local Jupyter notebooks, web scraping with Beautiful Soup, introductory HTML, Gemini API usage, Generative AI concepts, prompt engineering, pandas data processing, and a short NumPy performance comparison.

## 1. Using Python Libraries

Developers do not need to build every capability from scratch. Python libraries provide reusable implementations for common tasks:

- **pandas:** Tabular data and DataFrame operations.
- **NumPy:** Fast numerical computation backed by optimized lower-level code.
- **Generative AI libraries:** Programmatic access to models such as Gemini or ChatGPT-style systems.
- **Beautiful Soup:** Parsing HTML for web-scraping tasks.
- **Selenium:** Browser automation for cases that require interaction with a real browser.

Library documentation provides installation instructions, API references, examples, and version information. The instructor stresses that package versions matter because libraries evolve and incompatible dependencies can conflict.

## 2. Local Project and Environment Setup

The hands-on work uses the course GitHub repository, specifically the `02 Applications of Python` material. Unlike the previous Colab-based lesson, this session runs notebooks locally in VS Code.

The demonstrated Conda workflow is:

```bash
conda create --name lab2-application-of-python python=3.11
conda activate lab2-application-of-python
pip list
pip install -r requirements.txt
```

The requirements include packages for Beautiful Soup, Google Generative AI, `.env` loading, JupyterLab, notebooks, and NumPy. pandas is installed separately when needed.

The instructor explains why `pip list` contains more packages than the top-level requirements: each listed library can depend on additional libraries. For production-grade work, dependency versions should be specified to reduce conflicts.

To run the local notebook, select the newly created Python environment as the notebook kernel and execute cells with `Shift+Enter`.

## 3. Python Module Warm-up

The session reviews importing a function from another Python file. A `say_hi`-style function returns `Hello World`, and the notebook imports and calls it.

### Exercise

Create an `addition(a, b)` function in the function module, return `a + b`, import it into the notebook, and call it. If the notebook does not see a newly added function, restart the kernel and rerun the cells.

## 4. HTML and Web Scraping

Web scraping is introduced as extracting useful information from websites. The instructor notes two broad approaches:

- Parse a site's HTML with a library such as Beautiful Soup.
- Use browser automation such as Selenium when navigation and interaction are required.

### HTML basics

An example HTML page is opened locally and edited. Important elements include:

- `<title>` for the browser page title.
- `<body>` for visible page content.
- Heading tags for headings.
- `<p>` for paragraphs.
- `<img>` for images.

The exercise changes the title, visible text, and image, then reloads the page to see the result.

### Beautiful Soup demo

The notebook requests a web page, receives its HTML, and uses Beautiful Soup to locate useful elements such as the page title. Browser developer tools and Inspect Element are used to connect the visible page with its underlying HTML structure.

The instructor then demonstrates scraping a real Thai news page from **Naewna**, including its Thai headline and publication information. This preserves the practical Thai-language context rather than using only English sample pages.

### Exercise

Choose another URL, retrieve its HTML, and extract a useful element such as the title or headline. Consult the Beautiful Soup documentation to explore additional parsing methods.

## 5. Calling the Gemini API

The session creates a Gemini API key through Google AI Studio and stores it in a `.env` file rather than placing it directly in notebook code. The key identifies and controls access to the service, including any usage limits or billing.

The notebook loads the key, configures a Gemini Flash model, and sends a simple prompt. This demonstrates how a Python library can provide access to a hosted AI service.

## 6. Generative AI Foundations

Generative AI is presented as one part of the broader AI field. It generates new content such as text or images, while discriminative or traditional AI commonly predicts, classifies, or forecasts.

### Foundation models

A foundation model is pretrained once and can perform many tasks, such as summarization, question answering, and content generation. A traditional model such as a Random Forest is usually trained for one narrower task.

### Ways to adapt model behavior

- **Zero-shot prompting:** Ask the model to perform a task without examples.
- **Few-shot prompting:** Include several input and expected-output examples.
- **Fine-tuning:** Adapt the model with a larger task-specific dataset.

The recommendation is to begin with zero-shot or few-shot prompting because pretrained models already support many tasks. Fine-tuning requires more data and effort, can affect generalization, and is more relevant when an enterprise needs stronger specialization or cost optimization.

### Example Generative AI tasks

- Document summarization.
- Email or LinkedIn content generation.
- Entity extraction, such as names, totals, dates, or invoice items.
- Document classification.
- Question answering over text or scraped HTML.
- Retrieval-Augmented Generation for adding organizational or current information.
- AI agents that take actions, such as searching or booking a calendar event.

RAG and AI agents are mentioned as later-course topics rather than covered in depth here.

## 7. Prompt Engineering

Prompt engineering is defined as iteratively designing model input so that the output meets the intended need. It is experimental and often involves comparing prompt variants through evaluation or A/B testing.

The conversation structure is explained through three roles:

- **System:** Defines the assistant's purpose, behavior, and characteristics.
- **User:** Contains a user's request or input.
- **Assistant:** Contains the model's response.

For few-shot sentiment classification, the system prompt restricts output to `positive`, `neutral`, or `negative`. Several user and assistant examples demonstrate the expected labels before the model receives a new review to classify.

### Generation settings

- **Temperature:** Controls how creative or variable responses are.
- **Top-p and top-k:** Restrict the candidate tokens considered during generation.
- **Maximum output tokens:** Limits response length.

The instructor notes that Thai text may use tokens differently from English, sometimes representing smaller text units rather than approximately one full English word.

## 8. Combining Scraping with Generative AI

The scraped HTML is sent to Gemini for flexible tasks such as:

- Summarizing the page.
- Extracting its title.
- Answering when the source was published.
- Listing foods in Bangkok.
- Generating a short story.

This is contrasted with deterministic Beautiful Soup parsing. Beautiful Soup precisely selects known HTML elements, while Generative AI can answer varied natural-language questions about the content.

## 9. pandas DataFrames

The instructor creates a DataFrame with `name`, `age`, and `city` columns, then demonstrates:

- Displaying the table.
- Filtering rows, such as people older than 25.
- Producing descriptive statistics such as mean and standard deviation.
- Getting unique values from a column.
- Saving results to CSV with `to_csv()`.
- Loading CSV data back into a DataFrame.
- Building a DataFrame from dictionary-shaped data.

pandas and SQL are identified as important foundations for data analyst work.

## Practical Assignment

Select three Thai news articles and build a small data pipeline:

1. Retrieve each article's raw HTML with the scraping approach covered in the lesson.
2. Use Generative AI to summarize each article.
3. Record the news provider, such as Naewna or another chosen source.
4. Record the time when the scraping code runs.
5. Use Generative AI to extract the article's publication date.
6. Store the results as three rows in a pandas DataFrame.
7. Save the final result as a CSV file.

Two additional LeetCode exercises are recommended to improve Python fluency and prepare for technical interviews.

## 10. NumPy Performance Bonus

NumPy is shown as an example of using optimized native computation from Python. In the demonstration, applying a power operation over 100 million values takes about 6 seconds with a regular Python approach and about 0.43 seconds with NumPy.

The practical lesson is to research optimized libraries when production code has a genuine performance bottleneck rather than assuming all Python operations must remain slow.

## Takeaways and Action Items

- Learn to find, install, read, and apply third-party library documentation.
- Keep each project in an isolated environment and pin dependency versions for production work.
- Complete the module-import warm-up and web-scraping exercise.
- Keep API keys outside source code in a `.env` file.
- Practice zero-shot and few-shot prompting before considering fine-tuning.
- Complete the three-article Thai news scraping, summarization, extraction, DataFrame, and CSV assignment.
- Try the recommended LeetCode exercises.
- Use pandas for tabular workflows and NumPy when vectorized numerical performance matters.
