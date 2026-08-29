# Introduction to AI Engineering 04.8: Human-in-the-Loop Routing with LangGraph

**Format:** Thai-language lecture with English technical terminology  
**Source:** `introduction_to_ai_engineering_048_-_human_in_the_loop_routing_with_langgraph_v1 (360p).mp4`

## Overview

This session introduces **routing with LangGraph** as a more controlled alternative to a fully autonomous AI agent. The instructor places routing between fixed programmatic logic and autonomous agents: Generative AI can classify intent and choose a route, while explicit rules and human confirmation govern important actions.

The main exercise builds a shopping assistant that distinguishes greetings from purchase requests, extracts requested products, searches mock inventory, asks the user to confirm a purchase, collects quantity, and then completes or cancels the order.

## 1. Why Routing and Human-in-the-Loop Matter

A single autonomous agent can select tools and take actions without asking the user. That is convenient, but its behavior is harder to predict. LangGraph is presented as a way to gain control when designing more complex agentic workflows.

The key design principles are:

- Use Generative AI where interpretation is useful, such as intent classification and product extraction.
- Use deterministic rules where choices should be constrained, such as accepting only `yes` or `no`.
- Pause for human confirmation before an important action, such as placing an order.
- Represent the workflow as nodes and edges so every possible transition is visible.

The instructor notes that LangGraph can cover routing, single-agent, and multi-agent systems. LangChain is convenient for a simple single agent, but LangGraph becomes especially useful when routing and controlled state transitions are required.

## 2. Shopping Assistant Workflow

The exercise supports two top-level user intents:

1. **Greeting**
2. **Product order**

The router uses a language model to classify the request. A greeting is sent to a greeting handler, which generates a response and ends the flow. An order request follows a longer path:

1. Route the request to the order path.
2. Extract one or more product names from the request.
3. Search for each product in mock inventory.
4. If no matching product exists, explain that it is unavailable and end the flow.
5. If a product exists, show its details and ask whether the user wants to order it.
6. Accept a constrained confirmation such as `yes` or `no`.
7. If confirmed, ask for quantity.
8. Complete the order and end the graph.

This separation combines AI-based interpretation with programmatic controls. It also makes the system's expected behavior easier to inspect than an agent that freely chooses and executes tools.

## 3. LangGraph State, Nodes, and Edges

The graph maintains state across the conversation. The demonstrated state includes information such as:

- The user's question
- The selected route
- Extracted product names
- Search results
- Purchase confirmation
- Quantity
- Messages and the current step

Mock product data is used for the exercise, including items such as apple, orange, pineapple, banana, grape, and milk.

Supporting functions handle:

- AI-based routing
- Greeting generation
- Product extraction
- Product search
- Confirmation
- Quantity collection
- Conversation termination

The graph-building function is the central part of the implementation:

- `add_node` registers stages such as router, greeting, extract, search, confirm, quantity, and end.
- Edges connect one node to the next and define the allowed flow.
- Conditional transitions determine which route is taken after classification, search, or confirmation.

The instructor emphasizes that adding nodes only draws the boxes. Adding edges is what defines how the workflow actually proceeds.

## 4. Notebook Setup and Demo

The example uses **LangGraph**, **LangChain**, and **Google Gemini 2.0**. The setup shown includes:

1. Open the course folders for the agent and LangGraph exercise.
2. Create a Python 3.11 environment named `langgraph`.
3. Activate the environment.
4. Install packages from `requirements.txt`.
5. Select the corresponding environment in the notebook.
6. Run and test the routing flow.

Demonstrated interactions include:

- `I want banana` routes to the order flow, extracts `banana`, searches inventory, asks for confirmation, collects quantity, and completes the order.
- Answering `no` exits the graph without ordering.
- `Hello` routes to the greeting handler and ends the conversation.
- A request containing multiple products can be split into separate items and searched sequentially.

## 5. Frontend and Backend Application

The same graph is connected to a simple application with separate frontend and backend folders. The backend uses **FastAPI**, while the frontend provides controls for entering or selecting responses.

The backend exposes two conceptual routes:

- **Start conversation:** begins a new graph execution from the user's initial message.
- **Continue conversation:** resumes from a paused state after the user supplies confirmation or quantity.

Two routes are necessary because the graph may pause in the middle of a workflow while waiting for human input. The backend returns the current status and state, then the frontend sends the next user response to continue from that point.

The application demo repeats the notebook scenarios:

- Ordering banana and confirming a quantity
- Sending a greeting
- Requesting products such as milk and bread

The instructor notes that the application code is intentionally not heavily refactored. The purpose is to show how the notebook graph maps into a working frontend and FastAPI backend.

## 6. Engineering Tradeoffs

Routing requires more development effort than a basic single agent because the developer must explicitly handle:

- State
- Branching logic
- Human input
- UI behavior
- Backend continuation
- Error and termination paths

The benefit is greater stability and predictability. The instructor observes that larger companies often favor routing for projects that need reliable delivery because controlled workflows are safer than highly autonomous behavior.

More autonomous agents may still be acceptable when occasional errors are tolerable. For use cases where errors are difficult to accept, the recommendation is to prefer routing and human checkpoints.

## Takeaways / Action Items

- Use LangGraph when a workflow needs visible states, explicit routes, or human approval.
- Combine LLM classification with deterministic rules rather than using Generative AI for every step.
- Model the complete flow before coding, including failure, cancellation, and completion paths.
- Practice creating nodes and edges for the greeting and order routes.
- Run the notebook examples for `I want banana`, `Hello`, confirmation, cancellation, and quantity.
- Trace how the frontend calls the FastAPI start and continue endpoints.
- Prefer controlled routing for production workflows where incorrect autonomous actions are unacceptable.
