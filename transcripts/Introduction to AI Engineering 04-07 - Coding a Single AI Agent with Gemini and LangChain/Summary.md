# Introduction to AI Engineering 04.07: Coding a Single AI Agent with Gemini and LangChain

**Format:** Thai-language hands-on coding lesson with English API and framework terminology  
**Source:** `transcript.txt` in this lesson directory  
**Primary technologies:** Gemini, Google API, LangChain, Streamlit, Flask, Python

## Overview

This hands-on lesson builds a **Single AI Agent** in two stages.

1. Use Google's Gemini API to understand basic function calling and tool selection.
2. Use LangChain to build a small retail chat application with a Streamlit frontend, a Flask backend, conversation memory, inventory search, and order processing.

The lesson begins with a scheduling function, expands to several tools and multi-step requests, and then demonstrates how a framework can simplify model integration and agent memory. The core engineering lesson is that tool descriptions, argument schemas, prompts, and conversation state determine whether an agent can select and call functions correctly.

## 1. Recap: What Is an AI Agent?

An AI Agent is described as a system that can **act autonomously** by deciding which tools to use to accomplish a task.

The lesson contrasts:

- **Programmatic** systems, which are predictable and easier to maintain because developers define the behavior
- **Agentic** systems, which are less predictable by design but can address more complex problems

The session focuses on a **Single Agent** that can:

- Receive a user request
- Plan what to do
- Select functions or tools
- Supply arguments
- Observe tool results
- Return a final response
- Remember earlier conversation through chat history

## 2. First Scenario: Schedule a Meeting

The first exercise asks the agent to schedule a meeting with specified attendees, date, time, and topic.

Example request:

```text
Schedule a meeting with Bob and Alice on the given date at 10 AM about Q3 planning.
```

The intended flow is:

1. The user sends the request.
2. Gemini identifies the `schedule_meeting` function.
3. Gemini extracts arguments such as attendees, date, time, and topic.
4. Python calls the function inside the notebook.
5. The function returns a success result.
6. Gemini produces the final user-facing confirmation.

The notebook uses a mock function rather than creating a real Google Calendar event. The instructor suggests that a real implementation could replace the mock logic with a Google Calendar API call.

## 3. Function Declarations and Tool Descriptions

The first low-level approach describes the function in a JSON-like declaration containing:

- Function name
- Description
- Input properties
- Expected argument types

Conceptually:

```python
def schedule_meeting(attendees, date, time, topic):
    print("Meeting scheduled")
    return "success"
```

The model uses the declaration to learn:

- When the function is relevant
- Which arguments are required
- How to map user language into those arguments

The instructor emphasizes that **descriptions are important**. Poor descriptions make correct tool selection and argument extraction less likely.

The exercise also demonstrates changing the request from Q3 planning at 10 AM to Q4 planning at 11 AM and checking whether the extracted arguments change correctly.

## 4. Simplified Gemini Tool Registration

The detailed declaration is useful for learning the mechanism, but it requires substantial code. A simplified Gemini pattern can register the Python function directly as a tool.

In that approach, Gemini can inspect the function and its description or docstring, reducing the need to maintain a separate schema manually. The agent still performs the same conceptual steps:

```text
User request -> tool selection -> argument extraction -> function call -> result -> final answer
```

## 5. Multiple Tools and Multi-Step Requests

The lesson introduces three mock tools:

- `schedule_meeting`
- `send_email`
- `get_contact`

### One-Tool Request

For a request such as finding Alice's email address, the agent selects `get_contact`, passes Alice as the argument, and returns the mock email result.

### Multiple Tool Calls

For a request to find Alice's email and schedule a meeting, the agent can:

1. Call `get_contact`.
2. Use the returned contact details.
3. Call `schedule_meeting`.
4. Return a combined result.

For a request to find Alice's email and send her a message, it can call `get_contact` and then `send_email`.

### Disco Ball Example

Another playful example gives the agent tools for party controls, such as music, lights, and a disco ball. A broad request to start the party allows the agent to infer that it should call all relevant tools without the user listing each operation.

These examples show autonomy at the tool-selection level rather than a fixed chain written by the user.

## 6. Why Use LangChain?

After demonstrating Google's API directly, the lesson rebuilds the idea with **LangChain**.

### Advantages

- A similar programming model can work with providers such as Google, AWS, Azure, and potentially Ollama.
- Switching models or providers may require fewer code changes.
- Built-in features can simplify memory and conversation history.
- The framework provides patterns for Single Agent and Multi-Agent development.
- Tool and function integration can require less boilerplate.

### Tradeoffs

- LangChain introduces additional complexity and dependencies.
- The library can be larger than a provider-specific client.
- It must adapt to upstream provider APIs.
- A direct provider API may be more stable or easier to debug at the lowest level.

The choice is between portability and framework assistance on one side, and directness and potentially greater stability on the other.

## 7. Retail Agent Application

The main application is a small retail assistant. A customer can:

- Search for products in stock
- Place an order
- Continue a conversation while the agent remembers earlier details

