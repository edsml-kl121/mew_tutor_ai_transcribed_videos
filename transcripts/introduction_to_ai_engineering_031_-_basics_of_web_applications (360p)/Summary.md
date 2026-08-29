# Introduction to AI Engineering: Basics of Web Applications

**Format:** Thai-language lecture with English technical terminology  
**Source:** `introduction_to_ai_engineering_031_-_basics_of_web_applications (360p).mp4`

## Overview

This session builds a basic AI web application from three layers: a Streamlit frontend, a FastAPI backend, and a Gemini model. It introduces REST APIs, separates frontend and backend dependencies into different environments, demonstrates each service independently, and then connects them into a working local chat interface.

Docker, containers, and deployment are introduced as the subject of the next part rather than implemented in this video.

## 1. Web Application Architecture

The target architecture contains:

1. **Frontend:** A Streamlit application that displays the user interface, accepts text, and shows replies.
2. **Backend:** A FastAPI service that receives requests and runs the application's business logic.
3. **AI layer:** A Gemini model called by the backend.

The frontend represents what the user sees, including titles, text, images, input controls, and buttons. The backend processes input and returns results.

As applications gain multiple services, each service should have its own `requirements.txt` and virtual environment. The Streamlit frontend and FastAPI backend therefore maintain separate dependency sets.

## 2. REST API Fundamentals

API means **Application Programming Interface**. It provides a defined way for one application to communicate with another. The previous Gemini call is used as a familiar example: Python sends a question to a hosted service and receives a response.

The lecture focuses on REST APIs and introduces common operations:

- `GET`
- `POST`
- `UPDATE`
- `DELETE`

The hands-on work mainly uses a `POST` request, which sends data to a server for processing.

An API request can include:

- **URL and path:** Identify the server and endpoint, such as `/append-hello` or `/chat`.
- **Protocol:** Commonly HTTP.
- **Headers:** Describe content and can carry authentication information.
- **Body:** Contains input data such as a user query.

## 3. Stage 1: Building the Streamlit Frontend

The first lab opens the `03 Web Application` course folder and works in the Stage 1 frontend directory.

### Environment setup

The instructor demonstrates both Conda and Python `venv` as valid options, then uses Conda for the lab:

```bash
conda create --name 0301-frontend python=3.11
conda activate 0301-frontend
pip install -r requirements.txt
```

The lightweight alternative is also reviewed:

```bash
python -m venv venv
```

### Running Streamlit

```bash
streamlit run app.py
```

The sample page contains a title, text, and an image. The instructor changes the title and replaces a remote image with a local photo, then saves and refreshes the page to see the changes.

Streamlit is presented as a convenient way to build a Python frontend without writing HTML directly. Its documentation includes examples for titles, captions, mathematical text, DataFrames, tables, charts, buttons, downloads, chat inputs, and data editors.

### Exercise

- Run the sample Streamlit application.
- Change the title and visible text.
- Replace the image with another remote or local image.
- Explore the Streamlit documentation and copy a component example into the page.

Stop the development server with `Ctrl+C`.

## 4. Stage 2: Building the FastAPI Backend

The backend lab uses a separate environment and requirements file:

```bash
conda deactivate
conda create --name 0302-backend python=3.11
conda activate 0302-backend
pip install -r requirements.txt
```

The FastAPI application defines an endpoint that receives a JSON body containing a text string and returns that text with `Hello` appended.

A Pydantic-style input class validates the request body. The field name and type must match the expected schema. Changing the expected key without changing the request causes validation to fail.

### Running the backend

For development, the demonstrated command uses automatic reload:

```bash
uvicorn app:app --reload --port 5000
```

The instructor notes that production startup should omit reload and bind to an appropriate host for a more stable service.

### Calling the endpoint

The endpoint is tested from another terminal with `curl`. The request includes:

- A localhost URL using port `5000`.
- The `/append-hello` path.
- A JSON content header.
- A JSON body such as `{"text": "World"}`.

Changing `World` to another name changes the returned result. The same endpoint is also called from a Python test script to show that clients are not limited to `curl`.

## 5. Stage 3: Connecting Frontend and Backend

The combined application uses at least two terminals:

- One terminal runs the frontend environment and Streamlit service.
- One terminal runs the backend environment and FastAPI service.

Each side installs its own `requirements.txt`. The frontend depends on Streamlit and a request library, while the backend includes FastAPI, Gemini-related packages, and environment-variable loading.

The frontend is started with:

```bash
streamlit run app.py
```

The backend is started with:

```bash
uvicorn app:app --reload --port 5000
```

If only the frontend is running, submitting a message produces a connection-refused error because nothing is listening at the backend URL. Once FastAPI is running, the frontend can send JSON to the `/chat` endpoint and display the reply.

### Request flow

1. The user enters text in the Streamlit chat input.
2. The frontend sends a POST request to `localhost:5000/chat`.
3. The JSON body contains the user's message.
4. FastAPI validates and processes the request.
5. The backend returns a JSON response.
6. Streamlit displays the reply.

The instructor first uses a hard-coded reply, then echoes the user's message to make the frontend-backend communication easy to observe.

## 6. Adding Gemini

The final step replaces the simple backend response with a Gemini-generated response.

1. Create or retrieve a Gemini API key from Google AI Studio.
2. Store it in a `.env` file.
3. Load the environment variable in the backend.
4. Configure the Gemini client and model.
5. Pass each new user message to Gemini.
6. Return Gemini's response to the frontend.

Keeping the API key in `.env` reduces the risk of leaking sensitive credentials in source code.

The completed application responds to prompts such as `How are you?` or a request for a bulleted list of places to eat in Thailand. The interaction resembles ChatGPT or Gemini, but it runs through the course's own frontend and backend services.

## Practical Exercise

Extend the chat application with conversation history:

- Store previous user and assistant messages in frontend session state.
- Append each new turn to the history.
- Display the accumulated conversation.
- Send sufficient history to the backend if the model needs conversational context.

The transcript frames this as optional homework for learners who have additional time.

## Takeaways and Action Items

- Separate frontend and backend dependencies and environments.
- Understand the roles of URL, path, HTTP method, headers, authentication, and request body.
- Practice running Streamlit and FastAPI in separate terminals.
- Test backend endpoints independently with `curl` or Python before connecting the UI.
- Diagnose connection-refused errors by checking whether the backend is running at the configured host and port.
- Store Gemini credentials in `.env`, not directly in code.
- Complete the chat-history extension.
- Continue to the next part for Docker packaging, container execution, and deployment.