The architecture contains:

- **Streamlit frontend**
- **Flask backend**
- **LangChain agent**
- **Gemini 2 Flash**
- Inventory search tool
- Order processing tool
- Session-based chat history

## 8. Environment and Setup

The lesson works in an agent framework exercise folder with separate frontend and backend directories.

### Prerequisites

- A Gemini or Google API key in the environment
- Dependencies from each `requirements.txt`
- Separate Python environments for frontend and backend

Example environment flow shown in the lesson:

```bash
conda create --name frontend-agent-tutorial python=3.11
conda create --name backend-agent-tutorial python=3.11
conda activate frontend-agent-tutorial
pip install -r requirements.txt
```

Repeat dependency installation in the backend environment.

If `uv` is already installed, the instructor notes that it can be placed before the pip command to install faster.

### Start the Applications

Frontend:

```bash
streamlit run app.py
```

Backend:

```bash
python app_gemini.py
```

The backend example listens on port `8001`, and the frontend sends chat requests to it.

LangChain expects the key under a Google API key environment variable name. The lesson notes that it uses the same Gemini API key value configured earlier.

## 9. Retail Conversation Demo

### Search Inventory

The user asks which fruits are available. The agent:

1. Recognizes an inventory question.
2. Selects the grocery or inventory search tool.
3. Passes `fruit` as the tool input.
4. Receives the available items.
5. Returns the list in the frontend.

### Place an Order with Missing Fields

The user asks to order 15 apples and deliver them to Bangkok. The order tool needs more fields, including:

- Customer ID
- Customer name
- Address
- Product ID
- Quantity

The agent notices that customer ID and name are missing and asks the user for them. After the user provides an ID and the name `Mew`, the agent uses the conversation history, completes the arguments, and calls the order-processing tool.

This demonstrates why memory is important for multi-turn tool use.

## 10. Frontend Responsibilities

The Streamlit frontend:

- Receives user input
- Displays the accumulated conversation
- Maintains frontend message state for rendering
- Sends the user input and a session ID to the backend
- Displays the backend response

The core request includes:

```text
user_input
session_id
```

The session ID allows the backend agent to associate the request with the correct conversation history.

## 11. Backend Responsibilities

The Flask backend exposes a `/chat` endpoint. It:

1. Receives user input and session ID.
2. Creates or loads an agent with chat history for that session.
3. Runs the agent.
4. Allows the agent to call tools as needed.
5. Returns the final result to the frontend.

The instructor recommends considering **FastAPI** for a real implementation, while the demonstrated code uses Flask.

## 12. Prompt Design

The project includes a prompt file used to customize agent behavior beyond LangChain's defaults.

The prompt instructs the agent to follow a reasoning and tool-use format similar to:

```text
Question
Thought
Action
Action Input
Observation
Final Answer
```

It also adds use-case-specific instructions. For example, the order-processing tool should receive all required fields. If information is missing, the agent should ask the user rather than call the tool with incomplete arguments.

The lesson treats the system prompt as a central control point for the main agent.

## 13. Tool Implementation

The tool file contains two main tools.

### Inventory Search Tool

The tool is described as searching ingredients or products in the retail store. Its current underlying `semantic_search` implementation returns the available mock data rather than implementing a full search system.

The instructor notes that a real application should replace it with an actual search implementation.

### Order Processing Tool

The order tool accepts several fields:

- Customer ID
- Customer name
- Address
- Product ID
- Product quantity

The demonstrated function returns a confirmation rather than integrating with a real order system.

For both tools, the agent learns when and how to call them from:

- The main prompt
- Tool descriptions
- Tool input definitions

## Practical Exercises

- Run the notebook from beginning to end before changing it.
- Change the meeting time and topic, then inspect the generated function arguments.
- Replace a mock scheduling function with a real calendar integration in a controlled environment.
- Add or revise docstrings and observe how tool selection changes.
- Ask for a contact plus a scheduled meeting to trigger multiple tools.
- Run both Streamlit and backend services, then search for available fruit.
- Submit an incomplete order and confirm that the agent asks for missing fields.
- Continue the order in a second message and verify that session memory is used.
- Replace the mock inventory search with a real semantic search implementation.
- Add a new retail tool and update its description and required arguments.
- Compare direct Gemini function calling with the LangChain implementation.

## Takeaways / Action Items

- Learn direct function calling before relying on a framework.
- Write precise tool names, descriptions, input fields, and docstrings.
- Test argument extraction by varying dates, times, topics, names, and quantities.
- Use multi-step examples to verify that the agent can sequence tools.
- Keep consequential integrations mocked until the control flow is understood.
- Use session IDs and chat history for multi-turn tasks with missing information.
- Treat the system prompt and tool descriptions as part of application logic.
- Choose LangChain when portability, memory, and agent patterns justify added dependencies.
- Consider direct provider APIs when simplicity, stability, and low-level control matter more.
- Replace mock search and ordering functions before treating the demo as a production application.
